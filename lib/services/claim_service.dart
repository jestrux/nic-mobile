import 'dart:convert';
import 'dart:ffi';
// import 'dart:html';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import "package:http/http.dart" show MultipartFile;

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/models/claim_model.dart';
import 'package:nic/services/data_connection.dart';
import 'package:nic/utils.dart';

class ClaimService {
  String? startCursor = "";
  String? endCursor = "";
  bool? hasNextPage = false;
  bool? hasPreviousPage = false;
  bool hasError = false;
  bool isLoading = false;
  bool? start = true;

  Future<ClaimModel?> getClaim(String? searchKey) async {
    ClaimModel? claim;
    String dataMap = r"""
        query( $searchKey: String!){
          allClaimants(searchKey:$searchKey){
            edges{
              node{
                id,
                status,
                claimantNumber,
                claimantStatus,
                claimType,
                claimSurrender,
                isPolicyHolder,
                claimantClaimAmount,
                claimantNetPayable,
                displayName,
                created,
                claim {
                  id,
                  claimNumber,
                  claimStatus
                  notification {
                    id,
                    notificationNumber,
                    propertyName
                  },
                },
                corporate {
                  id,
                  name
                },
              }
            }
          }
        }
  """;

    final QueryOptions options = QueryOptions(
      document: gql(dataMap),
      variables: {"searchKey": searchKey},
    );
    GraphQLClient client = await DataConnection().connectionClient();
    final QueryResult result = await client.query(options);

    var results = result.data?['allClaimants']?['edges'];

    if (results?.length < 1) {
      devLog('Policy documents: GraphQL Error: ${result.exception.toString()}');
      throw ("No claims matching to fetch documents. Please try again.");
    }

    var c = result.data!['allClaimants']['edges'][0]['node'];
    return ClaimModel(
      claimantNumber: c['claimantNumber'],
      claimNumber: c['claimNumber'],
      displayName: c['displayName'],
      claimantStatus: c['claimantStatus'],
      propertyName: c['claim']['notification']['propertyName'],
      intimationDate: c['created'],
      claimAmount: c['claimantClaimAmount'],
      netPayable: c['claimantNetPayable'],
      corporate: c['corporate'] != null ? c['corporate']['name'] : '',
    );
  }

  Future<Map<String, dynamic>?> initiateReportClaim(
      String? registrationNumber) async {
    String dataMap = r"""
      mutation ($registrationNumber: String!,$underwriteChannel: Int!) {
        initiateReportClaim(registrationNumber: $registrationNumber,underwriteChannel:$underwriteChannel) {
          success
          message
          proposal
          product
        }
      }
    """;

    final QueryOptions options = QueryOptions(
      document: gql(dataMap),
      variables: {
        "registrationNumber": registrationNumber,
        "underwriteChannel": 2
      },
    );

    GraphQLClient client = await DataConnection().connectionClient();
    final QueryResult result = await client.query(options);

    if (!(result.data?['initiateReportClaim']?['success'] ?? false)) {
      devLog('Initiate claim: GraphQL Error: ${result.exception.toString()}');
      throw ("Failed find your insured item, communicate with NIC nearest branch.");
    }

    var payLoad = result.data!['initiateReportClaim'];

    return {
      "success": payLoad['success'],
      "message": payLoad['message'],
      "product": payLoad['product'],
      "proposal": payLoad['proposal'],
      "form": await reportClaimForm(product: payLoad['product'])
    };
  }

  Future<dynamic> reportClaimForm({int? product}) async {
    String dataMap = r"""
      query ($product: Int!,$underwriteChannel:Int!) {
      reportClaimForm(product: $product,underwriteChannel:$underwriteChannel)
    }
    """;

    final QueryOptions options = QueryOptions(
      document: gql(dataMap),
      variables: {"product": product, "underwriteChannel": 2},
    );
    GraphQLClient client = await DataConnection().connectionClient();
    final QueryResult result = await client.query(options);

    if (result.exception != null) {
      print(result.exception);
    }

    List<dynamic>? allForm;

    var allFormResponse = result.data!['reportClaimForm'];

    if (allFormResponse == null) {
      throw ("Failed to fetch claim report form. Please try again later.");
    }

    allForm = List.from(jsonDecode(
      jsonDecode(allFormResponse),
    ))
        .map((e) => List.from(e["fields"] ?? []))
        .expand((field) => field)
        .toList();

    return allForm;
  }

  Future<Map<String, dynamic>?> submitClaimForm({
    required int proposal,
    required List<dynamic> data,
  }) async {
    ClaimModel? claim;
    String dataMap = r"""
      mutation ($proposal: Int!, $data: JSONString!,$underwriteChannel:Int!) {
        reportClaim(proposal: $proposal, data: $data,underwriteChannel:$underwriteChannel){
        success
        message
        notification
        notificationId
        propertyName
        startDate
        endDate
        notificationDate
        claimForm
        acknowledgementDocument
        }
      }
    """;

    final QueryOptions options = QueryOptions(
      document: gql(dataMap),
      variables: {
        "proposal": proposal,
        "data": jsonEncode(data),
        "underwriteChannel": 2
      },
    );
    GraphQLClient client = await DataConnection().connectionClient();
    final QueryResult result = await client.query(options);
    if (result.exception != null) {
      print(result.exception);
    }

    if (result.data != null) {
      var payLoad = result.data!['reportClaim'];
      // return reportClaimForm(product: payLoad['product']);
      if (payLoad != null) {
        return {
          "success": payLoad['success'],
          "message": payLoad['message'],
          "notification": payLoad['notification'],
          "notificationId": payLoad['notificationId'],
          "propertyName": payLoad['propertyName'],
          "startDate": payLoad['startDate'],
          "endDate": payLoad['endDate'],
          "notificationDate": payLoad['notificationDate'],
          "claimForm": payLoad['claimForm'],
          "acknowledgementDocument": payLoad['acknowledgementDocument'],
        };
      }
    }

    return null;
  }

  Future<Map<String, dynamic>?> uploadImagesService(
    Map<String, dynamic> images, {
    required int notificationNumber,
  }) async {
    String dataMap = r"""
       mutation ($fileName: String!, $filePath: Upload!,$notificationId: Int!, $underwriteChannel:Int!) {
        uploadClaimNotificationDocumentFolder(fileName: $fileName, filePath: $filePath,notificationId:$notificationId,underwriteChannel:$underwriteChannel){
        success
        message
        }
      }
    """;

    Map<String, dynamic> failedFiles = {};

    for (var file in images.entries) {
      var options = QueryOptions(document: gql(dataMap), variables: {
        "fileName": camelToSentence(file.key),
        "filePath": file.value,
        "notificationId": notificationNumber,
        "underwriteChannel": 2,
      });

      try {
        GraphQLClient client = await DataConnection().connectionClient();
        final QueryResult result = await client.query(options);

        var response = result.data?['uploadClaimNotificationDocumentFolder'];

        if (response == null || response["success"] ?? false) {
          throw ("Failed to renew policy. Please try again later.");
        }

        var initiateProposalResponse = result.data?['initiateProposal'];

        if (initiateProposalResponse == null ||
            !(initiateProposalResponse?['success'] ?? false)) {
          throw ("Failed to purchase product. Please try again later.");
        }

        if (result.exception != null) {
          print(result.exception);
        }
      } catch (e) {
        devLog("Failed to upload claim images/files");
      }
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> fetchClaims() async {
    String query = r"""
    query ($underwriteChannel:Int!){
        allClaimant(underwriteChannel: $underwriteChannel) {
          edges {
            node {
              id
              displayName
              claimantNumber
              insuredItem
              claimedBenefit
              claimantStatus
              claimantNetPayable
              created
              canUpload
            }
          }
        }
      }
    """;

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: const {'underwriteChannel': 2},
    );

    GraphQLClient client = await DataConnection().connectionClient();
    final QueryResult result = await client.query(options);

    if (result.data == null) {
      devLog("Request control number: No data found");
      throw ("Failed to fetch payment. Please try again later.");
    }

    if (result.data?['allClaimant']?['edges'] == null) {
      devLog('allClaimant: GraphQL Error: ${result.exception.toString()}');
      throw ("Failed to fetch pending proposals. Please try again.");
    }

    return List.from(result.data!['allClaimant']['edges'])
        .map<Map<String, dynamic>>(
      (element) {
        var claim = element["node"];
        var claimAmount =
            formatMoney(claim['claimantNetPayable'], currency: "TZS");
        var description = List<String?>.from(
                [claim['claimedBenefit'], claimAmount.toString()])
            .where((element) => element != null)
            .toList()
            .join(" - ");

        return {
          ...claim,
          "title": claim['insuredItem'],
          "description": description,
        };
      },
    ).toList();
  }

//
//   Future<bool> getClaimants(
//       {String? cursor,
//         bool? start,
//         int? pageIndex,
//         List<String>? allowedStatus}) async {
//     this.start = start;
//     late var boxPageInfo;
//     var box;
//
//     if (!this.isLoading) {
//       boxPageInfo = Hive.box("claimantsPageInfo");
//       box = Hive.box("claimants");
//
//       String ana = r"""
//       query($token:String!, $cursor:String!){
//         allClaimant(token:$token, first:25, after: $cursor){
//           pageInfo {
//             startCursor
//             endCursor
//             hasNextPage
//             hasPreviousPage
//           }
//           edges{
//             node{
//               id
//               claim{
//                 id
//                 claimNumber
//                 claimAmount
//               }
//               user{
//                 id
//                 firstName
//                 lastName
//                 profile{
//                   middleName
//                 }
//               }
//               claimantNumber
//               claimantStatus
//               claimantClaimAmount
//               claimantNetPayable
//               entryDate
//               created
//               corporate{
//                 id
//                 name
//               }
//             }
//           }
//         }
//       }
//     """;
//
//       String? token = await Repository().getToken();
//       final QueryOptions options = QueryOptions(
//         document: gql(ana),
//         variables: <String, dynamic>{
//           'token': token,
//           'cursor': this.start!
//               ? ""
//               : boxPageInfo.get("endCursor", defaultValue: ""),
//           'allowedStatus': allowedStatus
//         },
//       );
//
//       if (boxPageInfo.get("hasNextPage", defaultValue: true) &&
//           !boxPageInfo.get("isLoading", defaultValue: false) ||
//           this.start!) {
//         this.start = false;
//         GraphQLClient client = await DataConnection().connection_client();
//         final QueryResult result = await client.query(options);
//         if (result.hasException) {
//           this.hasError = true;
//         }
//         boxPageInfo.put("isLoading", result.isLoading);
//
//         if (result.data != null) {
//           this.startCursor =
//           result.data!['allClaimant']['pageInfo']['startCursor'];
//           this.endCursor = result.data!['allClaimant']['pageInfo']['endCursor'];
//           this.hasNextPage =
//           result.data!['allClaimant']['pageInfo']['hasNextPage'];
//           this.hasPreviousPage =
//           result.data!['allClaimant']['pageInfo']['hasPreviousPage'];
//
//           boxPageInfo.put("startCursor", this.startCursor);
//           boxPageInfo.put("endCursor", this.endCursor);
//           boxPageInfo.put("hasNextPage", this.hasNextPage);
//           boxPageInfo.put("hasPreviousPage", this.hasPreviousPage);
//
//           for (var claim in result.data!['allClaimant']['edges']) {
//             ClaimantModel claimantModel = ClaimantModel.fromJson(
//               claim['node'],
//             );
//             box.add(claimantModel.toMap());
//           }
//           this.hasError = false;
//         }
//         boxPageInfo.put("isLoading", false);
//         return this.hasError;
//       } else {
//         boxPageInfo.put("isLoading", false);
//         return false;
//       }
//     } else {
//       // boxPageInfo.put("isLoading", false);
//       return false;
//     }
//   }
}

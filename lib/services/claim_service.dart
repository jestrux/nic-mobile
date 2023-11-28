import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/models/claim_model.dart';
import 'package:nic/services/data_connection.dart';


class ClaimService {
  String? startCursor = "";
  String? endCursor = "";
  bool? hasNextPage = false;
  bool? hasPreviousPage = false;
  bool hasError = false;
  bool isLoading = false;
  bool? start = true;

  Future<ClaimModel?> getClaim({String? searchKey}) async {
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
    if (result.data != null) {
      // print(result.data['allClaimants']['edges'][0]['node']);
      if (result.data!['allClaimants']['edges'].length > 0) {
        var c = result.data!['allClaimants']['edges'][0]['node'];
        claim = ClaimModel(
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
    }

    return claim;
  }
  Future<Map<String, dynamic>?> reportClaim({String? registrationNumber}) async {
    ClaimModel? claim;
    String dataMap = r"""
      mutation ($registrationNumber: String!,$underwriteChannel: Int!) {
      initiateReportClaim(registrationNumber: $registration_number,underwriteChannel:$underwriteChannel) {
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
    if (result.data != null) {
      var payLoad = result.data!['initiateReportClaim'];
      return {
        "status":payLoad['status'],
        "message":payLoad['message'],
        "product":payLoad['product'],
        "proposal":payLoad['proposal']
      };
    }

    return null;
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

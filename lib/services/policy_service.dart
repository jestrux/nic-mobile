import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/models/policy_model.dart';
import 'package:nic/services/data_connection.dart';
import 'package:nic/utils.dart';

Future<Map<String, dynamic>?> renewPolicy(String registrationNumber,
    {bool? shortRenewal}) async {
  PolicyModel? policy;
  String queryString = r"""
      mutation ($registration_number: String!, $renewal: Boolean!, $proposal: Int!, $underwrite_channel:Int!,$short_renewal:Boolean) {
        initiateProposal(registrationNumber: $registration_number, renewal: $renewal, proposal: $proposal, underwriteChannel:$underwrite_channel,shortRenewal:$short_renewal) {
          success
          message
          token
          proposal
          data
          product
          renewal
          premium
          premiumVat
          totalPremium,
          propertyName,
        }
      }
    """;

  final QueryOptions options = QueryOptions(
    document: gql(queryString),
    variables: <String, dynamic>{
      // "registration_number":"t591dtp",
      "registration_number": registrationNumber,
      "renewal": true,
      "proposal": 0,
      "underwrite_channel": 2,
      "short_renewal": shortRenewal ?? true
    },
  );

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);

  if (result.data == null) {
    throw ("Failed to renew policy. Please try again later.");
  }

  var initiateProposalResponse = result.data!['initiateProposal'];

  if (initiateProposalResponse == null ||
      !(initiateProposalResponse?['success'] ?? false)) {
    throw ("Failed to purchase product. Please try again later.");
  }

  if(initiateProposalResponse['data'] != null){
  initiateProposalResponse['data'] = jsonDecode(initiateProposalResponse['data']);
  }


  return initiateProposalResponse;
}

Future<PolicyModel?> fetchPolicyStatus(String searchKey) async {
  PolicyModel? policy;
  String queryString = r"""
      query($key: String!, $underwriteChannel: Int!){
        checkCustomerPolicyStatus(first:1, searchKey: $key, notAllowedStatus:["4", "5"], orderBy:["-end_date"], underwriteChannel: $underwriteChannel){
          pageInfo {
            startCursor
            endCursor
          }
          edges{
            node{
              id
              policyPropertyName
              policyNumber
              startDate
              endDate
              isExpired
              isLife
              product{
                name
                productClass{
                  name
                }
              }
            }
          }
        }
      }
    """;

  final QueryOptions options = QueryOptions(
    document: gql(queryString),
    variables: <String, dynamic>{
      "key": searchKey,
      "token": "",
      "cursor": "",
      "company": "",
      "underwriteChannel": 2
    },
  );

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);
  if (result.data?['checkCustomerPolicyStatus']?['edges'].length < 1) {
    throw ("No policy found for $searchKey");
  }

  return PolicyModel.fromMap(
      result.data!['checkCustomerPolicyStatus']['edges'][0]['node']);
}

Future<List<Map<String, dynamic>>?> fetchPolicyDocuments(
  String searchKey,
) async {
  String queryString = r"""
      query($searchKey: String!,$underwriteChannel:Int!){
        allCustomerPolicyGlobalSearchable(orderBy: ["-id"],searchKey:$searchKey,underwriteChannel:$underwriteChannel){
          pageInfo {
            startCursor
            endCursor
            hasNextPage
            hasPreviousPage
          }
          edges{
            node{
              id
              displayName
              policyPropertyName
              policyNumber
              totalPremiumVatExclusive
              totalPremium
              premiumVat
              startDate
              endDate
              enforcedDate
              status
              statusName
              isPaid
              isExpired
              isLife
              productName
              currency {
                id
                name
                code
              }
              proposalDocument
              policyDocument
              covernoteDocument
              receiptVoucher
              taxinvoiceDocument
            }
          }
        }
      }
    """;

  final QueryOptions options = QueryOptions(
    document: gql(queryString),
    variables: <String, dynamic>{
      // "searchKey":"t591dtp",
      "searchKey": searchKey,
      "underwriteChannel": 2,
    },
  );

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);

  if (result.data == null) {
    devLog("Policy documents: No data found");
    throw ("Failed to fetch documents. Please try again.");
  }

  if (result.data?['allCustomerPolicyGlobalSearchable']?['edges'] == null) {
    devLog('Policy documents: GraphQL Error: ${result.exception.toString()}');
    throw ("Failed to fetch documents. Please try again.");
  }

  var results =
      List.from(result.data!['allCustomerPolicyGlobalSearchable']['edges']);

  if (results.isEmpty) throw ("No results found matching $searchKey");

  return results.map<Map<String, dynamic>>(
    (element) {
      var policy = element["node"];
      var description = [
        formatDate(policy['startDate'], format: "dayM"),
        formatDate(policy['endDate'], format: "dayM"),
      ].toList().join(" - ");

      return {
        ...policy,
        "title": policy['productName'],
        "description": description,
      };
    },
  ).toList();
}

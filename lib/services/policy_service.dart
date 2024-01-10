import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/models/policy_model.dart';
import 'package:nic/services/data_connection.dart';
import 'package:nic/utils.dart';

Future<Map<String, dynamic>?> renewPolicy(String registrationNumber) async {
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
      "short_renewal": true
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

  initiateProposalResponse['data'] =
      jsonDecode(initiateProposalResponse['data']);

  devLog("Car details: ${initiateProposalResponse['data']}");

  return initiateProposalResponse;
}

Future<PolicyModel?> fetchPolicyStatus({String? searchKey}) async {
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
  if (result.data != null) {
    if (result.data!['checkCustomerPolicyStatus']['edges'].length > 0) {
      var policyMap =
          result.data!['checkCustomerPolicyStatus']['edges'][0]['node'];
      policy = PolicyModel.fromMap(policyMap);
      // policy = PolicyModel(
      //   policyPropertyName: policyMap['policyPropertyName'],
      //   policyNumber: policyMap['policyNumber'],
      //   startDate: policyMap['startDate'],
      //   endDate: policyMap['endDate'],
      //   isExpired: policyMap['isExpired'],
      //   isLife: policyMap['isLife'],
      //   productName:
      //       "${policyMap['product']['productClass']['name']} ${policyMap['product']['name']}",
      // );
    }
  }

  return policy;
}

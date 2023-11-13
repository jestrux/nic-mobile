import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/models/policy_model.dart';
import 'package:nic/services/data_connection.dart';

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
      "underwriteChannel": 4
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

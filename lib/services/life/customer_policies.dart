import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/models/life/LifepolicyModel.dart';
import 'package:nic/services/data_connection.dart';

Future<List<LifePolicyModel>> getCustomerPolicies({String? customerId}) async {
  List<LifePolicyModel> policies = [];

  String queryString = r"""
    query GetPolicies($customerId: String!) {
      lifeCustomerPolicies(customerId: $customerId) {
        id
        policyNumber
        checkNumber,
        premium,
        sumInsured,
        startDate
        maturityDate
        customer {
          customerNumber
          firstName,
          lastName
        }
        product {
          id
          name
        }
      }
    }
  """;

  final QueryOptions options = QueryOptions(
      document: gql(queryString), variables: {"customerId": customerId});

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);

  if (result.data != null) {
    var policyList = result.data!['lifeCustomerPolicies'];
    if (policyList != null) {
      policies = List<LifePolicyModel>.from(policyList.map(
        (policyMap) => LifePolicyModel.fromMap(policyMap),
      ));
    }
  } else {}

  return policies;
}

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/models/life/LifepolicyMode.dart';
import 'package:nic/services/data_connection.dart';

Future<List<LifePolicyModel>> getCustomerPolicies({String? customerId}) async {
  List<LifePolicyModel> policies = [];

  String queryString = r"""
    query GetPolicies($customerId: String!) {
      lifeCustomerPolicies(customerId: $customerId) {
        id
        policyNumber
        checkNumber
        premium
        sumInsured
        startDate
        maturityDate
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

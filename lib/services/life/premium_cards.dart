import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/models/life/premiumCardModel.dart';
import 'package:nic/services/data_connection.dart';

getTotalCollectedPremium({String? policyId}) async {
  var totalPremium;
  String queryString = r"""
  query GetTotalPremium($policyId: String!){
    TotalPolicyCollectedPremium(policyId: $policyId){
      totalEstimatedPremium,
      totalCollectedPremium
    }
  }
  """;

  print("____________====== selected id herrrrr ${policyId}");
  final QueryOptions options = QueryOptions(
      document: gql(queryString), variables: {"policyId": policyId});

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);

  if (result.data != null) {
    print("___________here data");
    print(result.data!['TotalPolicyCollectedPremium']);
    print("_____________end here ");
    return result.data!['TotalPolicyCollectedPremium'];
  } else {
    print("______________premium Zero");
  }

  return totalPremium;
}

Future<List<PremiumCardModel>> getPolicyPremiumCards({String? policyId}) async {
  List<PremiumCardModel> premiumCards = [];

  String queryString = r"""
    query GetLifePremiumCards($lifePolicyId: String!){
      lifePolicyPremiumCards(policyId: $lifePolicyId){
        id, 
        amount,
        allocation{
          id,
          allocationDate
        }
      }
    }
      """;

  final QueryOptions options = QueryOptions(
      document: gql(queryString), variables: {"lifePolicyId": policyId});

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);

  if (result.data != null) {
    var premiumCardList = result.data!['lifePolicyPremiumCards'];

    if (premiumCardList != null) {
      premiumCards = List<PremiumCardModel>.from(premiumCardList
          .map((premiumCardMap) => PremiumCardModel.fromMap(premiumCardMap)));

      print("+============+++ premiumCard LIsting ${premiumCards}");
    }
  } else {
    print("____________no premium Cards");
  }
  return premiumCards;
}

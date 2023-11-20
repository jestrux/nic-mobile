import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/models/life/premiumCardModel.dart';
import 'package:nic/services/data_connection.dart';

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

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/models/branch_model.dart';
import 'package:nic/services/data_connection.dart';


class BranchService {
  Future<dynamic> getBranches() async {
    // var branchesBox = Hive.box('branches');
    BranchModel? branches ;
    String data = r"""
      query{
        allBranches(orderBy:["name"]){
          edges{
            node{
              id,
              name,
              contacts{
                contact
              },
              addresses{
                id,
                street
              },
              locations{
                latitude,
                longitude
              },
            }
          }
        }
      }
    """;

    final QueryOptions options = QueryOptions(
      document: gql(data),
    );

    GraphQLClient client = await DataConnection().connectionClient();
    final QueryResult result = await client.query(options);
    if(result.data != null){
      if(result.data!['allBranches']['edges'].length > 0){
        return result.data!['allBranches']['edges'];

      }
    }
    return branches;
  }

}
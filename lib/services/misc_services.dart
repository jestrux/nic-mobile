import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/constants.dart';
import 'package:nic/services/data_connection.dart';
import 'package:nic/utils.dart';

Future<List<Map<String, dynamic>>?> fetchBranches() async {
  String queryString = r"""
    query {
      allBranches {
        edges {
          node {
            id
            name
            locations {
              longitude
              latitude
            }
            addresses {
              street
              ward {
                name
              }
            }
            district {
              name
              region {
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
  );

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);

  if (result.data?['allBranches']['edges'] == null) {
    throw ("Failed to fetch branches");
  }

  return List.from(result.data!['allBranches']['edges'])
      .map<Map<String, dynamic>>((branch) {
    Map<String, dynamic> props = {...branch["node"]};

    String? location;
    var district = props["district"];

    if (district?["name"] != null) {
      location = capitalize((district["name"]));

      if (district?["region"]?["name"] != null) {
        location = "$location - ${capitalize(district?["region"]?["name"])}";
      }
    }

    return {
      "title": props["name"],
      "description": location,
      "email": Constants.supportEmail,
      "phone": Constants.supportPhoneNumber,
      "coords": List.from(props["locations"]).firstOrNull ??
          {
            "latitude": -6.815990607109203,
            "longitude": 39.29028651278273,
          }
    };
  }).toList();
}

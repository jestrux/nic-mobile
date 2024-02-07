import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/services/repository.dart';

class DataConnection {
  final HttpLink httpLink = HttpLink('http://192.168.2.203:8008/uat/graphql/');
  // final HttpLink httpLink = HttpLink("http://154.118.224.225/uat/graphql/");
  // final HttpLink httpLink = HttpLink('https://imis.nictanzania.co.tz/production/graphql/');
  // final HttpLink httpLink = HttpLink("http://192.168.1.80/production/graphql/");

  Future<GraphQLClient> connectionClient() async {
    Link link = httpLink;
    String? token = await Repository().getToken();
    final AuthLink authLink = AuthLink(
      getToken: () async => "JWT $token",
    );

    if (token != null) link = authLink.concat(httpLink);

    return GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    );
  }

  GraphQLClient hiveClient(String? token) {
    Link link = httpLink;
    final AuthLink authLink = AuthLink(
      getToken: () async => 'JWT $token',
    );
    if (token != null) {
      link = authLink.concat(httpLink);
    }

    return GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    );
  }
}

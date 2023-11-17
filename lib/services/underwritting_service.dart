import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/services/data_connection.dart';
import 'package:nic/utils.dart';

Future<List<dynamic>?> getInitialProductForm({
  required String productId,
}) async {
  String queryString = r"""query($product: ID!, $underwriteChannel: Int!) {
    initialForm(product: $product, underwriteChannel: $underwriteChannel)
  }""";

  final QueryOptions options = QueryOptions(
    document: gql(queryString),
    variables: <String, dynamic>{
      "product": productId,
      "underwriteChannel": 2,
    },
  );

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);

  List<dynamic>? initialForm;

  if (result.data == null) {
    devLog("Init quotation: No data found");
    throw ("Failed to fetch form. Please try again later.");
  }

  var initialFormResponse = result.data!['initialForm'];

  if (initialFormResponse == null) {
    throw ("Failed to fetch quotation. Please try again later.");
  }

  var fullinitialForm = jsonDecode(
    jsonDecode(initialFormResponse),
  );

  initialForm = List.from(fullinitialForm);

  return initialForm;
}

Future<Map<String, dynamic>?> fetchProposalForm({
  required String productId,
  required int proposal,
  required String phoneNumber,
}) async {
  String queryString =
      r"""query ($product: ID!, $policy: Int!, $renewal: Boolean!, $underwriteChannel: Int!) {
    allForm(product: $product, policy: $policy, renewal: $renewal, underwriteChannel: $underwriteChannel)
  }""";

  final QueryOptions options = QueryOptions(
    document: gql(queryString),
    variables: <String, dynamic>{
      "product": productId,
      "policy": proposal,
      "renewal": false,
      "underwriteChannel": 2,
    },
  );

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);

  List<dynamic>? allForm;

  if (result.data == null) {
    devLog("All form: No data found");
    throw ("Failed to fetch form. Please try again later.");
  }

  var allFormResponse = result.data!['allForm'];

  if (allFormResponse == null) {
    throw ("Failed to fetch quotation. Please try again later.");
  }

  allForm = List.from(jsonDecode(
    jsonDecode(allFormResponse),
  )).map((e) => List.from(e["fields"] ?? [])).expand((field) => field).toList();

  return {
    "productId": productId,
    "phoneNumber": phoneNumber,
    "proposal": proposal,
    "form": allForm,
  };
}

Future<Map<String, dynamic>?> initiateProposal({
  required String productId,
  required List<dynamic> data,
}) async {
  String queryString =
      r"""mutation ($data: JSONString!, $product: ID!, $proposal: Int!, $verify: Boolean!, $underwriteChannel: Int!) {
    initiateProposal(data: $data, product: $product, proposal: $proposal, verify: $verify, underwriteChannel: $underwriteChannel) {
      success
      message
      token
      verify
      user{
          id
          firstName
      }
      proposal
      data
    }
  }""";

  var phoneNumber = List.from(data)
      .singleWhere((field) => field["field_name"] == "owner_phone")?["answer"];

  final QueryOptions options = QueryOptions(
    document: gql(queryString),
    variables: <String, dynamic>{
      "product": productId,
      "underwriteChannel": 2,
      "proposal": 0,
      "verify": false,
      "data": jsonEncode(data),
    },
  );

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);

  if (result.data == null) {
    devLog("Initiate proposal: No data found");
    throw ("Failed to fetch form. Please try again later.");
  }

  var initiateProposalResponse = result.data!['initiateProposal'];

  if (initiateProposalResponse == null) {
    throw ("Failed to purchase product. Please try again later.");
  }

  if (!(initiateProposalResponse?['success'] ?? false)) {
    var message = (initiateProposalResponse?["message"] ?? "") ?? "";
    var already = message.toLowerCase().indexOf("already") != -1;
    var active = message.toLowerCase().indexOf("active policy") != -1;

    if (already || active) {
      openErrorAlert(message: message, title: "Policy already exists");
      return null;
    }

    throw ("Unknown error, plese try again");
  }

  return fetchProposalForm(
    productId: productId,
    proposal: initiateProposalResponse["proposal"],
    phoneNumber: phoneNumber,
  );
}

Future<Map<String, dynamic>?> submitProposalForm({
  required String productId,
  required int proposal,
  required String phoneNumber,
  required List<dynamic> data,
}) async {
  String queryString =
      r"""mutation ($product: ID!, $data: JSONString!, $proposal: Int!, $renewal: Boolean!, $underwriteChannel: Int!) {
      proposal(product: $product, data: $data, proposal: $proposal, renewal: $renewal, underwriteChannel: $underwriteChannel) {
          success
          message
          data
          premium
          premiumVat
          totalPremium,
          propertyName,
          startDate,
          endDate,
          controlNumber,
          isPaid
      }
  }""";

  final QueryOptions options = QueryOptions(
    document: gql(queryString),
    variables: <String, dynamic>{
      "product": productId,
      "proposal": proposal,
      "renewal": false,
      "verify": false,
      "data": jsonEncode(data),
      "underwriteChannel": 2,
    },
  );

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);

  if (result.data?['proposal'] == null) {
    devLog("Proposal: No data found");
    throw ("Failed to submit proposal. Please try again later.");
  }

  var proposalResponse = result.data!['proposal'];

  if (!(proposalResponse?['success'] ?? false)) {
    var message = proposalResponse?['message'] ??
        "Failed to submit proposal. Please try again later.";

    devLog("Proposal: backend error, $message");
    throw (message);
  }

  return proposalResponse;
}

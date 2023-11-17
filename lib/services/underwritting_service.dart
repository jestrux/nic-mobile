import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/services/data_connection.dart';
import 'package:nic/utils.dart';

bool productIsNonMotor({required String productId}) =>
    ["UHJvZHVjdE5vZGU6MzAw", "UHJvZHVjdE5vZGU6MzEx"].contains(productId);

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

Future<Map<String, dynamic>?> fetchPaymentSummary({
  required String productId,
  required int proposal,
  bool recurse = false,
  int retries = 1,
}) async {
  String queryString =
      r"""query ($proposal: Int!, $product: String!, $underwriteChannel: Int!) {
    premiumSummary(policy: $proposal, product: $product, underwriteChannel: $underwriteChannel)
  }""";

  final QueryOptions options = QueryOptions(
    document: gql(queryString),
    variables: <String, dynamic>{
      "product": productId,
      "proposal": proposal,
      "underwriteChannel": 2,
    },
  );

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);

  if (result.data == null) {
    devLog("Payment summary: No data found");
    throw ("Failed to fetch payment details. Please try again later.");
  }

  var summaryResponse = result.data!['premiumSummary'];

  if (summaryResponse == null) {
    throw ("Failed to fetch payment details. Please try again later.");
  }

  if (summaryResponse["control_number"] == null && recurse && retries < 5) {
    await Future.delayed(const Duration(seconds: 2));
    return fetchPaymentSummary(
      productId: productId,
      proposal: proposal,
      recurse: true,
      retries: retries + 1,
    );
  }

  return summaryResponse;
}

Future<Map<String, dynamic>?> requestControlNumber({
  required int proposal,
  required String productId,
}) async {
  String queryString =
      r"""mutation ($proposal: Int!,$isLife: Boolean, $underwriteChannel: Int!) {
        controlNumber(proposal: $proposal, isLife:$isLife, underwriteChannel: $underwriteChannel) {
            success
            message
            data
            premium
            premiumVat
            totalPremium
            propertyName
            startDate
            endDate
            controlNumber
            isPaid
        }
    }""";

  final QueryOptions options = QueryOptions(
    document: gql(queryString),
    variables: <String, dynamic>{
      "proposal": proposal,
      "isLife": productIsNonMotor(productId: productId),
      "underwriteChannel": 2,
    },
  );

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);

  if (result.data == null) {
    devLog("Request control number: No data found");
    throw ("Failed to fetch payment. Please try again later.");
  }

  var controlNumberResponse = result.data!['controlNumber'];

  if (!(controlNumberResponse?['success'] ?? false)) {
    throw ("Failed to fetch payment. Please try again later.");
  }

  return fetchPaymentSummary(
    productId: productId,
    proposal: proposal,
    recurse: true,
  );
}

requestPaymentPush({
  required String amount,
  required String controlNumber,
  required String phoneNumber,
}) async {
  String queryString =
      // r"""mutation ($amount: String!, $controlNumber: String!, $phone: String!, $underwriteChannel: Int!) {
      //   makePushPayment(amount: $amount, controlNumber: $controlNumber, phone: $phone, underwriteChannel: $underwriteChannel) {
      r"""mutation ($amount: String!, $controlNumber: String!, $phone: String!) {
        makePushPayment(amount: $amount, controlNumber: $controlNumber, phone: $phone) {
            success
            message
        }
    }""";

  final QueryOptions options = QueryOptions(
    document: gql(queryString),
    variables: <String, dynamic>{
      "amount": amount,
      "controlNumber": controlNumber,
      "phone": phoneNumber,
      // "underwriteChannel": 2,
    },
  );

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);

  if (result.data == null) {
    devLog("Payment push: No data found");
    throw ("Failed to make payment. Please try again later.");
  }

  var makePushPaymentResponse = result.data!['makePushPayment'];

  if (!(makePushPaymentResponse?["success"] ?? false)) {
    throw ("Failed to make payment. Please try again later.");
  }

  return true;
}

import 'dart:convert';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/services/data_connection.dart';
import 'package:nic/utils.dart';

Future<Map<String, dynamic>?> initQuotation({
  required String productId,
}) async {
  String queryString = r"""mutation ($product: ID!, $underwriteChannel: Int!) {
    initiateQuotationForm(product: $product, underwriteChannel: $underwriteChannel){
      success
      data
      product
      quote
      message
    }
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

  Map<String, dynamic>? quotation;

  if (result.data == null) {
    devLog("Init quotation: No data found");
    throw ("Failed to fetch quotation. Please try again later.");
  }

  quotation = result.data!['initiateQuotationForm'];

  if (!(quotation?['success'] ?? false)) {
    throw ("Failed to fetch quotation. Please try again later.");
  }

  return quotation;
}

Future<Map<String, dynamic>?> getQuotationDetails({
  required String productId,
}) async {
  Map<String, dynamic>? quotation = await initQuotation(productId: productId);

  if (quotation == null) {
    throw ("Failed to fetch quotation. Please try again later.");
  }

  String queryString = r"""query ($product: Int!, $underwriteChannel: Int!) {
    quotationForm(product: $product, underwriteChannel: $underwriteChannel)
  }""";

  final QueryOptions options = QueryOptions(
    document: gql(queryString),
    variables: <String, dynamic>{
      "product": quotation["product"],
      "underwriteChannel": 2,
    },
  );

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);

  List<dynamic>? quotationForm;

  if (result.data == null) {
    devLog("Get form: No data found");
    throw ("Failed to fetch quotation. Please try again later.");
  }

  var quotationFormResponse = result.data!['quotationForm'];

  if (quotationFormResponse == null) {
    throw ("Failed to fetch quotation. Please try again later.");
  }

  var fullQuotationForm = jsonDecode(
    jsonDecode(quotationFormResponse),
  );

  quotationForm = List.from(fullQuotationForm)
      .map((e) => List.from(e["fields"] ?? []))
      .expand((element) => element)
      .toList();

  if (quotationForm.isEmpty) {
    try {
      return await submitQuote(productId: productId, quote: quotation["quote"]);
    } catch (e) {
      devLog("Submit quote error $e");
    }
  }

  return {...quotation, "form": quotationForm};
}

Future<Map<String, dynamic>?> submitQuote({
  required String productId,
  required dynamic quote,
  Map<String, dynamic>? data,
}) async {
  devLog("Submit quote...");

  String queryString =
      r"""mutation($product: ID!, $quote: Int!, $data: JSONString!, $underwriteChannel: Int!){
    quote(product:$product,quote: $quote,data: $data, underwriteChannel: $underwriteChannel){
      success
      message
      premium
      totalPremium
      propertyName
      sumInsured
    }
  },""";

  final QueryOptions options = QueryOptions(
    document: gql(queryString),
    variables: <String, dynamic>{
      "product": productId,
      "quote": quote,
      "data": data != null ? jsonEncode(data) : "{}",
      "underwriteChannel": 2,
    },
  );

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);

  if (result.data == null) {
    devLog("Submit quote: No data found");
    throw ("Failed to fetch quotation. Please try again later.");
  }

  devLog("Quotation details: ${result.data!['quote']}");

  Map<String, dynamic>? quoteResponse;

  quoteResponse = result.data!['quote'];

  devLog("Submit quote res: $quoteResponse");

  if (!(quoteResponse?['success'] ?? false)) {
    throw ("Failed to fetch quotation. Please try again later.");
  }

  return quoteResponse;
}

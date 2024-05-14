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
  List<dynamic>? data,
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
      isLife
      funeralAmount
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

Future<List<Map<String, dynamic>>?> getProducts({
  String tag = "",
}) async {
  devLog("Fetch products");

  String queryString = r"""query ($tag: String!) {
    allProduct(tag_Icontains: $tag) {
      edges {
        node {
          id
          productId
          name
          description
          mobileName
          code
          tag
          productClass {
            id
            name
            description
            code
          }
          benefits {
            edges {
              node {
                benefit {
                  name
                  description
                }
              }
            }
          }
        }
      }
    }
  }""";

  final QueryOptions options = QueryOptions(
    document: gql(queryString),
    variables: <String, dynamic>{
      "tag": tag,
      // "underwriteChannel": 2,
    },
  );

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);

  if (result.data == null || result.data!['allProduct']['edges'].length < 1) {
    devLog("All product: No data found");
    throw ("Failed to fetch products. Please try again later.");
  }

  List<Map<String, dynamic>> allProductResponse = List.from(
    result.data!['allProduct']['edges'],
  ).map<Map<String, dynamic>>(
    (element) {
      var product = element["node"];
      product["title"] = product["mobileName"];
      var benefitsEdges = product['benefits']?["edges"];

      if (benefitsEdges != null) {
        var benefits = List.from(benefitsEdges);

        if (benefits.isNotEmpty) {
          product["benefits"] = benefits.map<Map<String, dynamic>>(
            (element) {
              var benefit = element["node"]["benefit"];
              return {
                ...benefit,
                "title": benefit["name"],
              };
            },
          ).toList();
        }
      }

      return product;
    },
  ).toList();

  return allProductResponse;
}

Future<Map<String, dynamic>?> getProductById(int id) async {
  var products = await getProducts();

  return products?.cast<Map<String, dynamic>?>().firstWhere(
        (element) => element?["productId"] == id,
        orElse: () => null,
      );
}


Future<List<Map<String, dynamic>>?> getPopularProduct({
  String tag = "",
}) async {
  devLog("Fetch popular products");

  String queryString = r"""
      query{
      allPopularProduct {
        edges {
          node {
            id
            name
            description
            mobileName
            mobileImage
            code
            tag
            productClass {
              id
              name
              description
              code
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

  if (result.data == null || result.data!['allPopularProduct']['edges'].length < 1) {
    devLog("allPopularProduct: No data found");
    throw ("Failed to fetch allPopularProduct. Please try again later.");
  }

  List<Map<String, dynamic>> allPopularProduct = List.from(
    result.data!['allPopularProduct']['edges'],
  ).map<Map<String, dynamic>>(
        (element) {
      var product = element["node"];
      product["title"] = product["mobileName"];
      product['openUssd'] = false;

      return product;
    },
  ).toList();

  return allPopularProduct;
}
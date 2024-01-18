import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/services/data_connection.dart';
import 'package:nic/utils.dart';

Future<Map<String, dynamic>?> fetchPaymentInformation(
  String controlNumber,
) async {
  // query ($controlNumber: String!, $underwriteChannel: Int!) {
  //   paymentInformation(controlNumber: $controlNumber, underwriteChannel: $underwriteChannel){
  String queryString = r"""
    query ($controlNumber: String!) {
      paymentInformation(controlNumber: $controlNumber){
        edges{
          node{
            id
            created
            BillGenDt
            BillExpDt
            company
            currency
            controlNumber
            BillAmount
            description
            isPaid
            payerName
            payerPhone
            receiptNumber
            payerEmail
            isCancelled
            cancalReason
            isPartialPaid
          }
        }
      }
    }
  """;

  final QueryOptions options = QueryOptions(
    document: gql(queryString),
    variables: <String, dynamic>{
      "controlNumber": controlNumber,
      // "underwriteChannel": 2
    },
  );

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);

  if (result.data?['paymentInformation']?['edges'].length < 1) {
    throw ("Control number not found");
  }

  Map<String, dynamic> paymentInformation =
      result.data!['paymentInformation']['edges'][0]['node'];

  var validKeys = [
    "controlNumber",
    "BillGenDt",
    "BillExpDt",
    "BillAmount",
    "description",
    "isPaid",
    "payerName",
    "payerPhone",
    "receiptNumber",
  ];

  paymentInformation.removeWhere((key, value) => !validKeys.contains(key));

  devLog("paymentInformation: $paymentInformation");

  return paymentInformation;
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
  } else {
    print("====================hello data==========");
    print("${result.data}");
  }

  var makePushPaymentResponse = result.data!['makePushPayment'];

  if (!(makePushPaymentResponse?["success"] ?? false)) {
    throw ("Failed to make payment. Please try again later.");
  }

  return true;
}

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nic/models/life/organizationBillModel.dart';
import 'package:nic/services/data_connection.dart';

Future<Object?> getCustomerBill({String? customerKey}) async {
  List<OrganizationBillModel> bills = [];

  String queryString = r"""
    query GetCustomerBill($customerkey: String!){
      CustomerOrganizationBill(customerId: $customerkey){
        id, 
        controlNumber,
        amount,
        description,
        controlNumberExpireDate,
        customer{
          id,
          firstName,
          middleName,
          lastName,
          customerNumber,
          phoneNumber
        },
        gfsCode,
        allocationBill
      }
    }
""";

  final QueryOptions options = QueryOptions(
      document: gql(queryString), variables: {"customerkey": customerKey});

  GraphQLClient client = await DataConnection().connectionClient();
  final QueryResult result = await client.query(options);

  if (result.data != null) {
    var billsData = result.data!['CustomerOrganizationBill'];

    if (billsData is List<dynamic>) {
      return List<OrganizationBillModel>.from(billsData.map(
        (billMap) =>
            OrganizationBillModel.fromMap(billMap as Map<String, dynamic>),
      ));
    } else if (billsData is Map<String, dynamic>) {
      return OrganizationBillModel.fromMap(billsData);
    } else {
      print("Unexpected data format for 'CustomerOrganizationBill'");
      return null;
    }
  }

  return bills;
}

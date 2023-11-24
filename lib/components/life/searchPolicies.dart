import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/models/life/organizationBillModel.dart';
import 'package:nic/pages/FormPage.dart';
import 'package:nic/services/life/customer_policies.dart';
import 'package:nic/services/underwritting_service.dart';
import 'package:nic/utils.dart';

import '../../services/life/customer_bill.dart';

class SearchLifePolicy extends StatefulWidget {
  const SearchLifePolicy({super.key});

  @override
  State<SearchLifePolicy> createState() => _SearchLifePolicyState();
}

class _SearchLifePolicyState extends State<SearchLifePolicy> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: DynamicForm(
      payloadFormat: DynamicFormPayloadFormat.regular,
      fields: const [
        DynamicFormField(
          name: "customerKey",
          label: "Nida Number",
          placeholder: "Enter Nida Number",
        ),
      ],
      onCancel: () => Navigator.of(context).pop(),
      submitLabel: "Check",
      onSubmit: searchPolicies,
      onSuccess: customerPolicies,
    ));
  }

  Future<dynamic> searchPolicies(Map<String, dynamic>? formData) async {
    if (formData == null) return;

    String? customerKey = formData['customerKey'];

    return await getCustomerPolicies(customerId: customerKey);
  }

  customerPolicies(dynamic policies) async {
    if (policies == null) {
      return null;
    } else {
      // Navigator.pop(context);

      if (policies.isNotEmpty) {
        var customerKey = await showChoicePicker(
            mode: ChoicePickerMode.alert,
            confirm: true,
            title: "Select Policy",
            choices: policies.map((policy) {
              return {"label": policy?.policyNumber, "value": policy?.id};
            }).toList());

        // ignore: unnecessary_null_comparison
        if (customerKey != null) {
          var selectedPolicy =
              policies.firstWhere((policy) => policy?.id == customerKey);
          if (selectedPolicy != null) {
            print("=======chekc for satisfy");
            var customerPolicyId = selectedPolicy?.customer?.id;
            var bill = await getCustomerBill(customerKey: customerPolicyId);

            if (bill != null) {
              if (bill is OrganizationBillModel) {
                print("Bill ID: ${bill.id}");
                print("Control number: ${bill.controlNumber}");
                print("Phone Number: ${bill.customer?.phoneNumber}");
                print("Amount: ${bill.amount}");

                return openPaymentAlert(
                  bill.customer?.phoneNumber ?? "",
                  bill.amount ?? 0.0,
                  bill.controlNumber ?? "",
                );
              } else {
                print("Unexpected format for bills");
                return null;
              }
            } else {
              print("++++++no bills found");
              return null;
            }
          } else {
            print("__________null selected policy");
          }
        } else {
          print("_______i have a policy here ");
        }
      } else {
        openErrorAlert(message: "No Policy(ies) for this Customer");
      }
    }
  }

  void openPaymentAlert(
      String mobileNumber, double amount, String controlNumber) {
    var phoneNumber;
    openAlert(
      title: "Make Payment",
      child: DynamicForm(
        payloadFormat: DynamicFormPayloadFormat.regular,
        initialValues: {"phoneNumber": mobileNumber},
        fields: const [
          DynamicFormField(
            label: "Phone Number to be used for payment",
            name: "phoneNumber",
          ),
        ],
        onCancel: () {
          Navigator.pop(context);
        },
        onSubmit: (payload) async {
          print("===============print my phone number, ${mobileNumber}");
          print(payload["phoneNumber"]);
          print("=========end print phone Numner");
          phoneNumber = payload["phoneNumber"];

          print("========payload phone number to send ${phoneNumber}");
          return requestPaymentPush(
            amount: amount.toString(),
            controlNumber: controlNumber,
            phoneNumber: phoneNumber,
          );
        },
        onSuccess: (response) {
          if (response == null) return;

          Navigator.of(context).popUntil(ModalRoute.withName("/"));
          openSuccessAlert(
            message: "Check your phone($phoneNumber) to make payment.",
          );
        },
      ),
    );
  }
}

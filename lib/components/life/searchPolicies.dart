import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/models/life/organizationBillModel.dart';
import 'package:nic/services/life/customer_policies.dart';
import 'package:nic/services/life/premium_cards.dart';
import 'package:nic/services/payment_service.dart';
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
            var policyID = selectedPolicy?.id;
            var customerPolicyId = selectedPolicy?.customer?.id;
            var premium = selectedPolicy?.premium;
            var premiumPaymentMethod = selectedPolicy?.premiumPaymentMethod;
            var bill = await getCustomerBill(customerKey: customerPolicyId);
            var premiumSummary =
                await getTotalCollectedPremium(policyId: policyID);
            var totalCollectedPremium =
                premiumSummary['totalCollectedPremium'] ?? 0;
            var totalEstimatedPremium =
                premiumSummary['totalEstimatedPremium'] ?? 0;

            var remaimedPremiumAmount =
                totalEstimatedPremium - totalCollectedPremium;
            var productName = selectedPolicy?.product?.name;

            print("=====================product Id ${productName}");

            if (bill != null) {
              if (bill is OrganizationBillModel) {
                return openPaymentAlert(
                    bill.customer?.phoneNumber ?? "",
                    bill.amount ?? 0.0,
                    bill.controlNumber ?? "",
                    premium,
                    premiumPaymentMethod,
                    totalCollectedPremium,
                    totalEstimatedPremium,
                    remaimedPremiumAmount,
                    productName);
              } else {
                return null;
              }
            } else {
              return null;
            }
          } else {}
        } else {}
      } else {
        openErrorAlert(message: "No Policy(ies) for this Customer");
      }
    }
  }

  void openPaymentAlert(
      String mobileNumber,
      double amount,
      String controlNumber,
      double premium,
      int premiumPaymentMethod,
      double totalPremiumAmount,
      double totalEstimatedPremium,
      double remaimedPremiumAmount,
      String productName) {
    var phoneNumber;
    openAlert(
      title: "Make Payment",
      child: Column(
        children: [
          productName == "BeamLife"
              ? Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 20, right: 20),
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(bottom: 10),
                          child: const Text(
                            "Summary",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )),
                      SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Premium"),
                                Text(NumberFormat.currency(
                                        locale: 'en_us', symbol: '')
                                    .format(premium))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Payment Method"),
                                Text(premiumPaymentMethod == 1
                                    ? "Annualy"
                                    : premiumPaymentMethod == 2
                                        ? "Semmi Annually"
                                        : premiumPaymentMethod == 3
                                            ? "Quartely"
                                            : premiumPaymentMethod == 4
                                                ? "Monthly"
                                                : "Single Premium")
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Expected Collection Amount"),
                                Text(
                                  NumberFormat.currency(
                                          locale: 'en_US', symbol: '\TZS ')
                                      .format(totalEstimatedPremium),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Collected Premium Amount"),
                                Text(
                                  NumberFormat.currency(
                                          locale: 'en_US', symbol: '\TZS ')
                                      .format(totalPremiumAmount),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //     padding: const EdgeInsets.only(top: 10),
                      //     width: double.infinity,
                      //     child: Card(
                      //       child: Container(
                      //           padding: const EdgeInsets.all(10),
                      //           child: Text("oooo")),
                      //     ))
                    ],
                  ),
                )
              : Container(),
          DynamicForm(
            payloadFormat: DynamicFormPayloadFormat.regular,
            initialValues: {"phoneNumber": mobileNumber},
            fields: [
              DynamicFormField(
                label: "Phone Number to be used for payment $premium",
                name: "phoneNumber",
              ),
            ],
            onCancel: () {
              Navigator.pop(context);
            },
            onSubmit: (payload) async {
              phoneNumber = payload["phoneNumber"];

              return requestPaymentPush(
                amount: premium.toString(),
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
        ],
      ),
    );
  }
}

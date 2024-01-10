import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/FormButton.dart';
import 'package:nic/components/KeyValueView.dart';
import 'package:nic/components/ListItem.dart';
import 'package:nic/components/Loader.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/services/payment_service.dart';
import 'package:nic/services/underwritting_service.dart';
import 'package:nic/utils.dart';

class PolicyPaymentDetails extends StatefulWidget {
  final Map<String, dynamic> details;
  const PolicyPaymentDetails({
    required this.details,
    Key? key,
  }) : super(key: key);

  @override
  State<PolicyPaymentDetails> createState() => _PolicyPaymentDetailsState();
}

class _PolicyPaymentDetailsState extends State<PolicyPaymentDetails> {
  late Map<String, dynamic> details;
  bool loading = false;
  bool onFinalScreen = false;

  @override
  void initState() {
    details = widget.details;

    if (details['proposal'] != null) {
      fetchPaymentDetails(delayed: true);
    }

    super.initState();
  }

  fetchPaymentDetails({bool delayed = false}) async {
    setState(() {
      loading = true;
    });

    if (delayed) await Future.delayed(const Duration(seconds: 3));

    try {
      var res = await requestControlNumber(
        productId: details["productId"] ?? "",
        proposal: details["proposal"],
      );

      setState(() {
        details = {...details, ...(res ?? {})};
      });
    } catch (e) {
      openErrorAlert(message: e.toString());
      devLog("Control number error: $e");
    }

    setState(() {
      loading = false;
    });
  }

  void openPaymentDetailsScreen() {
    openInfoAlert(message: "Open payment details!");
    // Navigator.of(context).popUntil(ModalRoute.withName("/"));
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => FormPage(
    //       title: "Premium Details",
    //       details: {
    //         ...details!,
    //         "fetchPaymentDetails": true,
    //       },
    //     ),
    //   ),
    // );
  }

  makePayment() {
    var phoneNumber;
    openAlert(
      title: "Make Payment",
      child: DynamicForm(
        payloadFormat: DynamicFormPayloadFormat.regular,
        initialValues: {"phoneNumber": details!["phoneNumber"]},
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
          phoneNumber = payload["phoneNumber"];
          // Navigator.pop(context);
          // devLog("Payload: $payload");
          return requestPaymentPush(
            amount: details["totalPremium"].toString(),
            controlNumber: details["control_number"],
            phoneNumber: phoneNumber,
          );
        },
        onSuccess: (response) {
          if (response == null) {
            openErrorAlert(message: "Payment failed, please try again later");
            return;
          }

          Navigator.of(context).popUntil(ModalRoute.withName("/"));
          openSuccessAlert(
            message: "Check your phone($phoneNumber) to make payment.",
          );
        },
      ),
    );
  }

  Widget _buildPaymentDetailsContent() {
    var controlNumber = details["control_number"] ?? details["controlNumber"];

    // if (!onFinalScreen) {
    //   return Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
    //     child: FormButton.filled(
    //       "Get payment Details",
    //       loading: loading,
    //       onClick: openPaymentDetailsScreen,
    //     ),
    //   );
    // }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 40, thickness: 0.3),
        Padding(
          padding: const EdgeInsets.only(
            left: 14,
            right: 14,
            bottom: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "PAYMENT DETAILS",
                style: TextStyle(
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 6),
              ListItem(
                title: "Control Number",
                description: loading
                    ? "Fetching control number..."
                    : controlNumber ?? "Failed to fetch control number",
                trailing: loading
                    ? const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Loader.small(),
                      )
                    : null,
                action: loading
                    ? null
                    : controlNumber == null
                        ? ActionButton.filled(
                            "Retry",
                            onClick: (d) {
                              fetchPaymentDetails();
                            },
                          )
                        : ActionButton.outlined(
                            "Copy for later",
                            color: colorScheme(context).primary,
                            onClick: (d) async {
                              await Clipboard.setData(ClipboardData(
                                text: controlNumber,
                              ));
                              showToast("Copied to clipboard");
                            },
                          ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: FormButton.outlined(
                  "Pay later",
                  disabled: controlNumber == null,
                  onClick: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FormButton.filled(
                  "Pay Now",
                  disabled: controlNumber == null,
                  onClick: makePayment,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var controlNumber = details["controlNumber"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        if (details["propertyName"] != null && details["startDate"] != null)
          KeyValueView(
            title: "Policy Summary",
            data: {
              "Product": details["data"],
              "Proposal Number": details["proposal"],
              "Assured / Insured:": details["propertyName"],
              "Start Date": {
                "type": "date",
                "value": DateFormat('dd/MM/yyyy').parse(details["startDate"])
              },
              "End Date": {
                "type": "date",
                "value": DateFormat('dd/MM/yyyy').parse(details["endDate"])
              },
            },
          ),
        // if (details["data"] != null)
        //   KeyValueView(
        //     title: "Policy Summary",
        //     data: {
        //       // "Product": details["data"],
        //       "Proposal Number": details["proposal"],
        //       "Assured / Insured:": details["data"]["registration_number"],
        //     },
        //   ),
        const Divider(height: 40, thickness: 0.3),
        KeyValueView(
          title: "Premium Details",
          data: {
            "Premium": {"type": "money", "value": details["premium"]},
            "Premium VAT": {"type": "money", "value": details["premiumVat"]},
            "Total Premium": {
              "type": "money",
              "value": details["totalPremium"]
            },
          },
        ),
        _buildPaymentDetailsContent(),
        const SizedBox(height: 20)
      ],
    );
  }
}

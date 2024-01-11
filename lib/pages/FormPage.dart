import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/DynamicForm/proccessFields.dart';
import 'package:nic/components/DynamicForm/sampleFields.dart';
import 'package:nic/components/FormButton.dart';
import 'package:nic/components/FormInput.dart';
import 'package:nic/components/KeyValueView.dart';
import 'package:nic/components/ListItem.dart';
import 'package:nic/components/Loader.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/components/RoundedHeaderPage.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/services/payment_service.dart';
import 'package:nic/services/underwritting_service.dart';
import 'package:nic/utils.dart';

class FormPage extends StatefulWidget {
  final String title;
  final Map<String, dynamic>? proposalDetails;
  const FormPage({
    Key? key,
    this.proposalDetails,
    this.title = "Form page",
  }) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  Map<String, dynamic>? proposalDetails;
  List<DynamicFormField>? formFields;
  bool loading = false;
  bool onFinalScreen = false;

  @override
  void initState() {
    proposalDetails = widget.proposalDetails;
    formFields = processFields(proposalDetails?["form"] ?? sampleFields);

    if (proposalDetails?["fetchPaymentDetails"] != null) {
      onFinalScreen = true;
      fetchPaymentDetails();
    }

    super.initState();
  }

  fetchPaymentDetails() async {
    setState(() {
      loading = true;
    });

    try {
      var res = await requestControlNumber(
        productId: proposalDetails!["productId"],
        proposal: proposalDetails!["proposal"],
      );

      setState(() {
        proposalDetails = {...proposalDetails!, ...(res ?? {})};
      });
    } catch (e) {
      openErrorAlert(message: e.toString());
      devLog("Control number error: $e");
    }

    setState(() {
      loading = false;
    });
  }

  makePayment() {
    var phoneNumber;
    openAlert(
      title: "Make Payment",
      child: DynamicForm(
        payloadFormat: DynamicFormPayloadFormat.regular,
        initialValues: {"phoneNumber": proposalDetails!["phoneNumber"]},
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
          var details = proposalDetails!;
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

  void openPaymentDetailsScreen() {
    Navigator.of(context).popUntil(ModalRoute.withName("/"));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FormPage(
          title: "Premium Details",
          proposalDetails: {
            ...proposalDetails!,
            "fetchPaymentDetails": true,
          },
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsContent() {
    var details = proposalDetails!;
    var controlNumber = details["control_number"];

    if (!onFinalScreen) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
        child: FormButton.filled(
          "Get payment Details",
          loading: loading,
          onClick: openPaymentDetailsScreen,
        ),
      );
    }

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

  Widget buildContent() {
    Widget content = Container();

    if (proposalDetails?["premium"] != null) {
      var details = proposalDetails!;
      var controlNumber = details["controlNumber"];

      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
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
          _buildPaymentDetailsContent()
        ],
      );
    } else if (formFields != null) {
      content = DynamicForm(
        fields: formFields!,
        onSubmit: (payload) async {
          if ([payload["data"], proposalDetails].contains(null)) return null;

          return submitProposalForm(
            productId: proposalDetails!["productId"],
            proposal: proposalDetails!["proposal"],
            phoneNumber: proposalDetails!["phoneNumber"],
            data: payload["data"],
          );
        },
        onSuccess: (response) {
          if (response == null) {
            devLog("No response from submit proposal");
            return null;
          }

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FormPage(
                title: "Premium Details",
                proposalDetails: {
                  ...proposalDetails!,
                  ...response,
                },
              ),
            ),
          );

          devLog("Submit proposal response $response");
        },
      );
    }

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return RoundedHeaderPage(
      // showBackButton: true,
      title: "Buy Bima",
      // title: widget.title.toUpperCase(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 12),
            buildContent(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

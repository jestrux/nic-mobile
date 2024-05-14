import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/DynamicForm/proccessFields.dart';
import 'package:nic/components/DynamicForm/sampleFields.dart';
import 'package:nic/components/FormButton.dart';
import 'package:nic/components/KeyValueView.dart';
import 'package:nic/components/ListItem.dart';
import 'package:nic/components/Loader.dart';
import 'package:nic/components/RoundedHeaderPage.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/services/payment_service.dart';
import 'package:nic/services/underwritting_service.dart';
import 'package:nic/utils.dart';

class FormPage extends StatefulWidget {
  final String title;
  final bool? renewal;
  final Map<String, dynamic>? proposalDetails;
  const FormPage({
    Key? key,
    this.proposalDetails,
    this.title = "Form page",
    this.renewal,
  }) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  Map<String, dynamic>? proposalDetails;
  List<DynamicFormField>? formFields;
  bool loading = false;
  bool cancelingLoading = false;
  bool cancelingDone = false;
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
        productId: proposalDetails!["productId"].toString(),
        proposal: proposalDetails!["proposal"],
        productTag: proposalDetails!['tag']
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
          renewal: widget.renewal,
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
    print(details['can_request_control']);
    if (!onFinalScreen) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            if(!details['can_request_control'])
            const Text("Your proposal will be submitted to your employer for payment processing.",style: TextStyle(color: Colors.orange),),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FormButton.outlined(
                    "Cancel",
                    loading: cancelingLoading,
                    onClick:() async {
                      await cancelProposal();
                      if(cancelingDone) {
                        Navigator.of(context).popUntil(
                            ModalRoute.withName("/"));
                      }
                      },
                  ),
                ),
                const SizedBox(width: 8),
                if(!details['can_request_control'])
                Expanded(
                  child: FormButton.filled(
                    "Submit for lodgment",
                    loading: loading,
                    onClick: (){Navigator.of(context).popUntil(ModalRoute.withName("/"));},
                  ),
                )
                else
                  Expanded(
                    child: FormButton.filled(
                      "Get payment Details",
                      loading: loading,
                      onClick: openPaymentDetailsScreen,
                    ),
                  )
              ],
            )
          ],
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
      // print(details);
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          KeyValueView(
            title: "Policy Summary",
            data: {
              "Product:": details["product_name"],
              "Policy Holder:": details["owner"],
              "Proposal Number:": details["policy_number"],
              "Assured / Insured:": details["property_name"],
              "Start Date:": details["start_date"] != "TBA" ? {"type": "date","value": DateFormat('dd/MM/yyyy').parse(details["start_date"])} : details["start_date"] ,
              "End Date:": details["end_date"] != "TBA" ? {"type": "date","value": DateFormat('dd/MM/yyyy').parse(details["end_date"])} : details["end_date"],
            },
          ),
          const Divider(height: 40, thickness: 0.3),

          if(details['is_life'] == false)
            KeyValueView(
              title: "Premium Details",
              data: {
                "Sum Insured:": {"type": "money", "value": details["sum_insured"]},
                "Premium:": {"type": "money", "value": details["premium"]},
                "Premium VAT:": {"type": "money", "value": details["premium_vat"]},
                "Total Premium:": {
                  "type": "money",
                  "value": details["total_premium"]
                },
              },
            )
          else
            KeyValueView(
              title: "Premium Details",
              data: {
                "Policy Term(years)":details['policy_term'],
                "Contribution Mode:": details['payment_mode'],
                "Premium per (${details['payment_mode']}):": {"type": "money", "value": details["total_premium"]},
                if(details["funeral_amount"] > 0)
                "Funeral Benefit:": {"type": "money", "value": details["funeral_amount"]},
                if(details["annual_bonus_amount"] > 0)
                "Annual Bonus:": {"type": "money", "value": details["annual_bonus_amount"]},
                "Sum Assured:": {"type": "money", "value": details["sum_insured"]},
              },
            )

          ,
          _buildPaymentDetailsContent()
        ],
      );
    } else if (formFields != null) {
      content = DynamicForm(
        fields: formFields!,
        onSubmit: (payload) async {
          // print(payload);
          if ([payload["data"], proposalDetails].contains(null)) return null;
          // print("payload----: $proposalDetails");
          // void getType(obj){
          //   var type = obj.runtimeType;
          //   return print("${obj} --- ${type}");
          // }
          // getType(proposalDetails!["productId"]);
          // getType(proposalDetails!["proposal"]);
          // getType(proposalDetails!["phoneNumber"]);
          return submitProposalForm(
            productId: proposalDetails!["productId"].toString(),
            proposal: proposalDetails!["proposal"],
            phoneNumber: proposalDetails!["phoneNumber"],
            renewal: widget.renewal,
            data: payload["data"]
                .where((field) => field['type'] != "file")
                .toList(),
            files: payload["data"]
                .where((field) => field['type'] == "file")
                .toList(),
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
                renewal: widget.renewal,
                proposalDetails: {
                  ...proposalDetails!,
                  ...response,
                },
              ),
            ),
          );

          // devLog("Submit proposal response $response");
        },
      );
    }

    return content;
  }

  cancelProposal() async {
    setState(() {
      cancelingLoading = true;
    });

    try {
      var res = await cancelOrderItem(
        productId: proposalDetails!["productId"].toString(),
        proposalId: proposalDetails!["proposal"],
      );

      setState(() {
        cancelingLoading = false;
        cancelingDone = true;
      });
    } catch (e) {
      devLog("Control number error: $e");
    }

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

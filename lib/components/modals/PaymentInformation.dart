import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/KeyValueView.dart';
import 'package:nic/components/modals/MakePayment.dart';
import 'package:nic/services/payment_service.dart';
import 'package:nic/utils.dart';

class PaymentInformation extends StatefulWidget {
  final bool skipPaymentPreview;
  const PaymentInformation({
    Key? key,
    this.skipPaymentPreview = false,
  }) : super(key: key);

  @override
  State<PaymentInformation> createState() => _PaymentInformationState();
}

class _PaymentInformationState extends State<PaymentInformation> {
  String? error;

  openPaymentForm(data) {
    openAlert(
      title: "Make Payment",
      child: MakePayment(
        amount: data["BillAmount"],
        controlNumber: data["controlNumber"],
        phoneNumber: data["payerPhone"],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      errors: {
        "controlNumber": [error]
      },
      payloadFormat: DynamicFormPayloadFormat.regular,
      fields: const [
        DynamicFormField(
          name: "controlNumber",
          label: "Control Number",
        ),
      ],
      onCancel: () => Navigator.of(context).pop(),
      onChange: (formData) {
        setState(() {
          error = null;
        });
      },
      onSubmit: (data) {
        return fetchPaymentInformation(
          controlNumber: data['controlNumber'],
        );
      },
      onSuccess: (response) {
        if (response == null || response["controlNumber"] == null) {
          setState(() {
            error = "Control number not found";
          });
          return;
        }

        Navigator.of(context).pop();

        if (widget.skipPaymentPreview) {
          openPaymentForm(response);
          return;
        }

        openAlert(
          title: "Payment Information",
          cancelText: "Close",
          onCancel: () => {},
          okayText: "Pay now",
          onOkay: () {
            Navigator.of(context).pop();
            openPaymentForm(response);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: KeyValueView(
              data: {
                "Payment for": response["description"],
                "Receipt #": response["receiptNumber"],
                "Created on": KeyValueBuilder(
                  type: KeyValueType.date,
                  value: response["BillGenDt"],
                ),
                "Due by": KeyValueBuilder(
                  type: KeyValueType.date,
                  value: response["BillExpDt"],
                ),
                "Amount": KeyValueBuilder(
                  type: KeyValueType.money,
                  value: response["BillAmount"],
                ),
                "Status": KeyValueBuilder(
                  value: response["isPaid"] ? "Paid" : "Pending",
                  type: KeyValueType.status,
                  statusVariant: response["isPaid"]
                      ? KeyValueStatusVariant.success
                      : KeyValueStatusVariant.warning,
                ),
                "Payer": "${response['payerName']}( ${response['payerPhone']} )"
              },
            ),
          ),
        );
      },
    );
  }
}

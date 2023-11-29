import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/services/payment_service.dart';
import 'package:nic/utils.dart';

class MakePayment extends StatefulWidget {
  final double amount;
  final String? controlNumber;
  final String? phoneNumber;

  const MakePayment({
    Key? key,
    required this.amount,
    this.controlNumber,
    this.phoneNumber,
  }) : super(key: key);

  @override
  State<MakePayment> createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  Map<String, dynamic>? paymentDetails;

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      initialValues: {
        "amount": widget.amount,
        "controlNumber": widget.controlNumber,
        "phoneNumber": widget.phoneNumber,
      },
      payloadFormat: DynamicFormPayloadFormat.regular,
      fields: const [
        DynamicFormField(
          label: "Control Number",
          name: "controlNumber",
          type: DynamicFormFieldType.number,
        ),
        DynamicFormField(
          label: "Phone number",
          name: "phoneNumber",
          type: DynamicFormFieldType.phoneNumber,
          canClear: true,
        ),
        DynamicFormField(
          label: "Amount",
          name: "amount",
          type: DynamicFormFieldType.money,
        ),
      ],
      onCancel: () => Navigator.of(context).pop(),
      onSubmit: (data) {
        setState(() {
          paymentDetails = data;
        });

        return requestPaymentPush(
          // amount: widget.amount.toString(),
          amount: data['amount'].toString(),
          controlNumber: data['controlNumber'],
          phoneNumber: data['phoneNumber'],
        );
      },
      onSuccess: (response) {
        if (response == null) {
          openErrorAlert(message: "Payment failed, please try again later");
          return;
        }

        Navigator.of(context).pop();

        if (paymentDetails == null) return;

        openSuccessAlert(
          message:
              "Please check your phone(${paymentDetails!['phoneNumber']}) to make a payment of ${formatMoney(paymentDetails!['amount'])}.",
        );
      },
    );
  }
}

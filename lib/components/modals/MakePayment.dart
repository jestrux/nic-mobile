import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/KeyValueView.dart';
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
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: colorScheme(context).onBackground.withOpacity(0.1),
            ),
            borderRadius: BorderRadiusDirectional.circular(8),
            color: colorScheme(context).onBackground.withOpacity(0.04),
          ),
          child: KeyValueView(
            data: {
              "Amount": KeyValueBuilder(
                value: widget.amount,
                type: KeyValueType.money,
              ),
              "Control Number": widget.controlNumber,
            },
            striped: false,
            bordered: true,
          ),
        ),
        DynamicForm(
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
              type: DynamicFormFieldType.hidden,
            ),
            DynamicFormField(
              label: "Amount",
              name: "amount",
              type: DynamicFormFieldType.hidden,
            ),
            DynamicFormField(
              label: "Phone number",
              name: "phoneNumber",
              type: DynamicFormFieldType.phoneNumber,
              canClear: true,
              autoFocus: true,
            ),
          ],
          onCancel: () => Navigator.of(context).pop(),
          onSubmit: (data) async {
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
        ),
      ],
    );
  }
}

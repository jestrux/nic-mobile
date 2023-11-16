import 'package:flutter/material.dart';
import 'package:nic/components/FormButton.dart';
import 'package:nic/constants.dart';
import 'package:nic/utils.dart';

class FormActions extends StatelessWidget {
  final String okayText;
  final Function onOkay;
  final String cancelText;
  final Function? onCancel;
  final EdgeInsets? padding;
  final bool loading;

  const FormActions({
    Key? key,
    this.okayText = "Okay",
    this.onOkay = Constants.randoFunction,
    this.cancelText = "Cancel",
    this.onCancel,
    this.loading = false,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.5,
            color: colorScheme(context).onBackground.withOpacity(0.04),
          ),
        ),
        color: colorScheme(context).onBackground.withOpacity(0.04),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (onCancel != null)
            FormButton.flat(
              cancelText,
              small: true,
              onClick: () => onCancel!(),
            ),
          const SizedBox(width: 8),
          FormButton.filled(
            okayText,
            small: true,
            loading: loading,
            onClick: () => onOkay(),
          ),
        ],
      ),
    );
  }
}

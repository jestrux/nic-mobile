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
  final bool onBottomSheet;
  final Color? backgroundColor;

  const FormActions({
    Key? key,
    this.okayText = "Okay",
    this.onOkay = Constants.randoFunction,
    this.cancelText = "Cancel",
    this.onCancel,
    this.loading = false,
    this.onBottomSheet = false,
    this.padding,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // colorScheme(context).onBackground.withOpacity(0.04)
    var defaultBackground = colorScheme(context).onBackground.withOpacity(0.1);
    var defaultPadding = onBottomSheet
        ? const EdgeInsets.only(
            top: 12,
            left: 24,
            right: 24,
          )
        : const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          );

    var content = onCancel == null
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: FormButton.filled(
              okayText,
              loading: loading,
              onClick: () => onOkay(),
            ),
          )
        : Row(
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
          );

    return Container(
      padding: onCancel == null ? null : padding ?? defaultPadding,
      decoration: BoxDecoration(
        // border: Border(
        //   top: BorderSide(
        //     width: 0.5,
        //     color: colorScheme(context).onBackground.withOpacity(0.04),
        //   ),
        // ),
        color: onCancel == null ? null : backgroundColor ?? defaultBackground,
      ),
      child: onBottomSheet ? SafeArea(child: content) : content,
    );
  }
}

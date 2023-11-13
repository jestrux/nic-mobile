import 'package:flutter/material.dart';
import 'package:nic/components/Loader.dart';
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
            vertical: 6,
            horizontal: 12,
          ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.5,
            color: colorScheme(context).outlineVariant,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (onCancel != null)
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                  colorScheme(context).onBackground,
                ),
                visualDensity: VisualDensity.compact,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                ),
              ),
              onPressed: () {
                onCancel!();
              },
              child: const Text("Cancel"),
            ),
          const SizedBox(width: 8),
          FilledButton(
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
              ),
            ),
            onPressed: loading ? null : () => onOkay(),
            child: Row(
              children: [
                if (loading)
                  const Padding(
                    padding: EdgeInsets.only(right: 6),
                    child: Loader(
                      message: "",
                      loaderSize: 14,
                      loaderStrokeWidth: 2,
                    ),
                  ),
                Text(okayText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

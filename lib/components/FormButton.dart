import 'package:flutter/material.dart';
import 'package:nic/components/Loader.dart';
import 'package:nic/constants.dart';
import 'package:nic/utils.dart';

enum FormButtonVariant { filled, flat, outlined }

class FormButton extends StatelessWidget {
  final String label;
  final bool loading;
  final bool small;
  final FormButtonVariant variant;
  final VoidCallback onClick;

  const FormButton({
    Key? key,
    required this.label,
    this.loading = false,
    this.variant = FormButtonVariant.filled,
    this.small = false,
    required this.onClick,
  }) : super(key: key);

  const FormButton.filled(
    this.label, {
    super.key,
    this.loading = false,
    this.small = false,
    required this.onClick,
  }) : variant = FormButtonVariant.filled;

  const FormButton.outlined(
    this.label, {
    super.key,
    this.loading = false,
    this.small = false,
    required this.onClick,
  }) : variant = FormButtonVariant.outlined;

  const FormButton.flat(
    this.label, {
    super.key,
    this.loading = false,
    this.small = false,
    required this.onClick,
  }) : variant = FormButtonVariant.flat;

  @override
  Widget build(BuildContext context) {
    var filled = variant == FormButtonVariant.filled;

    var style = ButtonStyle(
      backgroundColor: !filled
          ? null
          : MaterialStateProperty.resolveWith((states) {
              if (!states.contains(MaterialState.disabled)) {
                return Constants.primaryColor;
              }

              return null;
            }),
      foregroundColor: filled
          ? MaterialStateProperty.all(Colors.white)
          : MaterialStateProperty.all(colorScheme(context).onBackground),
      overlayColor: filled
          ? null
          : MaterialStateProperty.all(
              colorScheme(context).onBackground.withOpacity(0.06)),
      visualDensity: VisualDensity.compact,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(
          horizontal: 12,
          vertical: small ? 0 : 20,
        ),
      ),
    );

    var onPressed = loading ? null : onClick;

    var child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (loading)
          const Padding(
            padding: EdgeInsets.only(right: 6),
            child: Loader(
              message: "",
              loaderColor: Color(0XFF9F9F9F),
              loaderSize: 14,
              loaderStrokeWidth: 2,
              small: true,
            ),
          ),
        Text(
          label,
          style: TextStyle(
            fontWeight: small ? null : FontWeight.w600,
          ),
        ),
      ],
    );

    if (variant == FormButtonVariant.flat) {
      return TextButton(
        style: style,
        onPressed: onPressed,
        child: child,
      );
    }

    if (variant == FormButtonVariant.outlined) {
      return OutlinedButton(
        style: style,
        onPressed: onPressed,
        child: child,
      );
    }

    return FilledButton(
      style: style,
      onPressed: onPressed,
      child: child,
    );
  }
}

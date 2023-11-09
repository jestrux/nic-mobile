import 'package:flutter/material.dart';

class MiniButton extends StatelessWidget {
  final IconData? leftIcon;
  final IconData? rightIcon;
  final String label;
  final bool filled;
  final bool flat;
  final Color? color;
  final Color? background;
  const MiniButton({
    Key? key,
    required this.label,
    this.leftIcon,
    this.rightIcon,
    this.filled = false,
    this.flat = false,
    this.background,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var textColor = filled
        ? colorScheme.onPrimary
        : flat
            ? colorScheme.primary
            : color;

    double paddingLeft = leftIcon != null ? 0 : 10;
    double paddingRight = rightIcon != null ? 0 : 10;

    if (flat) {
      paddingLeft = 0;
      paddingRight = 0;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        color: filled ? background ?? colorScheme.primary : null,
        border: filled || flat
            ? null
            : Border.all(
                width: 0.6,
                color: colorScheme.outlineVariant,
              ),
      ),
      padding: EdgeInsets.only(
        top: 6,
        bottom: 6,
        left: paddingLeft,
        right: paddingRight,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leftIcon != null)
            Padding(
              padding: flat
                  ? const EdgeInsets.only(top: 1.5, right: 3)
                  : const EdgeInsets.only(top: 1.5, left: 8, right: 3),
              child: Icon(
                leftIcon,
                size: 14,
                color: textColor,
              ),
            ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: textColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (rightIcon != null)
            Padding(
              padding: flat
                  ? const EdgeInsets.only(top: 1.5, left: 3)
                  : const EdgeInsets.only(top: 1.5, left: 3, right: 8),
              child: Icon(
                rightIcon,
                size: 14,
                color: textColor,
              ),
            ),
        ],
      ),
    );
  }
}

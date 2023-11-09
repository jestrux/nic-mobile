import 'package:flutter/material.dart';
import 'package:nic/utils.dart';

class CardWrapper extends StatelessWidget {
  final Widget? child;
  final Color? background;
  final EdgeInsets? padding;

  const CardWrapper({
    Key? key,
    this.padding,
    this.background,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.6,
          color: colorScheme(context).outlineVariant,
        ),
        color:
            background ?? colorScheme(context).surfaceVariant.withOpacity(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: child,
    );
  }
}

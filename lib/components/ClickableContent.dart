import 'package:flutter/material.dart';
import 'package:nic/constants.dart';
import 'package:nic/utils.dart';

class ClickableContent extends StatelessWidget {
  final VoidCallback? onClick;
  final Widget? child;
  final EdgeInsets padding;
  final BoxBorder? border;
  final Color? inkColor;
  const ClickableContent({
    super.key,
    this.child,
    this.inkColor,
    this.onClick = Constants.randoFunction,
    this.padding = EdgeInsets.zero,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    var actualColor = inkColor ?? colorScheme(context).surfaceVariant;

    if (onClick == null) return child ?? Container();

    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          border: border,
        ),
        child: InkWell(
          hoverColor: actualColor,
          focusColor: actualColor,
          highlightColor: actualColor,
          splashColor: actualColor,
          onTap: onClick,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

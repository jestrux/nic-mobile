import 'package:flutter/material.dart';
import 'package:nic/constants.dart';
import 'package:nic/utils.dart';

class ClickableContent extends StatelessWidget {
  final VoidCallback? onClick;
  final Widget? child;
  final EdgeInsets padding;
  final BoxBorder? border;
  const ClickableContent({
    super.key,
    this.child,
    this.onClick = Constants.randoFunction,
    this.padding = EdgeInsets.zero,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    var color = colorScheme(context).surfaceVariant;

    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          border: border,
        ),
        child: InkWell(
          hoverColor: color,
          focusColor: color,
          highlightColor: color,
          splashColor: color,
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

import 'package:flutter/material.dart';
import 'package:nic/constants.dart';

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
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          border: border,
          // shape: BoxShape.circle,
        ),
        child: InkWell(
          // borderRadius: BorderRadius.circular(
          //   100.0,
          // ),
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

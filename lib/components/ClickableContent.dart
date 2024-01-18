import 'package:flutter/material.dart';
import 'package:nic/constants.dart';
import 'package:nic/utils.dart';

class ClickableContent extends StatelessWidget {
  final Function? onClick;
  final Widget? child;
  final EdgeInsets padding;
  final BoxBorder? border;
  final Color? inkColor;
  const ClickableContent({
    super.key,
    this.child,
    this.inkColor,
    this.onClick,
    this.padding = EdgeInsets.zero,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    var actualColor = onClick == null
        ? Colors.transparent
        : inkColor ?? colorScheme(context).surfaceVariant;

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
          onTap: onClick == null
              ? null
              : () {
                  try {
                    onClick!();
                  } catch (e) {
                    var offset = (context.findRenderObject() as RenderBox)
                        .localToGlobal(Offset.zero);
                    onClick!(offset);
                  }
                },
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}

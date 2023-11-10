import 'package:flutter/material.dart';
import 'package:nic/components/ClickableContent.dart';
import 'package:nic/constants.dart';
import 'package:nic/utils.dart';

enum ChoiceItemSize { MD, SM }

class ChoiceItem extends StatelessWidget {
  final VoidCallback onClick;
  final EdgeInsets? padding;
  final Widget? leading;
  final String title;
  final String? subtitle;
  final ChoiceItemSize size;
  final bool? selected;
  final bool modeWhite;

  const ChoiceItem(
    this.title, {
    super.key,
    this.padding,
    this.leading,
    this.subtitle = "",
    this.modeWhite = true,
    this.size = ChoiceItemSize.MD,
    this.selected,
    this.onClick = Constants.randoFunction,
  });

  @override
  Widget build(BuildContext context) {
    Color selectedBgColor = modeWhite
        ? Colors.white.withOpacity(0.11)
        : Colors.black.withOpacity(0.06);

    var defaultContentPadding = leading != null
        ? const EdgeInsets.symmetric(vertical: 8, horizontal: 20)
        : const EdgeInsets.symmetric(vertical: 12, horizontal: 20);

    double selectedIndicatorSize = size == ChoiceItemSize.SM ? 18 : 24;

    return ClickableContent(
      onClick: onClick,
      child: Container(
        padding: padding ?? defaultContentPadding,
        decoration: BoxDecoration(
          // border: Border(
          //   top: BorderSide(
          //     color: borderColor,
          //     width: 1,
          //   ),
          // ),
          // borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: selected ?? false ? selectedBgColor : Colors.transparent,
        ),
        child: Row(
          children: <Widget>[
            if (leading != null)
              Theme(
                data: Theme.of(context).copyWith(
                  iconTheme: Theme.of(context).iconTheme.copyWith(
                        size: 14,
                        color: colorScheme(context).primary,
                      ),
                ),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: colorScheme(context).surfaceVariant.withOpacity(0.6),
                  ),
                  margin: const EdgeInsets.only(right: 10),
                  child: leading,
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 14),
                  ),
                  if (subtitle != null && subtitle!.isNotEmpty)
                    Opacity(
                      opacity: 0.8,
                      child: Text(
                        subtitle!,
                        style: const TextStyle(fontSize: 12),
                      ),
                    )
                ],
              ),
            ),
            // const Spacer(),
            if (selected != null)
              Icon(
                selected! ? Icons.check_circle : Icons.circle_outlined,
                color: selected!
                    ? colorScheme(context).primary
                    : colorScheme(context).onBackground.withOpacity(0.35),
                size: selectedIndicatorSize,
              ),
          ],
        ),
      ),
    );
  }
}

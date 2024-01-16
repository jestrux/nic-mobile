import 'package:flutter/material.dart';
import 'package:nic/components/ClickableContent.dart';
import 'package:nic/utils.dart';

enum ChoiceItemSize { MD, SM }

class ChoiceItem extends StatelessWidget {
  final Function? onClick;
  final EdgeInsets? padding;
  final Widget? leading;
  final String title;
  final String? subtitle;
  final ChoiceItemSize size;
  final bool? selected;

  const ChoiceItem(
    this.title, {
    super.key,
    this.padding,
    this.leading,
    this.subtitle = "",
    this.size = ChoiceItemSize.MD,
    this.selected,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    var defaultContentPadding = leading != null
        ? const EdgeInsets.symmetric(vertical: 8, horizontal: 24)
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
            // color: selected ?? false
            //     ? colorScheme(context).onSurface.withOpacity(0.08)
            //     : Colors.transparent,
            ),
        child: Row(
          children: <Widget>[
            if (leading != null)
              Theme(
                data: Theme.of(context).copyWith(
                  iconTheme: Theme.of(context).iconTheme.copyWith(
                        size: 18,
                        color: colorScheme(context).primary,
                      ),
                ),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: colorScheme(context).surfaceVariant.withOpacity(0.6),
                  ),
                  margin: const EdgeInsets.only(top: 4, right: 16),
                  child: leading,
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16),
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
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(
                  selected! ? Icons.check_circle : Icons.circle_outlined,
                  color: selected!
                      ? colorScheme(context).primary
                      : colorScheme(context).onBackground.withOpacity(0.2),
                  size: selectedIndicatorSize,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

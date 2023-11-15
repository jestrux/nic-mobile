import 'package:flutter/material.dart';
import 'package:nic/components/ListItem.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/utils.dart';

class InlineList extends StatelessWidget {
  final String? title;
  final ActionButton? titleAction;
  final List<ActionItem> data;
  final String? bottomLabel;
  final ActionButton? bottomAction;
  final dynamic leading;

  const InlineList({
    this.title,
    this.titleAction,
    required this.data,
    this.bottomLabel,
    this.bottomAction,
    this.leading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          SectionTitle(
            title: title!,
            action: titleAction,
          ),
          SizedBox(height: titleAction != null ? 0 : 4),
        ],
        Container(
          decoration: BoxDecoration(
            // color: colorScheme(context).background,
            color: colorScheme(context).surfaceVariant.withOpacity(0.25),
            border: Border.all(
              width: 0.6,
              color: colorScheme(context).outlineVariant,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data
                .asMap()
                .map(
                  (i, entry) {
                    List<Widget> trailingWidgets = [
                      if (entry.value != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 1, right: 2),
                          child: Text(
                            entry.value!,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      if (entry.onClick != null)
                        const Opacity(
                          opacity: 0.5,
                          child: Icon(
                            Icons.chevron_right,
                            size: 20,
                          ),
                        )
                    ];

                    entry = entry.cloneWith(
                      leading: entry.leading == null && leading != null
                          ? leading
                          : null,
                      trailing: trailingWidgets.isNotEmpty
                          ? Row(children: trailingWidgets)
                          : null,
                    );

                    return MapEntry(
                      i,
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 0.12,
                              color: i < data.length - 1
                                  ? colorScheme(context).onBackground
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        child: ListItem.fromContent(entry, flat: true),
                      ),
                    );
                  },
                )
                .values
                .toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (bottomLabel != null)
              Text(
                bottomLabel!,
                style: const TextStyle(fontSize: 12),
              ),
            const SizedBox(),
            if (bottomAction != null)
              MiniButton.fromAction(
                bottomAction!,
                onClick: () {
                  if (bottomAction!.onClick == null) return;
                  bottomAction!.onClick!("");
                },
              ),
          ],
        ),
      ],
    );
  }
}

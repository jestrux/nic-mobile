import 'package:flutter/material.dart';
import 'package:nic/components/ListItem.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/utils.dart';

class InlineList extends StatelessWidget {
  final String? title;
  final Map<String, dynamic>? titleAction;
  final List<Map<String, dynamic>> data;
  final String? bottomLabel;
  final Map<String, dynamic>? bottomAction;

  const InlineList({
    this.title,
    this.titleAction,
    required this.data,
    this.bottomLabel,
    this.bottomAction,
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
                      if (entry["trailing"] != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 1, right: 2),
                          child: Text(
                            entry["trailing"],
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      if (entry["onClick"] != null)
                        const Opacity(
                          opacity: 0.5,
                          child: Icon(
                            Icons.chevron_right,
                            size: 20,
                          ),
                        )
                    ];

                    Widget? trailing;
                    if (trailingWidgets.isNotEmpty) {
                      trailing = Row(
                        children: trailingWidgets,
                      );
                    }

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
                        child: ListItem(
                          // margin: const EdgeInsets.only(top: 4, bottom: 6),
                          flat: true,
                          leading: entry["leading"],
                          title: entry["title"],
                          description: entry["description"],
                          trailing: trailing,
                          action: entry["action"],
                        ),
                      ),
                    );
                  },
                )
                .values
                .toList(),
          ),
        ),
        Row(
          // alignment: Alignment.centerRight,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (bottomLabel != null)
              Text(
                bottomLabel!,
                style: const TextStyle(fontSize: 12),
              ),
            if (bottomAction != null)
              MiniButton(
                flat: true,
                label: bottomAction!['label'],
                rightIcon:
                    bottomAction!['icon'] ?? Icons.keyboard_double_arrow_right,
              )
          ],
        ),
      ],
    );
  }
}

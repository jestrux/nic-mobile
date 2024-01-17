import 'package:flutter/material.dart';
import 'package:nic/components/ClickableContent.dart';
import 'package:nic/components/ListItem.dart';
import 'package:nic/utils.dart';

class ExpandableItem extends StatefulWidget {
  final String title;
  final Widget child;
  const ExpandableItem({required this.title, required this.child, Key? key})
      : super(key: key);

  @override
  State<ExpandableItem> createState() => _ExpandableItemState();
}

class _ExpandableItemState extends State<ExpandableItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListItem(
          flat: true,
          leading: Icons.description,
          trailing: Opacity(
            opacity: 0.5,
            child: Icon(
              expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              size: 20,
            ),
          ),
          title: widget.title,
          description: "Click to view",
          onClick: () {
            setState(() {
              expanded = !expanded;
            });
          },
        ),
        AnimatedSize(
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 300),
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme(context).surfaceVariant.withOpacity(0.3),
              border: !expanded
                  ? null
                  : Border(
                      top: BorderSide(
                        width: 0.5,
                        color: colorScheme(context).onSurface.withOpacity(0.2),
                      ),
                    ),
            ),
            child: expanded ? widget.child : Container(),
          ),
        ),
      ],
    );
  }
}

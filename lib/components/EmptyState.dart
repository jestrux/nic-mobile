import 'package:flutter/material.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/utils.dart';

class EmptyState extends StatelessWidget {
  final String? message;
  final ActionItem? action;

  const EmptyState({
    this.message,
    this.action,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      alignment: Alignment.center,
      color: colorScheme(context).onBackground.withOpacity(0.2),
      child: Column(
        children: [
          Text(message ?? "No results found"),
          const SizedBox(height: 6),
          if (action != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MiniButton(
                  label: action!.label,
                  onClick: () {},
                ),
              ],
            ),
        ],
      ),
    );
  }
}

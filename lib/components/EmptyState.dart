import 'package:flutter/material.dart';
import 'package:nic/components/ClickableContent.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/utils.dart';

class EmptyState extends StatelessWidget {
  final String? message;
  final ActionButton? action;

  const EmptyState({
    this.message,
    this.action,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorScheme(context).surfaceVariant.withOpacity(0.25),
        border: Border.all(
          width: 0.6,
          color: colorScheme(context).outlineVariant,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: ClickableContent(
        onClick: action?.onClick == null ? null : action!.onClick,
        child: Container(
          height: 54,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message ?? "No results found",
                style: TextStyle(
                  fontSize: 14,
                  color: colorScheme(context).onBackground.withOpacity(0.4),
                ),
              ),
              const SizedBox(width: 6),
              if (action != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MiniButton.fromAction(action!),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

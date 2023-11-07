import 'package:flutter/material.dart';

class MiniButton extends StatelessWidget {
  final String label;
  final bool filled;
  final Color? color;
  const MiniButton(
      {Key? key, required this.label, this.filled = false, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        color: filled ? colorScheme.primary : null,
        border: filled
            ? null
            : Border.all(
                width: 0.6,
                color: colorScheme.outlineVariant,
              ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 10,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: filled ? colorScheme.onPrimary : color,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

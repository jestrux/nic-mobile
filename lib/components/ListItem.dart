import 'package:flutter/material.dart';
import 'package:nic/components/CardWrapper.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/constants.dart';
import 'package:nic/utils.dart';

class ListItem extends StatelessWidget {
  final MaterialColor? themeColor;
  final String title;
  final EdgeInsets? margin;
  final String? description;
  final Function onAction;
  final String? actionLabel;
  final bool? actionIsFilled;
  final Widget? leading;

  const ListItem({
    Key? key,
    this.themeColor,
    this.margin,
    required this.title,
    this.description,
    this.leading,
    this.onAction = Constants.randoFunction,
    this.actionLabel,
    this.actionIsFilled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var iconBackground = colorScheme(context).primary.withOpacity(0.1);
    var iconColor = colorScheme(context).primary;

    if (themeColor != null) {
      iconBackground = themeColor!.shade100.withOpacity(0.7);
      iconColor = themeColor!.shade900;
    }

    Widget? leadingWidget = leading == null
        ? null
        : Theme(
            data: theme.copyWith(
              iconTheme: theme.iconTheme.copyWith(
                size: 18,
                color: iconColor,
              ),
            ),
            child: Container(
              height: 36,
              width: 36,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: const BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: leading,
            ),
          );

    return Container(
      padding: margin,
      child: CardWrapper(
        child: ListTile(
          leading: leadingWidget,
          contentPadding: EdgeInsets.zero,
          dense: true,
          visualDensity: VisualDensity.compact,
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: description == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(description!),
                ),
          trailing: actionLabel == null
              ? null
              : MiniButton(
                  label: actionLabel!,
                  filled: true,
                  background: themeColor?.shade500,
                ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  final String? image;
  final dynamic leading;

  const ListItem({
    Key? key,
    this.themeColor,
    this.margin,
    required this.title,
    this.description,
    this.image,
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
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: const BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: leading is String
                  ? SvgPicture.asset(
                      "assets/img/quick-actions/$leading.svg",
                      // semanticsLabel: action["name"],
                      colorFilter: ColorFilter.mode(
                        iconColor,
                        BlendMode.srcIn,
                      ),
                    )
                  : leading,
            ),
          );

    if (image != null) {
      leadingWidget = Container(
        margin: const EdgeInsets.only(top: 6, bottom: 6, right: 4),
        height: 40,
        width: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: iconBackground,
          image: DecorationImage(
            image: CachedNetworkImageProvider(image!),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Container(
      padding: margin,
      child: CardWrapper(
        padding: EdgeInsets.only(
          left: image != null ? 8 : 10,
          right: 10,
        ),
        child: Row(
          children: [
            // SizedBox(width: image != null ? 0 : 8),
            if (leadingWidget != null) leadingWidget,
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  if (description != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        description!,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (actionLabel != null)
              MiniButton(
                label: actionLabel!,
                filled: actionIsFilled ?? false,
                background: themeColor?.shade500,
              )
          ],
        ),
      ),
    );
  }
}

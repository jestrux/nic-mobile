import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nic/components/CardWrapper.dart';
import 'package:nic/components/ClickableContent.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/utils.dart';

class ListItem extends StatelessWidget {
  final bool? flat;
  final bool? hasCustomActions;
  final String title;
  final String? description;
  final ActionButton? action;
  final String? image;
  final dynamic trailing;
  final dynamic leading;
  final Function? onClick;
  final ActionItem? content;

  const ListItem({
    Key? key,
    this.flat,
    required this.title,
    this.description,
    this.image,
    this.leading,
    this.trailing,
    this.action,
    this.content,
    this.hasCustomActions,
    this.onClick,
  }) : super(key: key);

  ListItem.fromAction(ActionItem this.content,
      {this.flat, this.hasCustomActions, super.key})
      : title = content.label,
        description = content.description,
        image = content.image,
        leading = content.leading,
        trailing = content.trailing,
        action = content.action,
        onClick = content.onClick;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var iconBackground = colorScheme(context).secondaryContainer;
    var iconColor = colorScheme(context).onSecondaryContainer; //.primary

    // if (themeColor != null) {
    //   iconBackground = themeColor!.shade100.withOpacity(0.7);
    //   iconColor = themeColor!.shade900;
    // }

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
                  : leading is IconData
                      ? Icon(leading)
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

    var itemContent = Row(
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
                  fontSize: 12,
                ),
              ),
              if (description != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Opacity(
                    opacity: 0.7,
                    child: Text(
                      description!,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ),
        // if (trailing != null && action == null)
        if (trailing != null && action == null)
          Opacity(
            opacity: hasCustomActions ?? false ? 1 : 0.6,
            child: trailing is String
                ? Text(
                    trailing,
                    style: const TextStyle(fontSize: 12),
                  )
                : trailing,
          ),
        if (action != null)
          Padding(
            padding: EdgeInsets.only(right: action!.flat ? 4 : 0),
            child: MiniButton.fromAction(
              action!,
              onClick: () {
                if (action!.onClick == null) return;
                action!.onClick!(content);
              },
            ),
          )
      ],
    );

    if (flat ?? false) {
      return ClickableContent(
        onClick: onClick,
        child: Container(
          constraints: BoxConstraints(
            minHeight: description != null ? 56 : 44,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: itemContent,
          ),
        ),
      );
    }

    return ClickableContent(
      onClick: onClick,
      child: Container(
        constraints: BoxConstraints(
          minHeight: description != null ? 56 : 44,
        ),
        child: CardWrapper(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: itemContent,
        ),
      ),
    );
  }
}

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
            child: expanded ? widget.child : Container(),
          ),
        ),
      ],
    );
  }
}

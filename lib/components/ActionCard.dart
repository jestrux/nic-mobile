import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nic/components/ClickableContent.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/utils.dart';

class ActionCard extends StatelessWidget {
  final ActionItem action;
  const ActionCard({
    Key? key,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? image = action.image;
    ActionItemShape shape = action.shape ?? ActionItemShape.rounded;

    bool square = shape == ActionItemShape.square;
    bool rounded = shape == ActionItemShape.rounded;
    bool portrait = shape == ActionItemShape.portrait;
    bool video = shape == ActionItemShape.video;

    var cardBackground =
        colorScheme(context).surfaceVariant.withOpacity(rounded ? 0 : 0.3);

    double radius = rounded ? 50 : 10;
    var iconBackground =
        colorScheme(context).secondaryContainer; //.primary.withOpacity(0.15);
    var iconColor = colorScheme(context).primary; //.onSecondaryContainer;

    // if (themeColor != null) {
    //   iconBackground = themeColor!.shade100.withOpacity(0.5);
    //   iconColor = themeColor!.shade900;
    // }

    var icon = action.icon;
    Widget iconWidget = icon == null
        ? Container()
        : Theme(
            data: Theme.of(context).copyWith(
              iconTheme: Theme.of(context).iconTheme.copyWith(
                    size: 18,
                    color: square ? Colors.white : iconColor,
                  ),
            ),
            child: Container(
              height: 30,
              width: 30,
              margin: const EdgeInsets.symmetric(vertical: 6),
              // padding: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: square
                    ? action.background ?? Colors.orange.shade300
                    : iconBackground,
                borderRadius: BorderRadius.all(
                  Radius.circular(square ? 50 : radius),
                ),
              ),
              child: icon is String
                  ? SvgPicture.asset("assets/img/quick-actions/$icon.svg",
                      semanticsLabel: action.label,
                      colorFilter: ColorFilter.mode(
                        square ? Colors.white : iconColor,
                        BlendMode.srcIn,
                      ))
                  : icon is IconData
                      ? Icon(icon)
                      : icon,
            ),
          );

    Widget RowCard = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: image != null ? 0 : 8),
        image != null
            ? Container(
                height: double.infinity,
                width: 56,
                decoration: BoxDecoration(
                  color: iconBackground,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(image),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : iconWidget,
        SizedBox(width: rounded ? 6 : 8),
        Expanded(
          child: Text(
            action.label,
            style: const TextStyle(
              fontSize: 11,
              height: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 10)
      ],
    );

    Widget SquareCard = Container(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 4,
        bottom: 10,
      ),
      color: cardBackground,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              iconWidget,
              Spacer(),
              Text(
                action.label,
                style: const TextStyle(
                  fontSize: 12,
                  // height: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ],
      ),
    );

    Widget PortraitCard = Container(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: image == null
                  ? null
                  : DecorationImage(
                      image: CachedNetworkImageProvider(image),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0),
                  Colors.black12,
                  Colors.black87,
                  Colors.black
                ],
                // stops: const [0, 0.8, 1],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
              top: 8,
              bottom: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  action.label,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.3,
                    // fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                // const SizedBox(height: 10)
              ],
            ),
          )
        ],
      ),
    );

    Widget VideoCard = Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                image: image == null
                    ? null
                    : DecorationImage(
                        image: CachedNetworkImageProvider(image),
                        fit: BoxFit.cover,
                      ),
              ),
              alignment: Alignment.center,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: colorScheme(context).primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            action.label,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 11,
              overflow: TextOverflow.ellipsis,
              // height: 1.5,
              // fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    return ClipRRect(
      borderRadius: video
          ? BorderRadius.circular(0)
          : BorderRadius.all(Radius.circular(radius)),
      child: ClickableContent(
        inkColor: video ? Colors.transparent : null,
        onClick: () {
          if (action.onClick != null) {
            action.onClick!(action);
          } else if (action.resourceUrl != null) {
            openUrl(action.resourceUrl!);
          }
        },
        child: Container(
          decoration: video
              ? null
              : BoxDecoration(
                  border: Border.all(
                    width: 0.6,
                    color: colorScheme(context).outlineVariant,
                  ),
                  color: cardBackground,
                  borderRadius: BorderRadius.all(Radius.circular(radius)),
                ),
          child: portrait
              ? PortraitCard
              : video
                  ? VideoCard
                  : square
                      ? SquareCard
                      : RowCard,
        ),
      ),
    );
  }
}

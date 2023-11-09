import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nic/components/ClickableContent.dart';
import 'package:nic/utils.dart';

enum ActionCardShape { regular, square, portrait, rounded, video }

class ActionCard extends StatelessWidget {
  final Map<String, dynamic> action;
  final ActionCardShape? shape;
  final MaterialColor? themeColor;
  const ActionCard({
    Key? key,
    required this.action,
    this.shape,
    this.themeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? image = action["image"];
    // String? shape = action["shape"];
    // ActionCardShape _shape =
    //     image != null ? ActionCardShape.regular : ActionCardShape.rounded;
    // if ((shape ?? "") == "regular") _shape = ActionCardShape.regular;
    // double radius = _shape == ActionCardShape.rounded ? 50 : 8;

    bool square = shape == ActionCardShape.square;
    bool rounded = shape == ActionCardShape.rounded;
    bool portrait = shape == ActionCardShape.portrait;
    bool video = shape == ActionCardShape.video;

    var cardBackground =
        colorScheme(context).surfaceVariant.withOpacity(rounded ? 0 : 0.3);

    double radius = rounded ? 50 : 10;
    var iconBackground = colorScheme(context).primary.withOpacity(0.15);
    var iconColor = colorScheme(context).primary;

    if (themeColor != null) {
      iconBackground = themeColor!.shade100.withOpacity(0.5);
      iconColor = themeColor!.shade900;
    }

    Widget icon = action["icon"] == null
        ? Container()
        : Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.symmetric(vertical: 6),
            // padding: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: square
                  ? action['background'] ?? Colors.orange.shade300
                  : iconBackground,
              borderRadius: BorderRadius.all(
                Radius.circular(square ? 50 : radius),
              ),
            ),
            child: SvgPicture.asset(
              "assets/img/quick-actions/${action["icon"]}.svg",
              semanticsLabel: action["name"],
              colorFilter: ColorFilter.mode(
                square ? Colors.white : iconColor,
                BlendMode.srcIn,
              ),
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
            : icon,
        SizedBox(width: rounded ? 6 : 8),
        Expanded(
          child: Text(
            action['name'],
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
              icon,
              Spacer(),
              Text(
                action['name'],
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
      decoration: BoxDecoration(
          // color: cardBackground,
          ),
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
                  action['name'],
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
            action['name'],
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
        onClick: action['action'],
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

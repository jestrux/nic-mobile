import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/utils.dart';

class AdsBanner extends StatefulWidget {
  const AdsBanner({Key? key}) : super(key: key);

  @override
  State<AdsBanner> createState() => _AdsBannerState();
}

class _AdsBannerState extends State<AdsBanner> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 0.35,
      child: Container(
        decoration: BoxDecoration(
          // color: background,
          border: Border.all(
            width: 0.6,
            color: colorScheme(context).outlineVariant,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          child: PageView(
            children: const [
              AdsBarOne(),
              AdsBarTwo(),
            ],
          ),
        ),
      ),
    );
  }
}

class AdsBarOne extends StatelessWidget {
  const AdsBarOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? background;
    Color? textColor;
    String? backgroundImage;
    bool showScrim = false;

    if (true) {
      // background = Colors.white;
      textColor = Colors.white;
    }

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            "assets/img/ads/ad-one.jpg",
          ),
          // image: CachedNetworkImageProvider(
          //     "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDF8fGZhbmN5JTIwaG91c2V8ZW58MHx8fHwxNjk5MzQ5OTM1fDA&ixlib=rb-4.0.3&q=80&w=900"),
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/img/ads/ad-one.jpg",
                ),
                // image: CachedNetworkImageProvider(
                //     "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDF8fGZhbmN5JTIwaG91c2V8ZW58MHx8fHwxNjk5MzQ5OTM1fDA&ixlib=rb-4.0.3&q=80&w=900"),
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
                  Colors.black45,
                  Colors.black54,
                  Colors.black87,
                  Colors.black
                ],
                // stops: const [0, 0.8, 1],
              ),
            ),
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 12,
              left: 12,
              right: 10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Linda Mjengo",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Opacity(
                        opacity: 0.9,
                        child: Text(
                          "Insurance against fire, floods, buglary and \nother sorts of crimes against homes.",
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 12,
                            color: textColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                MiniButton(
                  label: "Learn more",
                  color: textColor,
                  onClick: () async {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdsBarTwo extends StatelessWidget {
  const AdsBarTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? background;
    Color? textColor;
    String? backgroundImage;
    bool showScrim = false;

    if (true) {
      background = Colors.white;
      textColor = Colors.black;
    }

    return Row(
      children: [
        Expanded(
          child: Container(
            color: background,
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 8,
              left: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Affordable car insurance",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Opacity(
                      opacity: 0.85,
                      child: Text(
                        "Covers maintainance cost as well as hospital bill for bodily injury to driver.",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 12,
                          color: textColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                MiniButton(
                  label: "Learn more",
                  color: textColor,
                ),
              ],
            ),
          ),
        ),
        Container(
          // margin: const EdgeInsets.only(left: 8),
          width: 110,
          // color: Colors.red,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                "assets/img/ads/ad-two.jpg",
              ),
              // image: CachedNetworkImageProvider(
              //     "https://images.unsplash.com/photo-1550355291-bbee04a92027?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDEyfHxjYXJ8ZW58MHx8fHwxNjk5Njk2MDcyfDA&ixlib=rb-4.0.3&q=80&w=1080"),
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                left: -1,
                child: SvgPicture.string(
                  """<svg xmlns="http://www.w3.org/2000/svg" width="26" height="150" viewBox="0 0 26 150">
                      <path id="Path_1544" data-name="Path 1544" d="M0,0H26L0,150H0Z" fill="#fff" />
                    </svg>
                    """,
                  colorFilter: ColorFilter.mode(
                    background,
                    BlendMode.srcIn,
                  ),
                  // fit: BoxFit.fitHeight,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

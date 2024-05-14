import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/data/actions.dart';
import 'package:nic/data/providers/AppProvider.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/services/product_service.dart';
import 'package:nic/utils.dart';
import 'package:provider/provider.dart';
// import 'package:skeletonizer/skeletonizer.dart';
// import 'package:ussd_advanced/ussd_advanced.dart';

class AdsBanner extends StatefulWidget {
  const AdsBanner({Key? key}) : super(key: key);

  @override
  State<AdsBanner> createState() => _AdsBannerState();
}

class _AdsBannerState extends State<AdsBanner> {
  List<Map<String, dynamic>>  products =  [
    {
      "title": "Nisogeze",
      "description": "Bima yako, mkopo wako.",
      "mobileImage":"assets/img/ads/nisogeze.jpg",
      "localImage": true,
      "showDesc": false,
      "showTitle":false,
      "openUssd":true,
      "showButton":true,
      "buttonTitle": "Omba Mkopo",
      "ussdData":"*150*44#"

    }
  ];

  @override
  void initState() {
    super.initState();
    fetchPopularProduct();
  }

  // @override
  // void dispose() {
  //   fetchPopularProduct();
  //   super.dispose();
  // }

  Future<void> fetchPopularProduct() async {
    List<Map<String, dynamic>>? productsList;
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);
    if (provider.popularProducts != null) {
      productsList = provider.popularProducts;
      setState(() {
        products = productsList!;
      });

    }else{
      productsList = await getPopularProduct();
      var appendedProduct =  [...products, ...?productsList];
      provider.setPopularProducts(appendedProduct);
      setState(() {
        // APPEND ALL PRODUCT AND NOTIFY LISTENER
        products = appendedProduct;

      });
    }
  }
  
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
          child:Column(
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: CarouselSlider.builder(
                      itemCount: products.length,
                      // itemCount: 2,
                      options: CarouselOptions(
                        autoPlay: products.length > 1 ? true :false,
                        // autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1,
                        aspectRatio: 2.0,
                        initialPage: 0,
                        height: 170,
                        enableInfiniteScroll:
                        true,
                        onPageChanged:
                            (index, data) {
                          // setState(() {
                          //   _imageCurrent = index;
                          // });
                        },
                      ),
                      itemBuilder:
                          (BuildContext context,
                          itemIndex, item) {
                            dynamic product = products[itemIndex];
                        return Center(
                          child:InkWell(
                            splashColor: Colors.green[100],
                            onTap: () {
                            //   pending----
                            },
                            child: AdsBarOne(
                              image: product!['mobileImage'],
                              title : product!['title'],
                              description: product!['description'],
                              data: product
                            ),
                          ),
                        );
                      }
                      ),
                )
              ],
          ),
          // PageView(
          //   children: const [
          //     AdsBarOne(
          //       image: "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDF8fGZhbmN5JTIwaG91c2V8ZW58MHx8fHwxNjk5MzQ5OTM1fDA&ixlib=rb-4.0.3&q=80&w=900",
          //       title : "Linda Mjengo",
          //       description: "Insurance against fire, floods, buglary and \nother sorts of crimes against homes.",
          //     ),
          //     // AdsBarTwo(),
          //   ],
          // ),
        ),
      ),
    ) ;
  }
}

class AdsBarOne extends StatelessWidget {
  final dynamic image;
  final String title;
  final String description;
  final bool showDesc;
  final bool localImage;
  final dynamic data;

  const AdsBarOne({
    required this.image,
    required this.title,
    required this.description,
    this.showDesc = false,
    this.localImage = false,
    required this.data,
    Key? key}) : super(key: key);

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

    return Stack(
      children: [
        const Center(child: CircularProgressIndicator()),
        if (data['localImage'] == true)
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(image),
              ),
            ),
          )
          else
          Container(
          decoration: BoxDecoration(
          image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(image),
          ),
          ),
          )
          ,
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0),
                Colors.black45.withOpacity(0),
                // Colors.black54,
                Colors.black87,
                // Colors.black
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
                    data['showTitle'] == true ?
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ) : const SizedBox(height: 0),
                    const SizedBox(height: 2),
                    data['showDesc'] == true ? Opacity(
                      opacity: 0.9,
                      child: Text(
                        description,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 12,
                          color: textColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ): const SizedBox(height: 0),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              MiniButton(
                label: data['buttonTitle'] ?? "Buy Bima",
                color: textColor,
                filled: true,
                onClick: () async {
                  if(data['openUssd']){
                    openUrl("tel:${data['ussdData']}");
                  }else{
                    handlePurchaseProduct(
                      ActionItem(
                        id: data["id"],
                        label: data["mobileName"],
                        extraData: data,
                        tag: data['tag']

                      ),
                      authUser: Provider.of<AppProvider>(
                        context,
                        listen: false,
                      ).authUser,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
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

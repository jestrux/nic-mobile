import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showGetQuoteModal() {
    // const closeProductPicker = showCustomAlert({
    //     content: (
    //         <ProductPicker
    //             onSelect={(product) => {
    //                 closeProductPicker();
    //                 getQuote(product);
    //             }}
    //         />
    //     ),
    // });
  }

  void navigate() {}

  void route() {}

  List<Map<String, dynamic>> quickActions() {
    return [
      {
        "icon": "calculator",
        "name": "Get a Quote",
        "actions": showGetQuoteModal,
      },
      // {
      //   "icon": "feedback",
      //   "name": "Feedback and Complaints",
      //   "actions": () {
      //     // navigate(route("feedback"));
      //   },
      // },
      // {
      //   "icon": "complaint",
      //   "name": "Complaints",
      //   "actions": () {
      //     navigate(
      //         // route("feedback", {
      //         //     "subPage": "complaints",
      //         // })
      //         );
      //   },
      // },
    ];
  }

  List<Map<String, dynamic>> claimActions() {
    return [
      {
        "icon": "add-file",
        "name": "Report Claim",
        "actions": () {
          navigate(
              // route("claims", {
              //     "subPage": "report",
              // })
              );
        },
      },
      {
        "icon": "contract",
        "name": "Claim Status",
        "actions": () {
          navigate(
              // route("claims", {
              //     "subPage": "status",
              // })
              );
        },
      },
    ];
  }

  List<Map<String, dynamic>> buyBimaActions() {
    return [
      {
        "icon": "save-heart",
        "name": "Life & Saving",
        "actions": () {
          navigate(
              // route("claims", {
              //     "subPage": "report",
              // })
              );
        },
      },
      {
        "icon": "car",
        "name": "Magari",
        "actions": () {
          navigate(
              // route("claims", {
              //     "subPage": "report",
              // })
              );
        },
      },
      {
        "icon": "motorcycle",
        "name": "Pikipiki / Bajaji",
        "actions": () {
          navigate(
              // route("claims", {
              //     "subPage": "status",
              // })
              );
        },
      },
    ];
  }

  List<Map<String, dynamic>> bimaActions() {
    return [
      {
        "icon": "status",
        "name": "Bima Status",
        "actions": () {
          // navigate(
          //     route("bima", {
          //         subPage: "status",
          //     })
          // );
          // let closeStatusModal;

          // closeStatusModal = showCustomAlert({
          //     content: (
          //         <div className="p-5 md:p-6">
          //             <h2 className="text-xl font-bold mb-3">
          //                 Bima status
          //             </h2>

          //             <BimaStatus onClose={() => closeStatusModal()} />
          //         </div>
          //     ),
          // });
        },
      },
      // {
      //     icon: "time",
      //     name: "Bima History",
      //     action: () {
      //         navigate(
      //             route("profile", {
      //                 subPage: "bima-history",
      //             })
      //         );
      //     },
      // },
      // {
      //   "icon": "renewable",
      //   "name": "Bima Renewal",
      //   "actions": () {
      //     // navigate(
      //     //     route("profile", {
      //     //         "subPage": "bima-renewal",
      //     //     })
      //     // );
      //   },
      // },
      // {
      //   "icon": "document",
      //   "name": "Pending Bima",
      //   "actions": () {},
      // },
      // {
      //   "icon": "folder",
      //   "name": "Your Claims",
      //   "actions": () {},
      // },
    ];
  }

  Widget _buildActions(
      {required List<Map<String, dynamic>> actions, int columns = 2}) {
    return GridView(
        primary: false,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: columns,
          childAspectRatio: columns == 2 ? 1 / 0.32 : 1 / 0.15,
        ),
        children: actions.map(
          (action) {
            Widget icon = action["icon"] == null
                ? Container()
                : Container(
                    height: 40,
                    width: 36,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme(context).primary.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    child: SvgPicture.asset(
                      "assets/img/quick-actions/${action["icon"]}.svg",
                      semanticsLabel: action["name"],
                      colorFilter: ColorFilter.mode(
                        colorScheme(context).primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  );

            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.6,
                  color: colorScheme(context).outlineVariant,
                ),
                color: colorScheme(context).surfaceVariant.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  icon,
                  const SizedBox(width: 8, height: 6),
                  Expanded(
                    child: Text(
                      action['name'],
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (action['action'] != null)
                    const MiniButton(label: "Renew", filled: true),
                ],
              ),
            );
          },
        ).toList());
  }

  Widget _buildCardSection(title, actions, {int columns = 2}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        _buildActions(actions: actions, columns: columns),
      ],
    );
  }

  Widget _buildAdsBar() {
    return AspectRatio(
      aspectRatio: 1 / 0.35,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.6,
            color: colorScheme(context).outlineVariant,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDF8fGZhbmN5JTIwaG91c2V8ZW58MHx8fHwxNjk5MzQ5OTM1fDA&ixlib=rb-4.0.3&q=80&w=900"),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black12,
                      Colors.black54,
                      Colors.black
                    ],
                    // stops: const [0, 0.8, 1],
                  ),
                ),
              ),
              Positioned(
                  bottom: 12,
                  left: 16,
                  right: 12,
                  child: DefaultTextStyle(
                    style: TextStyle(color: Colors.white),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Linda Mjengo",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                              ),
                              const SizedBox(height: 2),
                              Opacity(
                                opacity: 0.85,
                                child: Text(
                                  "Insurance against fire, floods, buglary",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 11,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const MiniButton(
                          label: "Learn more",
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // backgroundColor: Constants.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/icon.png',
              width: 40,
            ),
            const SizedBox(width: 12),
            Text(
              "Sisi ndiyo Bima".toUpperCase(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: colorScheme(context).background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildAdsBar(),
              const SizedBox(height: 16),
              _buildActions(actions: [
                ...quickActions(),
                ...claimActions(),
                ...bimaActions(),
              ]),
              // _buildCardSection("Quick Actions",
              //     [...quickActions(), ...claimActions(), ...bimaActions()]),
              const SizedBox(height: 16),
              _buildCardSection("Buy Bima", buyBimaActions()),
              const SizedBox(height: 16),
              // _buildCardSection(
              //   "Your Policies",
              //   [
              //     {
              //       // "icon": "document",
              //       "name": "Pending Bima",
              //       "description": "Expires in two weeks",
              //       "action": {"label": "Renew", "onClick": () {}},
              //     },
              //   ],
              //   columns: 1,
              // ),
              // const SizedBox(height: 16),
              // _buildCardSection("Bima Actions", bimaActions()),
              // const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

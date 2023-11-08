import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nic/components/ActionCard.dart';
import 'package:nic/components/CardWrapper.dart';
import 'package:nic/components/ListItem.dart';
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
      // {
      //   "icon": "calculator",
      //   "name": "Get a Quote",
      //   "actions": showGetQuoteModal,
      // },
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
    ];
  }

  List<Map<String, dynamic>> buyBimaActions() {
    return [
      {
        "background": Colors.orange.shade300,
        "icon": "save-heart",
        "image":
            "https://images.unsplash.com/photo-1560346740-a8678c61a524?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDM2fHxibGFjayUyMGZhbWlseXxlbnwwfHx8fDE2ODQzNTYwNDB8MA&ixlib=rb-4.0.3&q=80&w=900",
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
        "background": Colors.green.shade300,
        "icon": "car",
        "image":
            "https://bsmedia.business-standard.com/_media/bs/img/article/2019-05/25/full/1558730112-9901.jpg",
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
        "background": Colors.purple.shade300,
        "icon": "house",
        "image":
            "https://www.nicinsurance.co.tz/img/uploads/pier_files/Linda-Mjengo_1690709063.png",
        "name": "Linda Mjengo",
        "actions": () {
          navigate(
              // route("claims", {
              //     "subPage": "status",
              // })
              );
        },
      },
      {
        "icon": "motorcycle",
        "image":
            "https://images.unsplash.com/photo-1625043484550-df60256f6ea5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDZ8fG1vdG9yJTIwYmlrZXxlbnwwfHx8fDE2OTQ0MzMzNzR8MA&ixlib=rb-4.0.3&q=80&w=1080",
        "name": "Pikipiki / Bajaji",
        "actions": () {
          navigate(
              // route("claims", {
              //     "subPage": "status",
              // })
              );
        },
      },
      // {
      //   "id": "UHJvZHVjdE5vZGU6MTc0",
      //   "image":
      //       "https://images.unsplash.com/photo-1544016768-982d1554f0b9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDI3fHxhaXJwbGFuZXxlbnwwfHx8fDE2OTk0NDk5MDl8MA&ixlib=rb-4.0.3&q=80&w=1080",
      //   "name": "Travel Insurance",
      // },
      // {
      //   "id": "UHJvZHVjdE5vZGU6MjY=",
      //   "image":
      //       "https://www.nicinsurance.co.tz/img/uploads/pier_files/Motor-Insurance__1690709184.jpg",
      //   "name": "Bima Kubwa ya Binafsi"
      // },
    ];
  }

  List<Map<String, dynamic>> otherActions() {
    return [
      {
        "background": Colors.orange.shade300,
        "icon": "calculator",
        "image":
            "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDF8fGZhbmN5JTIwaG91c2V8ZW58MHx8fHwxNjk5NDU2NTE2fDA&ixlib=rb-4.0.3&q=80&w=1080",
        "name": "Get a Quick Quote",
      },
      {
        "background": Colors.green.shade300,
        "icon": "location",
        "image":
            "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDF8fGZhbmN5JTIwaG91c2V8ZW58MHx8fHwxNjk5NDU2NTE2fDA&ixlib=rb-4.0.3&q=80&w=1080",
        "name": "Our Branches",
      },
      {
        "background": Colors.blue.shade300,
        "icon": "customer-support",
        "image":
            "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDF8fGZhbmN5JTIwaG91c2V8ZW58MHx8fHwxNjk5NDU2NTE2fDA&ixlib=rb-4.0.3&q=80&w=1080",
        "name": "Customer Support",
        "action": () async {
          String? selectedChoice = await Utils.showChoicePicker(
            context,
            choices: [
              "Call Us",
              "Send Email",
              "Submit Feedback",
              "Submit Complaint"
            ],
          );

          if (selectedChoice != null) Utils.showToast(selectedChoice);
        },
      },
    ];
  }

  List<Map<String, dynamic>> quickTipsActions() {
    return [
      {
        "background": Colors.orange.shade300,
        "icon": "calculator",
        "image":
            "https://images.unsplash.com/photo-1626178793926-22b28830aa30?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDF8fGJyb2tlcnxlbnwwfHx8fDE2OTk0NTc4MDF8MA&ixlib=rb-4.0.3&q=80&w=1080",
        "name": "Become an Agent",
      },
      {
        "background": Colors.green.shade300,
        "icon": "location",
        "image":
            "https://images.unsplash.com/photo-1515150144380-bca9f1650ed9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDh8fGZhcm18ZW58MHx8fHwxNjk5NDU4MDc1fDA&ixlib=rb-4.0.3&q=80&w=1080",
        "name": "Insure your farm",
      },
      {
        "background": Colors.blue.shade300,
        "icon": "customer-support",
        "image":
            "https://images.unsplash.com/photo-1554134449-8ad2b1dea29e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDMwfHxjb2luc3xlbnwwfHx8fDE2OTk0NTg1MDd8MA&ixlib=rb-4.0.3&q=80&w=1080",
        "name": "Lipa Kidogo kidogo",
        "action": () async {
          String? selectedChoice = await Utils.showChoicePicker(
            context,
            choices: [
              "Call Us",
              "Send Email",
              "Submit Feedback",
              "Submit Complaint"
            ],
          );

          if (selectedChoice != null) Utils.showToast(selectedChoice);
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
      {
        "icon": "renewable",
        "name": "Bima Renewal",
        "actions": () {
          // navigate(
          //     route("profile", {
          //         "subPage": "bima-renewal",
          //     })
          // );
        },
      },
      {
        "icon": "wallet",
        "name": "Life Contributions",
        "action": () async {
          String? selectedChoice = await Utils.showChoicePicker(
            context,
            // title: "Select action",
            // selected: currency,
            // value: "Show contributions",
            choices: ["Show contributions", "Make contribution"],
            // grid: true,
          );

          if (selectedChoice != null) Utils.showToast(selectedChoice);
          // navigate(
          //     route("profile", {
          //         subPage: "bima-history",
          //     })
          // );
        },
      },
      {
        "icon": "contributions",
        "name": "Changia Bima",
      },
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 6,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  Widget _buildActions({
    required List<Map<String, dynamic>> actions,
    ActionCardShape? shape,
    int? columns,
    MaterialColor? theme,
  }) {
    bool rounded = shape == ActionCardShape.rounded;
    bool portrait = shape == ActionCardShape.portrait;

    var shapeMap = {
      ActionCardShape.rounded: 1 / 0.26,
      ActionCardShape.square: 1 / 1.12,
      ActionCardShape.portrait: 1 / 1.3,
      ActionCardShape.regular: 1 / 0.32,
    };

    return GridView(
        primary: false,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: rounded ? 6 : 8,
          mainAxisSpacing: rounded ? 8 : 8,
          crossAxisCount: columns ?? 2,
          childAspectRatio:
              shapeMap[shape] ?? shapeMap[ActionCardShape.regular]!,
        ),
        children: actions
            .map((action) => ActionCard(
                  action: action,
                  themeColor: theme,
                  shape: shape,
                ))
            .toList());
  }

  Widget _buildCardSection({
    String? title,
    actions,
    ActionCardShape? shape,
    MaterialColor? theme,
    int? columns,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) _buildSectionTitle(title),
        _buildActions(
          actions: actions,
          shape: shape,
          theme: theme,
          columns: columns,
        ),
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
            image: CachedNetworkImageProvider(
              "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDF8fGZhbmN5JTIwaG91c2V8ZW58MHx8fHwxNjk5MzQ5OTM1fDA&ixlib=rb-4.0.3&q=80&w=900",
            ),
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
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildAdsBar(),
              const SizedBox(height: 12),
              const ListItem(
                themeColor: Colors.lightGreen,
                margin: EdgeInsets.symmetric(horizontal: 16),
                leading: Icon(Icons.monetization_on),
                title: "TZS 300,000",
                description: "Total commission this week",
                actionLabel: "View all",
                actionIsFilled: true,
              ),
              const SizedBox(height: 12),
              _buildCardSection(
                title: "Buy Bima",
                actions: buyBimaActions(),
              ),
              const SizedBox(height: 12),
              _buildCardSection(
                title: "Quick actions",
                actions: [
                  ...claimActions(),
                  ...bimaActions(),
                  ...quickActions(),
                ],
                shape: ActionCardShape.rounded,
              ),
              const SizedBox(height: 12),
              _buildCardSection(
                title: "Handy tips",
                actions: quickTipsActions(),
                shape: ActionCardShape.portrait,
                columns: 3,
              ),
              const SizedBox(height: 12),
              _buildCardSection(
                title: "Other Actions",
                actions: otherActions(),
                shape: ActionCardShape.square,
                columns: 3,
              ),
              // const SizedBox(height: 10),
              // _buildSectionTitle("Your claims"),
              // const ListItem(
              //   margin: EdgeInsets.symmetric(horizontal: 16),
              //   leading: Icon(Icons.two_wheeler),
              //   title: "T1241",
              //   description: "Expires in two weeks",
              //   actionLabel: "Renew",
              //   actionIsFilled: true,
              // ),
              // _buildSectionTitle("Your policies"),
              // const ListItem(
              //   margin: EdgeInsets.symmetric(horizontal: 16),
              //   leading: Icon(Icons.two_wheeler),
              //   title: "T1241",
              //   description: "Expires in two weeks",
              //   actionLabel: "Renew",
              //   actionIsFilled: true,
              // ),
              // ListItem(action: action)).toList()
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

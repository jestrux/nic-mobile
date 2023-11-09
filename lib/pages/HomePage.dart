import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nic/components/ActionCard.dart';
import 'package:nic/components/CardWrapper.dart';
import 'package:nic/components/ListItem.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void navigate() {}

  void route() {}

  List<Map<String, dynamic>> quickActions() {
    return [
      // {
      //   "icon": "contract",
      //   "name": "Claim Status",
      // },
      {
        "icon": "add-file",
        "name": "Report Claim",
      },
      {
        "icon": "status",
        "name": "Bima Status",
      },
      // {
      //   "icon": "renewable",
      //   "name": "Bima Renewal",
      // },
      {
        "icon": "wallet",
        "name": "Life Contributions",
        "action": () async {
          String? selectedChoice = await Utils.showChoicePicker(
            context,
            choices: ["Show contributions", "Make contribution"],
          );

          if (selectedChoice != null) Utils.showToast(selectedChoice);
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

  List<Map<String, dynamic>> buyBimaActions() {
    return [
      {
        "background": Colors.orange.shade300,
        "icon": "save-heart",
        "image":
            "https://images.unsplash.com/photo-1560346740-a8678c61a524?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDM2fHxibGFjayUyMGZhbWlseXxlbnwwfHx8fDE2ODQzNTYwNDB8MA&ixlib=rb-4.0.3&q=80&w=900",
        "name": "Life & Saving",
      },
      {
        "background": Colors.green.shade300,
        "icon": "car",
        "image":
            "https://bsmedia.business-standard.com/_media/bs/img/article/2019-05/25/full/1558730112-9901.jpg",
        "name": "Magari",
      },
      {
        "background": Colors.purple.shade300,
        "icon": "house",
        "image":
            "https://www.nicinsurance.co.tz/img/uploads/pier_files/Linda-Mjengo_1690709063.png",
        "name": "Linda Mjengo",
      },
      {
        "icon": "motorcycle",
        "image":
            "https://images.unsplash.com/photo-1625043484550-df60256f6ea5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDZ8fG1vdG9yJTIwYmlrZXxlbnwwfHx8fDE2OTQ0MzMzNzR8MA&ixlib=rb-4.0.3&q=80&w=1080",
        "name": "Pikipiki / Bajaji",
      },
      {
        "icon": "airplane",
        "id": "UHJvZHVjdE5vZGU6MTc0",
        "image":
            "https://images.unsplash.com/photo-1544016768-982d1554f0b9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDI3fHxhaXJwbGFuZXxlbnwwfHx8fDE2OTk0NDk5MDl8MA&ixlib=rb-4.0.3&q=80&w=1080",
        "name": "Travel Insurance",
      },
      // {
      //   "icon": "car",
      //   "id": "UHJvZHVjdE5vZGU6MjY=",
      //   "image":
      //       "https://www.nicinsurance.co.tz/img/uploads/pier_files/Motor-Insurance__1690709184.jpg",
      //   "name": "Bima Kubwa ya Binafsi"
      // },
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

  List<Map<String, dynamic>> otherActions() {
    return [
      {
        "background": Colors.orange.shade300,
        "icon": "calculator",
        "name": "Get a Quick Quote",
      },
      {
        "background": Colors.green.shade300,
        "icon": "money",
        "name": "Make payment",
        "action": () async {
          String? selectedChoice = await Utils.showChoicePicker(
            context,
            choices: ["Pay Now", "Payment Info"],
          );

          if (selectedChoice != null) Utils.showToast(selectedChoice);
        }
      },
      {
        "background": Colors.blue.shade300,
        "icon": "customer-support",
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

  Widget _buildAdsBar() {
    return AspectRatio(
      aspectRatio: 1 / 0.35,
      child: Container(
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
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildAdsBar(),
              // const SizedBox(height: 12),
              // const ListItem(
              //   themeColor: Colors.lightGreen,
              //   margin: EdgeInsets.symmetric(horizontal: 16),
              //   leading: Icon(Icons.monetization_on),
              //   title: "TZS 300,000",
              //   description: "Total commission this week",
              //   action: {"label": "View all", "filled": true},
              // ),
              const SizedBox(height: 12),
              PageSection(
                title: "Buy Bima",
                titleAction: const {
                  "label": "All products",
                  "rightIcon": Icons.keyboard_double_arrow_right,
                },
                actions: buyBimaActions(),
              ),
              const SizedBox(height: 20),
              PageSection(
                title: "Quick actions",
                titleAction: const {
                  "label": "All actions",
                  "rightIcon": Icons.keyboard_double_arrow_right,
                },
                actions: quickActions(),
                shape: ActionCardShape.rounded,
              ),
              const SizedBox(height: 16),
              PageSection(
                title: "Quick Help",
                actions: otherActions(),
                shape: ActionCardShape.square,
                columns: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

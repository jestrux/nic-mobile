import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/constants.dart';
import 'package:nic/data/actions.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/utils.dart';

class HomePage extends StatefulWidget {
  final void Function(int) goToMainPage;
  const HomePage({required this.goToMainPage, Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void navigate() {}

  void route() {}

  void makePaymentAction(item) async {
    String? selectedChoice = await Utils.showChoicePicker(
      context,
      choices: [
        {
          "icon": Icons.attach_money,
          "label": "Pay Now",
        },
        {
          "icon": Icons.question_mark,
          "label": "Payment Information",
        },
      ],
    );

    if (selectedChoice != null) Utils.showToast(selectedChoice);
  }

  void customerSupportAction(item) async {
    String? selectedChoice = await Utils.showChoicePicker(
      context,
      choices: [
        {
          "icon": Icons.phone,
          "label": "Call Us",
        },
        {
          "icon": Icons.mail,
          "label": "Send Email",
        },
        {
          "icon": Icons.chat,
          "label": "Feedback / Complaint",
        },
      ],
    );

    if (selectedChoice == "Call Us") {
      openUrl("tel:${Constants.supportPhoneNumber}");
    } else if (selectedChoice == "Send Email") {
      openUrl("mailto:${Constants.supportEmail}");
    } else if (selectedChoice == "Feedback / Complaint") {
      openUrl(Constants.contactsUrl);
    }
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
              const SizedBox(height: 12),
              // const InlineList(
              //     title: "Your Commissions",
              //     titleAction: {
              //       "label": "View all",
              //       "rightIcon": Icons.keyboard_double_arrow_right
              //     },
              //     // themeColor: Colors.lightGreen,
              //     data: [
              //       {
              //         "leading": Icons.monetization_on,
              //         "title": "TZS 300,000",
              //         "description": "Total collected this week",
              //         // "action": {
              //         //   "label": "View all",
              //         //   "filled": false,
              //         //   "flat": true,
              //         //   "rightIcon": Icons.keyboard_double_arrow_right
              //         // },
              //       }
              //     ]),
              // const SizedBox(height: 12),
              PageSection(
                title: "Buy Bima",
                titleAction: ActionButton.all(
                  "All products",
                  onClick: (item) => widget.goToMainPage(1),
                ),
                content: buyBimaActions,
                shape: ActionItemShape.regular,
              ),
              const SizedBox(height: 16),
              PageSection(
                title: "Common Actions",
                titleAction: ActionButton.all(
                  "All actions",
                  onClick: (item) => widget.goToMainPage(2),
                ),
                content: homePageQuickActions,
                shape: ActionItemShape.rounded,
              ),
              const SizedBox(height: 16),
              PageSection(
                title: "Self Service",
                content: otherActions(
                  makePaymentAction: makePaymentAction,
                  customerSupportAction: customerSupportAction,
                ),
                shape: ActionItemShape.square,
                columns: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nic/components/ActionCard.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/ListItem.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Map<String, dynamic>> policies = [
    {
      "leading": const Icon(Icons.directions_car),
      "title": "T124ADC",
      "description": "Expires in two weeks",
      "action": {"label": "Renew"},
    },
    {
      "leading": const Icon(Icons.directions_car),
      "title": "T311LTY",
      "description": "Covered until January 2024",
      // "action": {"label": "Check status"},
    }
  ];

  List<Map<String, dynamic>> pendingBima = [
    {
      "leading": const Icon(Icons.two_wheeler),
      "title": "Toyota Camry",
      "description": "Created 5 minutes ago",
      "action": {"label": "Pay now", "filled": true},
    }
  ];

  List<Map<String, dynamic>> claims = [
    {
      "leading": const Icon(Icons.post_add),
      "title": "Third party body fatal",
      "description": "Payment approved",
    },
    {
      "leading": const Icon(Icons.post_add),
      "title": "On damage",
      "description": "Submitted two days ago",
      "action": {"label": "Check status"},
    },
  ];

  List<Map<String, dynamic>> lifeContributions = [
    {
      "leading": const Icon(Icons.paid),
      "title": "TZS 50,000",
      "trailing": "October 15th",
    },
    {
      "leading": const Icon(Icons.paid),
      "title": "TZS 33,700",
      "trailing": "July 21st",
    },
    // {
    //   "leading": const Icon(Icons.paid),
    //   "title": "TZS 15,700",
    //   "description": "May 3rd",
    // },
  ];

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
            Text(
              "Your profile".toUpperCase(),
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
          // color: Color(0XFFEAEAEA),
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
              const SizedBox(height: 4),
              const PageSection(
                // title: "Quick Actions",
                actions: [
                  {
                    "icon": "profile",
                    "name": "Account details",
                  },
                  {
                    "icon": "logout",
                    "name": "Logout",
                  },
                ],
                shape: ActionCardShape.rounded,
              ),
              const SizedBox(height: 16),
              InlineList(
                title: "Pending bima",
                data: pendingBima,
              ),
              const SizedBox(height: 18),
              InlineList(
                title: "Recent Claims",
                data: claims,
                bottomLabel: "+1 more",
                bottomAction: const {
                  "label": "All claims",
                },
              ),
              const SizedBox(height: 16),
              InlineList(
                title: "Policies",
                data: policies,
                bottomLabel: "+5 more",
                bottomAction: const {
                  "label": "All policies",
                },
              ),
              const SizedBox(height: 16),
              InlineList(
                title: "Life contributions",
                titleAction: const {
                  "label": "Make Contribution",
                  "leftIcon": Icons.add,
                },
                data: lifeContributions,
                bottomLabel: "+12 more",
                bottomAction: const {
                  "label": "All contributions",
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

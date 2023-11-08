import 'package:flutter/material.dart';
import 'package:nic/components/ActionCard.dart';
import 'package:nic/components/ListItem.dart';
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
      "title": "T1241",
      "description": "Expires in two weeks",
      "actionLabel": "Renew",
    }
  ];

  List<Map<String, dynamic>> pendingBima = [
    {
      "title": "Toyota Camry",
      "description": "Created 5 minutes ago",
      "actionLabel": "Purchase",
    }
  ];

  List<Map<String, dynamic>> claims = [
    {
      "title": "Total loss",
      "description": "Filled two days ago",
      "actionLabel": "Check status",
    }
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
              const SectionTitle(title: "Pending bima"),
              ...pendingBima
                  .map((policy) => ListItem(
                        margin: const EdgeInsets.only(top: 4, bottom: 6),
                        leading: const Icon(Icons.two_wheeler),
                        title: policy["title"],
                        description: policy["description"],
                        actionLabel: policy["actionLabel"],
                        actionIsFilled: true,
                      ))
                  .toList(),
              const SizedBox(height: 16),
              const SectionTitle(title: "Policies"),
              ...policies
                  .map((policy) => ListItem(
                        margin: const EdgeInsets.only(top: 4, bottom: 6),
                        leading: const Icon(Icons.directions_car),
                        title: policy["title"],
                        description: policy["description"],
                        actionLabel: policy["actionLabel"],
                        // actionIsFilled: true,
                      ))
                  .toList(),
              const SizedBox(height: 16),
              const SectionTitle(title: "Recent Claims"),
              ...claims
                  .map((claim) => ListItem(
                        margin: const EdgeInsets.only(top: 4, bottom: 6),
                        leading: const Icon(Icons.post_add),
                        title: claim["title"],
                        description: claim["description"],
                        actionLabel: claim["actionLabel"],
                        actionIsFilled: false,
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}

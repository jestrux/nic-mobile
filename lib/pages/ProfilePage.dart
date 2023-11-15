import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/pages/auth/LoginPage.dart';
import 'package:nic/utils.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<ActionItem> policies = [
    ActionItem(
        label: "T124ADC",
        leading: Icons.directions_car,
        description: "Expires in two weeks",
        action: ActionButton.outlined("Renew")),
    ActionItem(
      label: "T311LTY",
      leading: Icons.directions_car,
      description: "Covered until January 2024",
      // action: ActionButton.outlined("Renew")
    ),
  ];

  List<ActionItem> claims = [
    ActionItem(
      label: "Third party body fatal",
      // leading: Icons.post_add,
      description: "Payment approved",
    ),
    ActionItem(
      label: "On damage",
      description: "Submitted two days ago",
      action: ActionButton.outlined("Check status"),
    ),
  ];

  List<ActionItem> lifeContributions = [
    ActionItem(
      label: "TZS 50,000",
      trailing: "October 15th",
    ),
    ActionItem(
      label: "TZS 33,700",
      trailing: "July 21st",
    ),
    // ActionItem(
    //   icon: Icons.paid,
    //   label: "TZS 15,700",
    //   trailing: "May 3rd",
    // ),
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
              PageSection(
                // title: "Quick Actions",
                content: [
                  ActionItem(
                    label: "Account details",
                    icon: Icons.account_circle,
                  ),
                  ActionItem(
                    label: "Logout",
                    icon: Icons.logout,
                    onClick: (e){
                      Navigator.push( context,CupertinoPageRoute(builder: (context) =>  const LoginPage()));
                    }
                  ),
                ],
                shape: ActionItemShape.rounded,
              ),
              const SizedBox(height: 16),
              InlineList(
                title: "Pending bima",
                data: [
                  ActionItem(
                    leading: const Icon(Icons.two_wheeler),
                    label: "Toyota Camry",
                    description: "Created 5 minutes ago",
                    action: ActionButton.filled("Pay now"),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              InlineList(
                leading: Icons.post_add,
                title: "Recent Claims",
                data: claims,
                bottomLabel: "+1 more",
                bottomAction: ActionButton.all("All claims"),
              ),
              const SizedBox(height: 16),
              InlineList(
                title: "Policies",
                data: policies,
                bottomLabel: "+5 more",
                bottomAction: ActionButton.all("All policies"),
              ),
              const SizedBox(height: 16),
              InlineList(
                leading: Icons.paid,
                title: "Life contributions",
                titleAction: ActionButton.add("Make Contribution"),
                data: lifeContributions,
                bottomLabel: "+12 more",
                bottomAction: ActionButton.all("All contributions"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/components/RoundedHeaderPage.dart';
import 'package:nic/data/preferences.dart';
import 'package:nic/data/providers/AppProvider.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/models/proposal_model.dart';
import 'package:nic/models/user_model.dart';
import 'package:nic/pages/auth/ChangeUserId.dart';
import 'package:nic/pages/auth/LoginPage.dart';
import 'package:nic/pages/auth/changePassword.dart';
import 'package:nic/services/misc_services.dart';
import 'package:nic/services/underwritting_service.dart';
import 'package:nic/utils.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Future<List<Map<String, dynamic>>?> getPendingBima(context) async {
    AppProvider proposalProvider = Provider.of<AppProvider>(context, listen: false);
    if(proposalProvider.proposals.isEmpty){
      await fetchDataAndPersistPendingProposals(context);
    }
    return proposalProvider.proposals.map<Map<String, dynamic>>((proposal) {
      return {
        "title": proposal.policyPropertyName,
        "description": "${proposal.startDate} - ${proposal.endDate}"
      };
    }).toList();
  }

  @override
  void initState() {
    super.initState();
  }
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
    // UserModel? user = context.read<AppProvider>().authUser;
    UserModel? user = Provider.of<AppProvider>(context).authUser;


    return RoundedHeaderPage(
      title: "Your Profile",
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
                // ActionItem(
                //   label: "Account details",
                //   icon: Icons.account_circle,
                // ),
                ActionItem(
                    label: "Change Password",
                    icon: Icons.password,
                    onClick: () async {
                      openAlert(
                        title: "Change My Password",
                        child: const ChangePassword(),
                      );
                    }),
                ActionItem(
                    label: "Update ID Number",
                    icon: Icons.update,
                    onClick: () async {
                      openAlert(
                        title: "Change My Password",
                        child: const ChangeUserId(),
                      );
                    }),
                user != null
                    ? ActionItem(
                        label: "Logout",
                        icon: Icons.logout,
                        onClick: () {
                          String? res =
                              "Welcome ${user!.firstName} ${user!.lastName}, welcome again next time!";
                          showToast(res);
                          persistAuthUser(user = null);
                          clearSpecificData("proposal_data");
                        },
                      )
                    : ActionItem(
                        label: "Login",
                        icon: Icons.login,
                        onClick: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                      )
              ],
              shape: ActionItemShape.rounded,
            ),
            const SizedBox(height: 16),
            const InlineListBuilder(
              future: getPendingBima,
            ),
            // InlineList(
            //   title: "Pending bima",
            //   bottomLabel: "+1 more",
            //   bottomAction: ActionButton.all("View all", onClick: (a) {
            //     openGenericPage(
            //       title: "Pending Bima",
            //       child: const InlineListBuilder(
            //         padding: EdgeInsets.only(
            //           left: 16,
            //           right: 16,
            //           top: 4,
            //           bottom: 20,
            //         ),
            //         future: fetchBranches,
            //       ),
            //     );
            //   }),
            //   data: [
            //     ActionItem(
            //       leading: const Icon(Icons.two_wheeler),
            //       label: "Toyota Camry",
            //       description: "Created 5 minutes ago",
            //       action: ActionButton.filled("Pay now"),
            //     ),
            //   ],
            // ),
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
    );
  }
}

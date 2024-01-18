import 'package:flutter/material.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/components/RoundedHeaderPage.dart';
import 'package:nic/data/preferences.dart';
import 'package:nic/data/providers/AppProvider.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/models/user_model.dart';
import 'package:nic/pages/auth/ChangeUserId.dart';
import 'package:nic/pages/auth/LoginPage.dart';
import 'package:nic/pages/auth/changePassword.dart';
import 'package:nic/services/life/premium_cards.dart';
import 'package:nic/services/underwritting_service.dart';
import 'package:nic/services/claim_service.dart';
import 'package:nic/utils.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<List<Map<String, dynamic>>?> getPendingBima() async {
    AppProvider proposalProvider = Provider.of<AppProvider>(
      context,
      listen: false,
    );

    var proposals = proposalProvider.proposals;

    if (proposals == null) {
      proposals = await fetchProposals();

      if (proposals == null) return null;

      proposalProvider.setProposals(proposals);
    }

    return proposals;
  }

  Future<List<Map<String, dynamic>>?> getReportClaims() async {
    AppProvider proposalProvider = Provider.of<AppProvider>(
      context,
      listen: false,
    );

    var userClaims = proposalProvider.userClaims;

    if (userClaims == null) {
      userClaims = await ClaimService().fetchClaims();

      if (userClaims == null) return null;

      proposalProvider.setClaims(userClaims);
    }

    return userClaims;
  }

  Future<List<Map<String, dynamic>>?> getUserPolicies() async {
    AppProvider proposalProvider = Provider.of<AppProvider>(
      context,
      listen: false,
    );

    var userPolicies = proposalProvider.userPolicies;

    if (userPolicies == null) {
      userPolicies = await fetchUserPolicies();

      if (userPolicies == null) return null;

      proposalProvider.setPolicies(userPolicies);
    }

    return userPolicies;
  }

  Future<List<Map<String, dynamic>>?> getUserContributions() async {
    AppProvider proposalProvider = Provider.of<AppProvider>(
      context,
      listen: false,
    );

    var userContributions = proposalProvider.userContributions;

    if (userContributions == null) {
      userContributions = await fetchUserLifeContribution();

      if (userContributions == null) return null;

      proposalProvider.setUserContributions(userContributions);
    }

    return userContributions;
  }

  @override
  void initState() {
    super.initState();
  }

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
    // print(user?.totalClaims);
    // print(user?.totalProposals);
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
            InlineListBuilder(
              title: "Pending Bima",
              limit: 2,
              future: getPendingBima,
              iconBuilder: (d) => Icons.pending_actions,
              actionsBuilder: (item) {
                return [
                  if (item.extraData?["controlNumber"] == null &&
                      item.extraData?["isPaid"] == false)
                    MiniButton(
                      label: "Get Bill No.",
                      // filled: true,
                      onClick: () {
                        openInfoAlert(message: "Some alert!");
                      },
                    ),
                  if (item.extraData?["controlNumber"] != null &&
                      item.extraData?["isPaid"] == false)
                    MiniButton(
                      label: "Pay Now",
                      filled: true,
                      onClick: (d) {
                        var data = item.extraData!;
                        devLog("Control number: ${data["controlNumber"]}");

                        openPaymentForm(
                          {
                            "amount": data["actualPremium"],
                            "controlNumber": data["controlNumber"].toString(),
                            "phoneNumber": "",
                          },
                          title:
                              "Make Payment for ${data['policyPropertyName']}",
                        );
                      },
                    )
                ];
              },
            ),
            const SizedBox(height: 16),
            InlineListBuilder(
              title: "Recent Claims",
              limit: 2,
              future: getReportClaims,
              iconBuilder: (d) => Icons.post_add,
              actionsBuilder: (item) {
                return [
                  MiniButton(
                    label: "Check Status",
                    // filled: true,
                    onClick: () {
                      openInfoAlert(message: "Some alert!");
                    },
                  ),
                ];
              },
            ),
            const SizedBox(height: 16),
            InlineListBuilder(
              title: "Policies",
              limit: 2,
              future: getUserPolicies,
              iconBuilder: (d) => Icons.file_present,
              actionsBuilder: (item) {
                return [
                  // MiniButton(
                  //   label: "Check Status",
                  //   // filled: true,
                  //   onClick: () {
                  //     openInfoAlert(message: "Some alert!");
                  //   },
                  // ),
                ];
              },
            ),
            const SizedBox(height: 16),
            InlineListBuilder(
              title: "Life Contributions",
              limit: 2,
              future: getUserContributions,
              iconBuilder: (d) => Icons.file_present,
              actionsBuilder: (item) {
                return [
                  // MiniButton(
                  //   label: "Check Status",
                  //   // filled: true,
                  //   onClick: () {
                  //     openInfoAlert(message: "Some alert!");
                  //   },
                  // ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }
}

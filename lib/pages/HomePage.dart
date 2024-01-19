import 'package:flutter/material.dart';
import 'package:nic/components/AdsBar.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/components/RoundedHeaderPage.dart';
import 'package:nic/data/actions.dart';
import 'package:nic/data/providers/AppProvider.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/models/user_model.dart';
import 'package:nic/pages/IntermediaryDash.dart';
import 'package:nic/utils.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final void Function(int) goToMainPage;
  const HomePage({required this.goToMainPage, Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void navigate() {}

  void route() {}

  @override
  Widget build(BuildContext context) {
    UserModel? userObj = Provider.of<AppProvider>(context).authUser;
    int commissionUpdatedState = Provider.of<AppProvider>(context).commissionUpdatedState;
    double totalNotPaidCommission = Provider.of<AppProvider>(context).totalNotPaidCommission;
    if(commissionUpdatedState == 0  && userObj != null ){
      Provider.of<AppProvider>(context).setCommissionUpdatedState(1);
      Provider.of<AppProvider>(context).setTotalNotCommission();
    }else if(commissionUpdatedState == 2){
      setState(() {
        totalNotPaidCommission = Provider.of<AppProvider>(context).totalNotPaidCommission;
      });
    }
    print(userObj != null);
    print(userObj?.firstName );
    print(userObj?.customerType );

    return RoundedHeaderPage(
      title: "Sisi ndiyo Bima",
      showLogo: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const AdsBanner(),
            const SizedBox(height: 12),
            // SHOW THIS ONLY FOR INTERMEDIARY
            userObj != null && userObj.customerType == 2 ?
            InlineList(
              title: "Your Commissions",
              titleAction: ActionButton.all("Open dashboard",onClick: (d){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>  IntermediaryDash(intermediaryName: userObj.intermediaryName),
                  ),
                );
              }),
              data: [
                ActionItem(
                  leading: Icons.monetization_on,
                  label: formatMoney(totalNotPaidCommission,currency: "TZS"),
                  trailing: "Collected this week",
                ),
              ],
            ) : const SizedBox(height: 0.0),
            const SizedBox(height: 12),
            PageSection(
              title: "Buy Bima",
              titleAction: ActionButton.all(
                "All products",
                onClick: (item) => widget.goToMainPage(1),
              ),
              content: buyBimaActions,
              shape: ActionItemShape.regular,
              onItemClick: (action) {
                handlePurchaseProduct(
                  action,
                  matchTag: true,
                  authUser: Provider.of<AppProvider>(
                    context,
                    listen: false,
                  ).authUser,
                );
              },
            ),
            const SizedBox(height: 16),
            PageSection(
              title: "Common Actions",
              titleAction: ActionButton.all(
                "All actions",
                onClick: (item) => widget.goToMainPage(2),
              ),
              content: [
                reportClaimAction,
                bimaStatusAction,
                lifeContributionsAction,
                // changiaBimaAction,
                policyDocumentsAction,
              ],
              shape: ActionItemShape.rounded,
            ),
            const SizedBox(height: 16),
            PageSection(
              title: "Self Service",
              content: [
                getQuickQuoteAction,
                makePaymentAction,
                customerSupportAction,
              ],
              shape: ActionItemShape.square,
              columns: 3,
            ),
          ],
        ),
      ),
    );
  }
}

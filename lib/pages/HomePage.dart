import 'package:flutter/material.dart';
import 'package:nic/components/AdsBar.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/components/RoundedHeaderPage.dart';
import 'package:nic/data/actions.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/models/ActionItem.dart';

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
            InlineList(
              title: "Your Commissions",
              titleAction: ActionButton.all("Open dashboard"),
              data: [
                ActionItem(
                  leading: Icons.monetization_on,
                  label: "TZS 300,000",
                  trailing: "Collected this week",
                ),
              ],
            ),
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
                handlePurchaseProduct(action, matchTag: true);
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
                changiaBimaAction,
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

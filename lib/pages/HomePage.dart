import 'package:flutter/material.dart';
import 'package:nic/components/AdsBar.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/components/RoundedHeaderPage.dart';
import 'package:nic/data/actions.dart';
import 'package:nic/data/providers/AppProvider.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/models/user_model.dart';
import 'package:nic/pages/IntermediaryDash.dart';
import 'package:nic/services/product_service.dart';
import 'package:nic/services/underwritting_service.dart';
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
  void initState() {
    super.initState();
    fetchProductsGlobally();
  }

  Future<void> fetchProductsGlobally() async {
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);
    if (provider.products == null) {
      var products = await getProducts();
      provider.setProducts(products!);
    }
  }
  @override
  Widget build(BuildContext context) {
    UserModel? userObj = Provider.of<AppProvider>(context).authUser;

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
            const SizedBox(height: 5),
            const TotalCommissions(),
            // const SizedBox(height: 0),
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
                userObj != null ? policyDocumentsAction : changiaBimaAction,
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

class TotalCommissions extends StatelessWidget {
  const TotalCommissions({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>?> fetchTotalCommissions() async {
    devLog("Fetch total commissions...");

    Map<String,dynamic> res = await getTotalNotPaidCommission();
    var total = res['total'];
    devLog("Total commissions res: $total");

    return [
      {
        ...res,
        "icon": Icons.monetization_on,
        "title": formatMoney(total, currency: "TZS"),
        "trailing": "Waiting payment",
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    UserModel? userObj = Provider.of<AppProvider>(context).authUser;

    devLog("User type: ${userObj?.customerType}");

    if (userObj?.customerType != 2) return Container();

    return InlineListBuilder(
      title: "Pending Commissions",
      padding: const EdgeInsets.only(bottom: 12),
      actionsBuilder: (item) {
        return [
          MiniButton(
            label: "Open dashboard",
            // filled: true,
            onClick: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      IntermediaryDash(data: item.extraData,intermediaryName: userObj!.intermediaryName),
                ),
              );
            },
          ),
        ];
      },
      future: fetchTotalCommissions,
    );
  }
}

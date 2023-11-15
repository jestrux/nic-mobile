import 'package:flutter/material.dart';
import 'package:nic/components/AdsBar.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/components/modals/BimaStatus.dart';
import 'package:nic/components/modals/GetQuote.dart';
import 'package:nic/constants.dart';
import 'package:nic/data/actions.dart';
import 'package:nic/data/products.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/pages/FormPage.dart';
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

  void handleMakePaymentAction() async {
    String? selectedChoice = await showChoicePicker(
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

    if (selectedChoice != null) showToast(selectedChoice);
  }

  void handleCustomerSupportAction() async {
    String? selectedChoice = await showChoicePicker(
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FormPage(
                        title: action.label,
                      ),
                    ),
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
                content: homePageQuickActions,
                shape: ActionItemShape.rounded,
                onItemClick: (action) {
                  if (action.label == bimaStatusAction.label) {
                    // openErrorAlert(
                    //   title: "Failed to fetch policy",
                    //   message:
                    //       "Please make sure your internet is on and then try again.",
                    // );
                    openAlert(
                      title: "Bima Status",
                      child: const BimaStatus(),
                    );
                    // openBottomSheet(child: const BimaStatus());
                  }
                },
              ),
              const SizedBox(height: 16),
              PageSection(
                title: "Self Service",
                content: [
                  getQuickQuoteAction,
                  makePaymentAction,
                  customerSupportAction,
                ],
                // otherActions(
                //   makePaymentAction: makePaymentAction,
                //   customerSupportAction: customerSupportAction,
                // ),
                shape: ActionItemShape.square,
                columns: 3,
                onItemClick: (action) async {
                  if (action.label == getQuickQuoteAction.label) {
                    var productId = await showChoicePicker(
                      useAlert: true,
                      confirm: true,
                      title: "Select product to get a quote",
                      choices: products.map((product) {
                        return {
                          "label": product["name"],
                          "value": product["id"]
                        };
                      }).toList(),
                    );

                    if (productId != null) {
                      openAlert(
                        child: GetQuote(productId: productId),
                      );
                    }
                  }

                  if (action.label == makePaymentAction.label) {
                    handleMakePaymentAction();
                  }

                  if (action.label == customerSupportAction.label) {
                    handleCustomerSupportAction();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nic/components/KeyValueView.dart';
import 'package:nic/components/PolicyDocumentResults.dart';
import 'package:nic/components/life/lifeSearchForm.dart';
import 'package:nic/components/life/searchPolicies.dart';
import 'package:nic/components/modals/BimaRenewal.dart';
import 'package:nic/components/modals/GetQuote.dart';
import 'package:nic/components/modals/InitialProductForm.dart';
import 'package:nic/components/modals/ProductsByTag.dart';
import 'package:nic/data/products.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/models/user_model.dart';
import 'package:nic/pages/BimaPage.dart';
import 'package:nic/pages/ReportClaimFormPage.dart';
import 'package:nic/pages/auth/LoginPage.dart';
import 'package:nic/services/claim_service.dart';
import 'package:nic/services/payment_service.dart';
import 'package:nic/services/policy_service.dart';
import 'package:nic/services/product_service.dart';
import 'package:nic/utils.dart';
import 'package:nic/constants.dart';
import 'package:provider/provider.dart';

import 'providers/AppProvider.dart';

var claimStatusAction = ActionItem(
  label: "Claim status",
  icon: Icons.pending_actions,
  onClick: () {
    openSingleFormField(
      title: "Check Claim Status",
      label: "Claimant File Number",
      placeholder: "Enter file number here...",
      handler: ClaimService().getClaim,
      onSuccess: (claimant) {
        openAlert(
          title: "Claim Details",
          child: KeyValueView(
            data: {
              "Claimant Number": claimant.claimantNumber,
              "Claimant Name": claimant.fullClaimantName,
              "Intimation Date": {
                "type": "date",
                "value": DateFormat('dd/MM/yyyy').parse(claimant.intimationDate)
              },
              "Claimed Amount": {
                "type": "money",
                "value":
                    claimant.claimAmount == '0E-20' ? 0.0 : claimant.claimAmount
              },
              "NIC Net-payable": claimant.netPayable > 0
                  ? {"type": "money", "value": claimant.netPayable}
                  : 'Not Yet Calculated',
              "Status": {
                "type": "status",
                "value": claimant.claimantStatus,
                "variant": KeyValueStatusVariant.success,
              },
            },
          ),
        );
      },
    );

    // openAlert(
    //   title: "Claim Status",
    //   child: const ClaimStatus(),
    // );
  },
);

var reportClaimAction = ActionItem(
  label: "Report Claim",
  icon: Icons.post_add,
  onClick: () {
    openSingleFormField(
      title: "Report Claim",
      handler: ClaimService().initiateReportClaim,
      onSuccess: (claim) {
        Navigator.push(
          Constants.globalAppKey.currentContext!,
          MaterialPageRoute(
            builder: (context) => ReportClaimForm(
              claimForm: claim['form'],
              formId: claim['proposal'],
              viewMode: 1,
            ),
          ),
        );
      },
    );
    // openAlert(
    //   title: "Report Claim",
    //   child: const ReportClaim(),
    // );
  },
);

var bimaStatusAction = ActionItem(
  label: "Bima Status",
  icon: Icons.timelapse,
  onClick: () {
    openSingleFormField(
      title: "Check Bima Status",
      label: "Policy Reference No.",
      handler: fetchPolicyStatus,
      onSuccess: (policy) {
        openAlert(
          title: "Policy Details",
          child: KeyValueView(
            data: {
              "Policy Number": policy.policyNumber,
              "Assured / Insured": policy.policyPropertyName,
              "Policy Start Date": {"type": "date", "value": policy.startDate},
              "Policy End Date": {"type": "date", "value": policy.endDate},
              "Status": {
                "type": "status",
                "value": policy.isExpired! ? "Expired" : "Active",
                "variant": policy.isExpired!
                    ? KeyValueStatusVariant.danger
                    : KeyValueStatusVariant.success,
              },
            },
          ),
        );
      },
    );

    // openAlert(
    //   title: "Bima Status",
    //   child: const BimaStatus(),
    // );
  },
);

var bimaRenewalAction = ActionItem(
  label: "Bima Renewal",
  icon: Icons.event_repeat,
  onClick: () async {
    openAlert(
      title: "Renew Policy",
      child: const BimaRenewal(
        shortRenewal: false,
      ),
    );
  },
);

var lifeContributionsAction = ActionItem(
  label: "Life Contributions",
  icon: Icons.wallet,
  onClick: () async {
    openAlert(
      title: "Life Contributions(Michango)",
      child: const LifeSearcForm(),
    );
  },
);

var policyDocumentsAction = ActionItem(
  label: "Policy Documents",
  icon: Icons.description,
  onClick: () {
    openSingleFormField(
      title: "Search for policy documents",
      handler: fetchPolicyDocuments,
      onSuccess: (res) => openGenericPage(
        title: "${List.from(res).first['policyPropertyName']} documents",
        child: PolicyDocumentResults(
          policies: res,
        ),
      ),
    );
  },
);

var changiaBimaAction = ActionItem(
  label: "Changia Bima",
  icon: Icons.savings,
  onClick: () async {
    openAlert(title: "Changia Bima", child: const SearchLifePolicy());
  },
);

var getQuickQuoteAction = ActionItem(
  label: "Get a Quick Quote",
  background: Colors.orange.shade300,
  icon: Icons.calculate,
  onClick: () async {
    List<Map<String, dynamic>>? productList;
    var context = Constants.globalAppKey.currentContext!;
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);
    if (provider.products != null) productList =  provider.products;
    productList ??= await getProducts();

    var productId = await showChoicePicker(
      // mode: ChoicePickerMode.alert,
      confirm: true,
      title: "Select product to get a quote",
      choices: productList!.map((product) {
        return {"label": product["mobileName"], "value": product["id"]};
      }).toList(),
    );

    if (productId != null) {
      openBottomSheet(
        ignoreSafeArea: true,
        child: GetQuote(productId: productId),
      );
    }
  },
);

var makePaymentAction = ActionItem(
  label: "Make\npayment",
  background: Colors.green.shade300,
  icon: Icons.paid,
  onClick: () async {
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

    if (selectedChoice == null) return;

    var payingNow = selectedChoice == "Pay Now";

    openSingleFormField(
      title: payingNow ? "Make Payment" : "Fetch Payment Information",
      label: "Enter Control Number",
      placeholder: "",
      handler: fetchPaymentInformation,
      onSuccess: (response) {
        var context = Constants.globalAppKey.currentContext!;

        handlePay() => openPaymentForm(
              amount: response["BillAmount"],
              controlNumber: response["controlNumber"],
              phoneNumber: response["payerPhone"],
            );

        if (payingNow) {
          if (response["isPaid"] ?? false) {
            openInfoAlert(
              message: "Payment already been made for this control number.",
            );
            return;
          }

          handlePay();

          return;
        }

        openAlert(
          title: "Payment Information",
          cancelText: "Close",
          onCancel: () => Navigator.of(context).pop(),
          okayText: "Pay now",
          onOkay: response["isPaid"] ?? false
              ? null
              : () => Navigator.of(context).pop(response),
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: KeyValueView(
              data: {
                "Payment for": response["description"],
                "Receipt #": response["receiptNumber"],
                "Created on": KeyValueBuilder(
                  type: KeyValueType.date,
                  value: response["BillGenDt"],
                ),
                "Due by": KeyValueBuilder(
                  type: KeyValueType.date,
                  value: response["BillExpDt"],
                ),
                "Amount": KeyValueBuilder(
                  type: KeyValueType.money,
                  value: response["BillAmount"],
                ),
                "Status": KeyValueBuilder(
                  value: response["isPaid"] ? "Paid" : "Pending",
                  type: KeyValueType.status,
                  statusVariant: response["isPaid"]
                      ? KeyValueStatusVariant.success
                      : KeyValueStatusVariant.warning,
                ),
                "Payer": "${response['payerName']}( ${response['payerPhone']} )"
              },
            ),
          ),
        ).then((value) {
          if (value != null) handlePay();
        });
      },
    );
  },
);

var customerSupportAction = ActionItem(
    label: "Customer Support",
    background: Colors.blue.shade300,
    icon: Icons.headset_mic,
    onClick: () async {
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

      if (selectedChoice == null) return;

      var url = {
        "Call Us": "tel:${Constants.supportPhoneNumber}",
        "Send Email": "mailto:${Constants.supportEmail}",
        "Feedback / Complaint": Constants.contactsUrl
      }[selectedChoice];

      openUrl(url);
    });

List<ActionItem> bimaPageActions = [
  getQuickQuoteAction,
  bimaStatusAction,
  bimaRenewalAction,
];

List<ActionItem> buyBimaActions = [
  ActionItem(
    id: "UHJvZHVjdE5vZGU6MzAw",
    icon: Icons.volunteer_activism,
    label: "Life & Saving",
    // image:
    //     "https://images.unsplash.com/photo-1560346740-a8678c61a524?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDM2fHxibGFjayUyMGZhbWlseXxlbnwwfHx8fDE2ODQzNTYwNDB8MA&ixlib=rb-4.0.3&q=80&w=900",
    image: "assets/img/bima/life.jpg",
    tag: "life"
  ),
  ActionItem(
    id: "UHJvZHVjdE5vZGU6MTc3",
    icon: Icons.directions_car,
    label: "Magari",
    // image:
    //     "https://bsmedia.business-standard.com/_media/bs/img/article/2019-05/25/full/1558730112-9901.jpg",
    image: "assets/img/bima/magari.png",
    tag: "Vehicle"
  ),
  ActionItem(
    id: "UHJvZHVjdE5vZGU6MzEx",
    icon: Icons.house,
    label: "Linda Mjengo",
    // image:
    //     "https://www.nicinsurance.co.tz/img/uploads/pier_files/Linda-Mjengo_1690709063.png",
    image: "assets/img/bima/linda-mjengo.png",
    tag: "LindaMjengo"
  ),
  ActionItem(
    id: "UHJvZHVjdE5vZGU6MTgx",
    icon: Icons.two_wheeler,
    label: "Pikipiki / Bajaji",
    // image:
    //     "https://images.unsplash.com/photo-1625043484550-df60256f6ea5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDZ8fG1vdG9yJTIwYmlrZXxlbnwwfHx8fDE2OTQ0MzMzNzR8MA&ixlib=rb-4.0.3&q=80&w=1080",
    image: "assets/img/bima/pikipiki.jpg",
    tag: "Motorcycle"
  ),
  ActionItem(
    icon: Icons.flight,
    label: "Travel Insurance",
    // image:
    //     "https://images.unsplash.com/photo-1544016768-982d1554f0b9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDI3fHxhaXJwbGFuZXxlbnwwfHx8fDE2OTk0NDk5MDl8MA&ixlib=rb-4.0.3&q=80&w=1080",
    image: "assets/img/bima/travel.jpg",
    tag: "Travel"
  ),
  ActionItem(
    id: "UHJvZHVjdE5vZGU6MjY=",
    icon: Icons.directions_car,
    label: "Bima Kubwa ya Magari Binafsi",
    // image:
    //     "https://www.nicinsurance.co.tz/img/uploads/pier_files/Motor-Insurance__1690709184.jpg",
    image: "assets/img/bima/bima-kubwa-binafsi.jpg",
    tag: "bimaKubwaBinafsi"
  ),
];

Future<bool?> buyForOther(String productName, UserModel? authUser) async {
  if (authUser == null) return true;

  var res = await showChoicePicker(
    title: "Purchase $productName",
    // mode: ChoicePickerMode.alert,
    choices: [
      {"icon": Icons.person, "label": "For yourself"},
      {"icon": Icons.record_voice_over, "label": "For someone else"},
    ],
    confirm: true,
  );

  if (res == null) return null;

  return res != "For yourself";
}

void handlePurchaseProduct(
  ActionItem product, {
  UserModel? authUser,
  bool matchTag = false,
}) async {
  if (product.id == null) {
    return openInfoAlert(
      title: "Product upcoming",
      message: "Please come and check again soon!",
    );
  }

  String? selectedChoice;
  if (authUser == null){
    selectedChoice = await showChoicePicker(
      choices: [
        {
          "icon": Icons.login,
          "label": "Login Now",
        },
        {
          "icon": Icons.next_plan_outlined,
          "label": "Proceed without login",
        },
      ],
    );
    print("choice---: $selectedChoice");
    if (selectedChoice == null) return;
    if (selectedChoice == "Login Now"){
      // return;
      Navigator.push(
        Constants.globalAppKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => const LoginPage(popWindow: true),
        ),
      );

    }
  }
  if (selectedChoice == "Login Now") return;
  var tag;
  if(product.tag !=  null){
    tag = product.tag;
  }else{
    var tagMap = {
      "UHJvZHVjdE5vZGU6MzAw": "Life",
      "UHJvZHVjdE5vZGU6MTc3": "Vehicle",
      "UHJvZHVjdE5vZGU6MTgx": "Motorcycle",
    };
    tag = tagMap[product.id];

  }

  if (matchTag && tag != null) {
    var res = await openBottomSheet(
      ignoreSafeArea: true,
      child: ProductsByTag(tag: tag),
    );

    if (res == null) return;

    product = ActionItem(
      id: res["id"],
      label: res["mobileName"],
      extraData:res,
      tag:res['tag']
    );
  }


  var buyForOtherCheck = await buyForOther(product.label, authUser);

  if (buyForOtherCheck == null) return;

  openGenericPage(
    title: "Purchase Product",
    subtitle: product.label,
    child: InitialProductForm(
      productId: product.id!,
      productName: product.label,
      buyForOther: buyForOtherCheck,
      extraData: product.extraData
    ),
  );
}

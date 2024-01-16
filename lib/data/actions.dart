import 'package:flutter/material.dart';
import 'package:nic/components/life/lifeSearchForm.dart';
import 'package:nic/components/life/searchPolicies.dart';
import 'package:nic/components/modals/BimaRenewal.dart';
import 'package:nic/components/modals/BimaStatus.dart';
import 'package:nic/components/modals/ClaimStatus.dart';
import 'package:nic/components/modals/GetQuote.dart';
import 'package:nic/components/modals/InitialProductForm.dart';
import 'package:nic/components/modals/PaymentInformation.dart';
import 'package:nic/components/modals/ReportClaim.dart';
import 'package:nic/components/modals/ProductsByTag.dart';
import 'package:nic/data/products.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/models/user_model.dart';
import 'package:nic/utils.dart';
import 'package:nic/constants.dart';

var claimStatusAction = ActionItem(
  label: "Claim status",
  icon: Icons.pending_actions,
  onClick: () async {
    openAlert(
      title: "Claim Status",
      child: const ClaimStatus(),
    );
  },
);

var reportClaimAction = ActionItem(
    label: "Report Claim",
    icon: Icons.post_add,
    onClick: () async {
      openAlert(
        title: "Report Claim",
        child: const ReportClaim(),
      );
    });

var bimaStatusAction = ActionItem(
  label: "Bima Status",
  icon: Icons.timelapse,
  onClick: () async {
    openAlert(
      title: "Bima Status",
      child: const BimaStatus(),
    );
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

var changiaBimaAction = ActionItem(
    label: "Changia Bima",
    icon: Icons.savings,
    onClick: () async {
      openAlert(title: "Changia Bima", child: const SearchLifePolicy());
    });

var getQuickQuoteAction = ActionItem(
  label: "Get a Quick Quote",
  background: Colors.orange.shade300,
  icon: Icons.calculate,
  onClick: () async {
    var productId = await showChoicePicker(
      // mode: ChoicePickerMode.alert,
      confirm: true,
      title: "Select product to get a quote",
      choices: products.map((product) {
        return {"label": product["name"], "value": product["id"]};
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

    openAlert(
      title: "Enter payment control number",
      child: PaymentInformation(
        skipPaymentPreview: selectedChoice == "Pay Now",
      ),
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
    image:
        "https://images.unsplash.com/photo-1560346740-a8678c61a524?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDM2fHxibGFjayUyMGZhbWlseXxlbnwwfHx8fDE2ODQzNTYwNDB8MA&ixlib=rb-4.0.3&q=80&w=900",
  ),
  ActionItem(
    id: "UHJvZHVjdE5vZGU6MTc3",
    icon: Icons.directions_car,
    label: "Magari",
    image:
        "https://bsmedia.business-standard.com/_media/bs/img/article/2019-05/25/full/1558730112-9901.jpg",
  ),
  ActionItem(
    id: "UHJvZHVjdE5vZGU6MzEx",
    icon: Icons.house,
    label: "Linda Mjengo",
    image:
        "https://www.nicinsurance.co.tz/img/uploads/pier_files/Linda-Mjengo_1690709063.png",
  ),
  ActionItem(
    id: "UHJvZHVjdE5vZGU6MTgx",
    icon: Icons.two_wheeler,
    label: "Pikipiki / Bajaji",
    image:
        "https://images.unsplash.com/photo-1625043484550-df60256f6ea5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDZ8fG1vdG9yJTIwYmlrZXxlbnwwfHx8fDE2OTQ0MzMzNzR8MA&ixlib=rb-4.0.3&q=80&w=1080",
  ),
  ActionItem(
    icon: Icons.flight,
    label: "Travel Insurance",
    image:
        "https://images.unsplash.com/photo-1544016768-982d1554f0b9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDI3fHxhaXJwbGFuZXxlbnwwfHx8fDE2OTk0NDk5MDl8MA&ixlib=rb-4.0.3&q=80&w=1080",
  ),
  ActionItem(
    id: "UHJvZHVjdE5vZGU6MjY=",
    icon: Icons.directions_car,
    label: "Bima Kubwa ya Binafsi",
    image:
        "https://www.nicinsurance.co.tz/img/uploads/pier_files/Motor-Insurance__1690709184.jpg",
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

  var tagMap = {
    "UHJvZHVjdE5vZGU6MzAw": "Life",
    "UHJvZHVjdE5vZGU6MTc3": "Vehicle",
    "UHJvZHVjdE5vZGU6MTgx": "Motorcycle",
  };

  var tag = tagMap[product.id];

  if (matchTag && tag != null) {
    var res = await openBottomSheet(
      ignoreSafeArea: true,
      child: ProductsByTag(tag: tag),
    );

    if (res == null) return;

    product = ActionItem(
      id: res["id"],
      label: res["mobileName"],
    );
  }

  var buyForOtherCheck = await buyForOther(product.label, authUser);

  if (buyForOtherCheck == null) return;

  openGenericPage(
    title: "Purchase ${product.label}",
    child: InitialProductForm(
      productId: product.id!,
      productName: product.label,
      buyForOther: buyForOtherCheck,
    ),
  );
}

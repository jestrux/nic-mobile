import 'package:flutter/material.dart';
import 'package:nic/models/ActionItem.dart';

var claimStatusAction =
    ActionItem(label: "Claim status", icon: Icons.pending_actions);
var reportClaimAction = ActionItem(label: "Report Claim", icon: Icons.post_add);
var bimaStatusAction = ActionItem(label: "Bima Status", icon: Icons.timelapse);
var bimaRenewalAction =
    ActionItem(label: "Bima Renewal", icon: Icons.event_repeat);
var lifeContributionsAction =
    ActionItem(label: "Life Contributions", icon: Icons.wallet);
var changiaBimaAction = ActionItem(label: "Changia Bima", icon: Icons.savings);
var getQuickQuoteAction = ActionItem(
  label: "Get a Quick Quote",
  background: Colors.orange.shade300,
  icon: Icons.calculate,
);
var makePaymentAction = ActionItem(
  label: "Make payment",
  background: Colors.green.shade300,
  icon: Icons.paid,
);
var customerSupportAction = ActionItem(
  label: "Customer Support",
  background: Colors.blue.shade300,
  icon: Icons.headset_mic,
);

List<ActionItem> homePageQuickActions = [
  reportClaimAction,
  bimaStatusAction,
  lifeContributionsAction,
  changiaBimaAction,
];

List<ActionItem> utilitiesPageActions = [
  claimStatusAction,
  reportClaimAction,
  bimaStatusAction,
  bimaRenewalAction,
  lifeContributionsAction,
  changiaBimaAction,
];

List<ActionItem> bimaPageActions = [
  getQuickQuoteAction,
  bimaStatusAction,
  bimaRenewalAction,
];

List<ActionItem> buyBimaActions = [
  ActionItem(
    icon: Icons.volunteer_activism,
    label: "Life & Saving",
    image:
        "https://images.unsplash.com/photo-1560346740-a8678c61a524?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDM2fHxibGFjayUyMGZhbWlseXxlbnwwfHx8fDE2ODQzNTYwNDB8MA&ixlib=rb-4.0.3&q=80&w=900",
  ),
  ActionItem(
    icon: Icons.directions_car,
    label: "Magari",
    image:
        "https://bsmedia.business-standard.com/_media/bs/img/article/2019-05/25/full/1558730112-9901.jpg",
  ),
  ActionItem(
    icon: Icons.house,
    label: "Linda Mjengo",
    image:
        "https://www.nicinsurance.co.tz/img/uploads/pier_files/Linda-Mjengo_1690709063.png",
  ),
  ActionItem(
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
    icon: Icons.directions_car,
    label: "Bima Kubwa ya Binafsi",
    image:
        "https://www.nicinsurance.co.tz/img/uploads/pier_files/Motor-Insurance__1690709184.jpg",
  ),
];

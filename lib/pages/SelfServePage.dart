import 'package:flutter/material.dart';
import 'package:nic/components/ActionCard.dart';
import 'package:nic/components/ListItem.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/utils.dart';

class SelfServePage extends StatefulWidget {
  const SelfServePage({Key? key}) : super(key: key);

  @override
  State<SelfServePage> createState() => _SelfServePageState();
}

class _SelfServePageState extends State<SelfServePage> {
  List<Map<String, dynamic>> quickActions() {
    return [
      {
        "icon": "contract",
        "name": "Claim Status",
      },
      {
        "icon": "add-file",
        "name": "Report Claim",
      },
      {
        "icon": "status",
        "name": "Bima Status",
      },
      {
        "icon": "renewable",
        "name": "Bima Renewal",
      },
      {
        "icon": "wallet",
        "name": "Life Contributions",
        "action": () async {
          String? selectedChoice = await Utils.showChoicePicker(
            context,
            // title: "Select action",
            // selected: currency,
            // value: "Show contributions",
            choices: ["Show contributions", "Make contribution"],
          );

          if (selectedChoice != null) Utils.showToast(selectedChoice);
        },
      },
      {
        "icon": "contributions",
        "name": "Changia Bima",
      },
    ];
  }

  List<Map<String, dynamic>> resources = [
    {
      "title": "Claim form",
    },
    {
      "title": "Vendor form",
    }
  ];

  List<Map<String, dynamic>> watchAndlearnActions() {
    return [
      {
        "image":
            "https://i.ytimg.com/vi/AA0dSQCRBJY/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGEggZShXMA8=&rs=AOn4CLCWAkGVhpgTFtn9OBWGAz4oAx1P6w",
        "name": "Wekeza na BIMA ya Maisha (BeamLife) Kutoka NIC INSURANCE",
        "video": "https://www.youtube.com/watch?v=AA0dSQCRBJY",
      },
      {
        "image":
            "https://i.ytimg.com/vi/XLKhaVLFXJ4/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGFIgXihlMA8=&rs=AOn4CLCeamp7ZEtndZ-lX25ncg4gD2V2Kw",
        "name":
            "Wakulima washikwa mkono na NIC Insurance kwa kuanzisha BIMA ya Kilimo",
        "video": "https://www.youtube.com/watch?v=XLKhaVLFXJ4",
      },
      {
        "image":
            "https://i.ytimg.com/vi/KOLJORmuvTQ/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGFIgXihlMA8=&rs=AOn4CLCeamp7ZEtndZ-lX25ncg4gD2V2Kw",
        "name":
            "Zifahamu Faida za BIMA ya Maisha (BeamLife) kutoka NIC Insurance",
        "video": "https://www.youtube.com/watch?v=KOLJORmuvTQ",
      },
    ];
  }

  List<Map<String, dynamic>> quickTipsActions() {
    return [
      {
        "background": Colors.orange.shade300,
        "icon": "calculator",
        "image":
            "https://images.unsplash.com/photo-1626178793926-22b28830aa30?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDF8fGJyb2tlcnxlbnwwfHx8fDE2OTk0NTc4MDF8MA&ixlib=rb-4.0.3&q=80&w=1080",
        "name": "Become an Agent",
      },
      {
        "background": Colors.green.shade300,
        "icon": "location",
        "image":
            "https://images.unsplash.com/photo-1631193816258-28b44b21e78b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDExfHxvZmZpY2UlMjBzcGFjZXxlbnwwfHx8fDE2OTk1MTQ5ODl8MA&ixlib=rb-4.0.3&q=80&w=1080",
        "name": "Rent One of Our Spaces",
      },
      {
        "background": Colors.blue.shade300,
        "icon": "customer-support",
        "image":
            "https://images.unsplash.com/photo-1554134449-8ad2b1dea29e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDMwfHxjb2luc3xlbnwwfHx8fDE2OTk0NTg1MDd8MA&ixlib=rb-4.0.3&q=80&w=1080",
        "name": "Lipa Kidogo kidogo",
        "action": () async {
          String? selectedChoice = await Utils.showChoicePicker(
            context,
            choices: [
              "Call Us",
              "Send Email",
              "Submit Feedback",
              "Submit Complaint"
            ],
          );

          if (selectedChoice != null) Utils.showToast(selectedChoice);
        },
      },
    ];
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
            Text(
              "Self Serve".toUpperCase(),
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
              const SizedBox(height: 4),
              PageSection(
                padding: EdgeInsets.zero,
                // title: "Handy tips",
                actions: quickTipsActions(),
                shape: ActionCardShape.portrait,
                columns: 3,
              ),
              const SizedBox(height: 16),
              PageSection(
                padding: EdgeInsets.zero,
                title: "Quick Actions",
                actions: quickActions(),
                shape: ActionCardShape.rounded,
                columns: 2,
              ),
              const SizedBox(height: 16),
              const SectionTitle(title: "Resources"),
              ...resources
                  .map((resource) => ListItem(
                        margin: const EdgeInsets.only(top: 4, bottom: 6),
                        leading: const Icon(Icons.description),
                        title: resource["title"],
                        description: resource["description"],
                        action: const {
                          "leftIcon": Icons.download,
                          "label": "Download",
                          // "flat": true
                        },
                      ))
                  .toList(),
              const SizedBox(height: 14),
              PageSection(
                padding: EdgeInsets.zero,
                title: "Watch and Learn",
                actions: watchAndlearnActions(),
                shape: ActionCardShape.video,
                columns: 2,
              ),
              // const SectionTitle(title: "FAQs"),
              // ...resources
              //     .map((resource) => ListItem(
              //           margin: const EdgeInsets.only(top: 4, bottom: 6),
              //           leading: const Icon(Icons.keyboard_arrow_down),
              //           title: resource["title"],
              //           description: resource["description"],
              //         ))
              //     .toList(),
            ],
          ),
        ),
      ),
    );
  }
}

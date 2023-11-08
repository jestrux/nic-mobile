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
        "background": Colors.orange.shade300,
        "icon": "calculator",
        "name": "Get a Quick Quote",
      },
      {
        "background": Colors.green.shade300,
        "icon": "location",
        "name": "Our Branches",
      },
      {
        "background": Colors.blue.shade300,
        "icon": "customer-support",
        "name": "Customer Support",
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

  List<Map<String, dynamic>> resources = [
    {
      "title": "Claims form",
      "actionLabel": "Download",
    },
    {
      "title": "Vendor form",
      "actionLabel": "Download",
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
                // title: "Quick Actions",
                actions: quickActions(),
                shape: ActionCardShape.square,
                columns: 3,
              ),
              const SizedBox(height: 16),
              const SectionTitle(title: "Resources"),
              ...resources
                  .map((resource) => ListItem(
                        margin: const EdgeInsets.only(top: 4, bottom: 6),
                        leading: Icon(Icons.description),
                        title: resource["title"],
                        description: resource["description"],
                        actionLabel: resource["actionLabel"],
                        actionIsFilled: false,
                      ))
                  .toList(),
              const SizedBox(height: 16),
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

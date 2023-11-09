import 'package:flutter/material.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/ListItem.dart';
import 'package:nic/utils.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  List<Map<String, dynamic>> branches = [
    {
      "title": "Tandahimba",
      "description": "Right next to bus station",
    }
  ];

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
              "More".toUpperCase(),
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
              const SizedBox(height: 8),
              InlineList(data: [
                {"title": "Language", "trailing": "English", "onClick": () {}},
                {"title": "Theme", "trailing": "Automatic", "onClick": () {}},
              ]),
              const SizedBox(height: 20),
              InlineList(data: [
                {"title": "Our branches", "onClick": () {}},
                {"title": "Submit Feedback", "onClick": () {}},
              ]),
              const SizedBox(height: 20),
              InlineList(data: [
                {"title": "Terms and policies", "onClick": () {}},
                {"title": "Service level agreement", "onClick": () {}},
              ]),
              // const SizedBox(height: 20),
              // const InlineList(data: [
              //   {"title": "App Version", "trailing": "0.2.5"},
              // ]),
            ],
          ),
        ),
      ),
    );
  }
}

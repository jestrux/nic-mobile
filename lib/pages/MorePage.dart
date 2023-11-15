import 'package:flutter/material.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/components/RoundedHeaderPage.dart';
import 'package:nic/data/preferences.dart';
import 'package:nic/data/providers/AppProvider.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/utils.dart';
import 'package:provider/provider.dart';

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
    var currentTheme = Provider.of<AppProvider>(context).theme;

    return RoundedHeaderPage(
      title: "More",
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 4),
            PageSection(
              content: [
                ActionItem(label: "Nearby branches", icon: Icons.explore),
                ActionItem(label: "Update app", icon: Icons.security_update),
              ],
              shape: ActionItemShape.rounded,
            ),
            const SizedBox(height: 20),
            InlineList(data: [
              // ActionItem(
              //   label: "Language",
              //   value: "English",
              //   onClick: (item) {},
              // ),
              ActionItem(
                label: "Theme",
                value: currentTheme,
                onClick: () async {
                  var theme = await showChoicePicker(
                    choices: ["light", "dark", "system"],
                    value: currentTheme,
                  );

                  if (theme != null) {
                    setTheme(context: context, theme: theme);
                  }
                },
              ),
            ]),
            const SizedBox(height: 20),
            InlineList(data: [
              ActionItem(
                label: "Our branches",
                onClick: (item) {},
              ),
              ActionItem(
                label: "Submit Feedback",
                onClick: (item) {},
              ),
            ]),
            const SizedBox(height: 20),
            InlineList(data: [
              ActionItem(
                label: "Terms and policies",
                onClick: (item) {},
              ),
              ActionItem(
                label: "Service level agreement",
                onClick: (item) {},
              ),
            ]),
            // const SizedBox(height: 20),
            // const InlineList(data: [
            //   {"title": "App Version", "trailing": "0.2.5"},
            // ]),
          ],
        ),
      ),
    );
  }
}

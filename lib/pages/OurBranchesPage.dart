import 'package:flutter/material.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/components/RoundedHeaderPage.dart';
import 'package:nic/constants.dart';
import 'package:nic/data/providers/AppProvider.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/services/misc_services.dart';
import 'package:nic/utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OurBranchesPage extends StatelessWidget {
  const OurBranchesPage({Key? key}) : super(key: key);

  void openGoogleMap() {
    try {
      launchUrl(
        Uri.parse(
            "https://www.google.com/maps/place/NIC+Insurance/@-6.8159397,39.2903665,17z/data=!3m1!4b1!4m6!3m5!1s0x185c4b103a6c557d:0x267e2848f72c7e76!8m2!3d-6.8159397!4d39.2903665!16s%2Fg%2F11vlhqm3cd?hl=en-TZ&entry=ttu"),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      try {
        launchUrl(
          Uri.parse("https://maps.app.goo.gl/SEdc3zSEQwqaHCWy9?g_st=ic"),
          mode: LaunchMode.externalApplication,
        );
      } catch (e) {
        try {
          openUrl(Constants.hqMapLocation);
        } catch (e) {}
      }
    }
    ;
  }

  Future<List<Map<String, dynamic>>?> fetchBranches(
    BuildContext context,
  ) async {
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);

    if (provider.branches != null) return provider.branches;

    var branches = await getBranches();

    if (branches == null) return null;

    provider.setBranches(branches);

    return branches;
  }

  @override
  Widget build(BuildContext context) {
    return RoundedHeaderPage(
      title: "Our Branches",
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              color: colorScheme(context).onSurface.withOpacity(0.06),
              border: const Border(bottom: BorderSide(width: 0.1)),
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    "HQ Branch: Ilala, Dar es Salaam",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          // fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(height: 10),
                PageSection(
                  content: [
                    ActionItem(
                      icon: Icons.email,
                      label: "Email Us",
                      background:
                          colorScheme(context).background.withOpacity(0.5),
                      onClick: () {
                        openUrl("mailto:${Constants.supportEmail}");
                      },
                    ),
                    ActionItem(
                      icon: Icons.phone,
                      label: "Free Call",
                      background:
                          colorScheme(context).background.withOpacity(0.5),
                      onClick: () {
                        openUrl("tel:${Constants.supportPhoneNumber}");
                      },
                    ),
                    ActionItem(
                      icon: Icons.location_pin,
                      label: "Location",
                      background:
                          colorScheme(context).background.withOpacity(0.5),
                      onClick: openGoogleMap,
                    )
                  ],
                  columns: 3,
                  // shape: ActionItemShape.square,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 16),
                  InlineListBuilder(
                    future: () => fetchBranches(context),
                    iconBuilder: (item) => Icons.house,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

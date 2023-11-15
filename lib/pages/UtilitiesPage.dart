import 'package:flutter/material.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/ListItem.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/components/RoundedHeaderPage.dart';
import 'package:nic/data/actions.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/utils.dart';

class UtilitiesPage extends StatefulWidget {
  const UtilitiesPage({Key? key}) : super(key: key);

  @override
  State<UtilitiesPage> createState() => _UtilitiesPageState();
}

class _UtilitiesPageState extends State<UtilitiesPage> {
  List<ActionItem> resources = [
    ActionItem(
      label: "Claim form",
      resourceUrl: "https://www.youtube.com/watch?v=aqz-KE-bpKQ",
      action: ActionButton.flat(
        "Download",
        leftIcon: Icons.download,
        onClick: (item) => openUrl(item.resourceUrl),
      ),
    ),
    ActionItem(
      label: "Vendor form",
      resourceUrl: "https://www.youtube.com/watch?v=aqz-KE-bpKQ",
      onClick: (item) => openUrl(item.resourceUrl),
      action: ActionButton.flat(
        "Download",
        leftIcon: Icons.download,
        onClick: (item) => openUrl(item.resourceUrl),
      ),
    ),
  ];

  List<ActionItem> watchAndlearnActions() {
    return [
      ActionItem(
        image:
            "https://i.ytimg.com/vi/AA0dSQCRBJY/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGEggZShXMA8=&rs=AOn4CLCWAkGVhpgTFtn9OBWGAz4oAx1P6w",
        label: "Wekeza na BIMA ya Maisha (BeamLife) Kutoka NIC INSURANCE",
        resourceUrl: "https://www.youtube.com/watch?v=AA0dSQCRBJY",
      ),
      ActionItem(
        image:
            "https://i.ytimg.com/vi/XLKhaVLFXJ4/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGFIgXihlMA8=&rs=AOn4CLCeamp7ZEtndZ-lX25ncg4gD2V2Kw",
        label:
            "Wakulima washikwa mkono na NIC Insurance kwa kuanzisha BIMA ya Kilimo",
        resourceUrl: "https://www.youtube.com/watch?v=XLKhaVLFXJ4",
      ),
      ActionItem(
        image:
            "https://i.ytimg.com/vi/KOLJORmuvTQ/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGFIgXihlMA8=&rs=AOn4CLCeamp7ZEtndZ-lX25ncg4gD2V2Kw",
        label:
            "Zifahamu Faida za BIMA ya Maisha (BeamLife) kutoka NIC Insurance",
        resourceUrl: "https://www.youtube.com/watch?v=KOLJORmuvTQ",
      ),
    ];
  }

  List<ActionItem> quickTipsActions() {
    return [
      ActionItem(
        label: "Become an Agent",
        image:
            "https://images.unsplash.com/photo-1626178793926-22b28830aa30?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDF8fGJyb2tlcnxlbnwwfHx8fDE2OTk0NTc4MDF8MA&ixlib=rb-4.0.3&q=80&w=1080",
      ),
      ActionItem(
        label: "Rent One of Our Spaces",
        image:
            "https://images.unsplash.com/photo-1631193816258-28b44b21e78b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDExfHxvZmZpY2UlMjBzcGFjZXxlbnwwfHx8fDE2OTk1MTQ5ODl8MA&ixlib=rb-4.0.3&q=80&w=1080",
      ),
      ActionItem(
        label: "Lipa Kidogo kidogo",
        image:
            "https://images.unsplash.com/photo-1554134449-8ad2b1dea29e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxNjE2NXwwfDF8c2VhcmNofDMwfHxjb2luc3xlbnwwfHx8fDE2OTk0NTg1MDd8MA&ixlib=rb-4.0.3&q=80&w=1080",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return RoundedHeaderPage(
      title: "Utilities",
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 4),
            PageSection(
              padding: EdgeInsets.zero,
              content: quickTipsActions(),
              shape: ActionItemShape.portrait,
              columns: 3,
            ),
            const SizedBox(height: 16),
            PageSection(
              padding: EdgeInsets.zero,
              title: "Quick Actions",
              content: utilitiesPageActions,
              shape: ActionItemShape.rounded,
              columns: 2,
            ),
            const SizedBox(height: 16),
            InlineList(
              title: "Resources",
              data: resources,
              leading: Icons.description,
            ),
            const SizedBox(height: 20),
            PageSection(
              padding: EdgeInsets.zero,
              title: "Watch and Learn",
              content: watchAndlearnActions(),
              shape: ActionItemShape.video,
              columns: 2,
            ),
          ],
        ),
      ),
    );
  }
}

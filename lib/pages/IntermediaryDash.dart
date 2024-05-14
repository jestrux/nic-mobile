import 'package:flutter/material.dart';
import 'package:nic/components/DocumentViewer.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/KeyValueView.dart';
import 'package:nic/components/MiniButton.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/components/RoundedHeaderPage.dart';
import 'package:nic/data/providers/AppProvider.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/services/underwritting_service.dart';
import 'package:nic/utils.dart';
import 'package:provider/provider.dart';

class IntermediaryDash extends StatelessWidget {
  final String? intermediaryName;
  final dynamic data;
  const IntermediaryDash({required this.intermediaryName, required this.data, Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>?> fetchCommissionStatement(
      {
      required BuildContext context,
      int pageNumber = 1,
        int pageMaxSize = 100,
        int pageState = 1
}
      ) async {
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);

    if (provider.commissionStatement != null) return provider.commissionStatement;

    var commissionStatements = await getCommissionStatement(pageNumber,pageMaxSize,pageState);

    if (commissionStatements == null) return null;

    provider.setCommissionStatement(commissionStatements);

    return commissionStatements;
  }
  @override
  Widget build(BuildContext context) {
    return RoundedHeaderPage(
      title: "Your Dashboard",
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
                    intermediaryName.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          // fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(height: 10),
                KeyValueView(
                  data: {
                    "Total General (not paid): ": KeyValueBuilder(
                      value: data['totalGeneral'],
                      type: KeyValueType.money,
                    ),
                    "Total Life (not paid): ": KeyValueBuilder(
                      value: data['totalLife'],
                      type: KeyValueType.money,
                    ),
                  },
                  striped: false,
                  bordered: true,
                ),
                PageSection(
                  content: [
                    ActionItem(
                      icon: Icons.email,
                      label: "Email Us",
                      background:
                          colorScheme(context).background.withOpacity(0.5),
                      onClick: () {

                      },
                    ),
                    ActionItem(
                      icon: Icons.phone,
                      label: "Free Call",
                      background:
                          colorScheme(context).background.withOpacity(0.5),
                      onClick: () {

                      },
                    ),
                    ActionItem(
                      icon: Icons.location_pin,
                      label: "Location",
                      background:
                          colorScheme(context).background.withOpacity(0.5),
                      onClick: (){

                      },
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
                  const SizedBox(height: 8),
                  Text(
                    "General paid statements:",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      // fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InlineListBuilder(
                      limit: 5,
                      actionsBuilder: (item) {
                        return [
                          MiniButton(
                            label: "View",
                            // filled: true,
                            onClick: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DocViewer(
                                    title: "Commission Statement",
                                    path: item.extraData!['statementDocument'],
                                  )));

                            },
                          ),
                        ];
                      },
                      future: () => fetchCommissionStatement(context: context)
                  ),
                  Text(
                    "Life paid statements:",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      // fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

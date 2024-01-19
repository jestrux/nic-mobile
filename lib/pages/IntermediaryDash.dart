import 'package:flutter/material.dart';
import 'package:nic/components/PageSection.dart';
import 'package:nic/components/RoundedHeaderPage.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/utils.dart';

class IntermediaryDash extends StatelessWidget {
  final String? intermediaryName;
  const IntermediaryDash({required this.intermediaryName,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedHeaderPage(
      title: "Intermediary page",
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
                  const SizedBox(height: 16),
                  Container()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

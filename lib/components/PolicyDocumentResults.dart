import 'package:flutter/material.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/ListItem.dart';
import 'package:nic/components/PolicyInfo.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/utils.dart';

class PolicyDocumentResults extends StatelessWidget {
  final List<Map<String, dynamic>> policies;
  const PolicyDocumentResults({required this.policies, Key? key})
      : super(key: key);

  List<Map<String, dynamic>> getChoices(policy) => [
        if (policy["policyDocument"]?.isNotEmpty)
          {
            "icon": Icons.description,
            "label": "Policy Document",
            "title": "Policy Document",
            "value": policy["policyDocument"],
            "onClick": (d) => openDocument(
                  policy["policyDocument"],
                  title: "Policy Document",
                ),
          },
        if (policy["covernoteDocument"]?.isNotEmpty)
          {
            "icon": Icons.description,
            "label": "Covernote Document",
            "title": "Covernote Document",
            "value": policy["covernoteDocument"],
            "onClick": (d) => openDocument(
                  policy["covernoteDocument"],
                  title: "Covernote Document",
                ),
          },
        if (policy["receiptVoucher"]?.isNotEmpty)
          {
            "icon": Icons.description,
            "label": "Receipt Voucher",
            "title": "Receipt Voucher",
            "value": policy["receiptVoucher"],
            "onClick": (d) => openDocument(
                  policy["receiptVoucher"],
                  title: "Receipt Voucher",
                ),
          },
        if (policy["taxinvoiceDocument"]?.isNotEmpty)
          {
            "icon": Icons.description,
            "label": "Tax Invoice Document",
            "title": "Tax Invoice Document",
            "value": policy["taxinvoiceDocument"],
            "onClick": (d) => openDocument(
                  policy["taxinvoiceDocument"],
                  title: "Tax Invoice Document",
                ),
          },
      ];

  Widget _buildDocuments(BuildContext context, policy) {
    var documents = getChoices(policy);

    if (documents.isEmpty) return Container();

    return Container(
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 18,
      ),
      decoration: BoxDecoration(
        color: colorScheme(context).surface,
        border: Border.all(
          width: 0.6,
          color: colorScheme(context).outlineVariant,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: ExpandableItem(
        title: "Policy Documents",
        child: Column(
          children: documents
              .map(
                (choice) => Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 0.12,
                        color: colorScheme(context).onBackground,
                      ),
                    ),
                  ),
                  child: ListItem(
                    flat: true,
                    title: choice["label"],
                    trailing: const Opacity(
                      opacity: 0.5,
                      child: Icon(
                        Icons.chevron_right,
                        size: 20,
                      ),
                    ),
                    onClick: choice["onClick"],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InlineListBuilder(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      future: () async => policies,
      itemBuilder: (item) {
        return Container(
          padding: const EdgeInsets.only(top: 2),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: colorScheme(context).surfaceVariant.withOpacity(0.25),
            border: Border.all(
              color: colorScheme(context).onBackground.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListItem(
                title: item.label,
                description: item.description,
                onClick: () {
                  openBottomSheet(
                    title: "Policy Details",
                    child: PolicyInfo(
                      policy: item.extraData!,
                    ),
                  );
                },
                action: ActionButton.flat(
                  "Policy details",
                  rightIcon: Icons.chevron_right,
                  onClick: (d) => openBottomSheet(
                    title: "Policy Details",
                    child: PolicyInfo(
                      policy: item.extraData!,
                    ),
                  ),
                ),
                flat: true,
              ),
              _buildDocuments(context, item.extraData),
            ],
          ),
        );
      },
    );
  }
}

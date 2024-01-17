import 'package:flutter/material.dart';
import 'package:nic/components/KeyValueView.dart';

class PolicyInfo extends StatelessWidget {
  final Map<String, dynamic> policy;
  const PolicyInfo({required this.policy, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyValueView(
      data: {
        "Policy Number": policy["policyNumber"],
        "Assured / Insured": policy["policyPropertyName"],
        "Policy Start Date": {"type": "date", "value": policy["startDate"]},
        "Policy End Date": {"type": "date", "value": policy["endDate"]},
        "Status": {
          "type": "status",
          "value": policy["isExpired"] ?? false ? "Expired" : "Active",
          "variant": policy["isExpired"] ?? false
              ? KeyValueStatusVariant.danger
              : KeyValueStatusVariant.success,
        },
      },
    );
  }
}

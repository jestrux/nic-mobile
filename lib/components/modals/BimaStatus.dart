import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/KeyValueView.dart';
import 'package:nic/models/policy_model.dart';
import 'package:nic/services/policy_service.dart';
import 'package:nic/utils.dart';

class BimaStatus extends StatefulWidget {
  const BimaStatus({Key? key}) : super(key: key);

  @override
  State<BimaStatus> createState() => _BimaStatusState();
}

class _BimaStatusState extends State<BimaStatus> {
  Future<PolicyModel?> getPolicy(Map<String, dynamic> values) async {
    return await fetchPolicyStatus(searchKey: values["searchKey"]);
  }

  showPolicySummary(dynamic policy) {
    if (policy == null) return;

    var thePolicy = policy as PolicyModel;

    Navigator.of(context).pop();

    var expired = thePolicy.isExpired!;

    openAlert(
      title: "Policy Details",
      child: KeyValueView(
        data: {
          "Policy Number": thePolicy.policyNumber,
          "Assured / Insured": thePolicy.policyPropertyName,
          "Policy Start Date": {"type": "date", "value": thePolicy.startDate},
          "Policy End Date": {"type": "date", "value": thePolicy.endDate},
          "Status": {
            "type": "status",
            "value": expired ? "Expired" : "Active",
            "variant": expired
                ? KeyValueStatusVariant.danger
                : KeyValueStatusVariant.success,
          },
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DynamicForm(
          fields: const [
            DynamicFormField(
              name: "searchKey",
              label: "Policy Reference No.",
              placeholder: "Enter policy number or plate number",
            ),
          ],
          onCancel: () => Navigator.of(context).pop(),
          submitLabel: "Check",
          onSubmit: getPolicy,
          onSuccess: showPolicySummary,
        ),
      ],
    );
  }
}

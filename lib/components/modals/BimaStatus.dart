import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/KeyValueView.dart';
import 'package:nic/models/policy_model.dart';
import 'package:nic/services/policy_service.dart';
import 'package:nic/utils.dart';

class BimaStatusForm extends StatefulWidget {
  const BimaStatusForm({Key? key}) : super(key: key);

  @override
  State<BimaStatusForm> createState() => _BimaStatusFormState();
}

class _BimaStatusFormState extends State<BimaStatusForm> {
  Future<PolicyModel?> getPolicy(Map<String, dynamic> values) async {
    devLog("Form values: $values");
    return fetchPolicyStatus(searchKey: values["searchKey"]);
  }

  showPolicySummary(PolicyModel? policy) {
    if (policy == null) return;

    showAlert(
      context,
      child: KeyValueView(
        data: {
          "Policy Number": policy.policyNumber,
          "Assured / Insured": policy.policyPropertyName,
          "Policy Start Date": {"type": "date", "value": policy.startDate},
          "Policy End Date": {"type": "date", "value": policy.endDate},
          "Status": policy.statusName,
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
          handler: getPolicy,
          onSuccess: (res) => showPolicySummary(res),
          builder: (onSubmit, loading) {
            return AlertActions(
              loading: loading,
              onCancel: () {
                Navigator.of(context).pop();
              },
              okayText: "Check",
              onOkay: onSubmit,
            );
          },
        ),
      ],
    );
  }
}

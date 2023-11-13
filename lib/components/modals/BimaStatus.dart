import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/FormActions.dart';
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
    return await fetchPolicyStatus(searchKey: values["searchKey"]);
  }

  showPolicySummary(dynamic policy) {
    if (policy == null) return;

    var thePolicy = policy as PolicyModel;

    Navigator.of(context).pop();

    showAlert(
      context,
      title: "Policy Details",
      noActions: true,
      child: KeyValueView(
        data: {
          "Policy Number": thePolicy.policyNumber,
          "Assured / Insured": thePolicy.policyPropertyName,
          "Policy Start Date": {"type": "date", "value": thePolicy.startDate},
          "Policy End Date": {"type": "date", "value": thePolicy.endDate},
          "Status": thePolicy.statusName,
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
          onSave: getPolicy,
          onSuccess: showPolicySummary,
          builder: (onSubmit, loading) {
            return FormActions(
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

import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/services/life/customer_policies.dart';
import 'package:nic/utils.dart';

class SearchLifePolicy extends StatefulWidget {
  const SearchLifePolicy({super.key});

  @override
  State<SearchLifePolicy> createState() => _SearchLifePolicyState();
}

class _SearchLifePolicyState extends State<SearchLifePolicy> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: DynamicForm(
      payloadFormat: DynamicFormPayloadFormat.regular,
      fields: const [
        DynamicFormField(
          name: "customerKey",
          label: "Nida Number",
          placeholder: "Enter Nida Number",
        ),
      ],
      onCancel: () => Navigator.of(context).pop(),
      submitLabel: "Check",
      onSubmit: searchPolicies,
      onSuccess: customerPolicies,
    ));
  }

  Future<dynamic> searchPolicies(Map<String, dynamic>? formData) async {
    if (formData == null) return;

    String? customerKey = formData['customerKey'];

    return await getCustomerPolicies(customerId: customerKey);
  }

  void customerPolicies(dynamic policies) async {
    if (policies == null) {
      return null;
    } else {
      Navigator.pop(context);
      print("=========policies ${policies}");

      if (policies.isNotEmpty) {
        var policyId = await showChoicePicker(
            mode: ChoicePickerMode.alert,
            confirm: true,
            title: "Select Policy",
            choices: policies.map((policy) {
              return {"label": policy?.policyNumber, "value": policy?.id};
            }).toList());

        // ignore: unnecessary_null_comparison
        if (policyId != null) {
          print("________not null policy, ${policyId}");
        } else {
          print("_______i have a policy here ");
        }
      } else {
        openErrorAlert(message: "No Policy(ies) for this Customer");
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:nic/color_schemes.g.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/FormActions.dart';
import 'package:nic/components/KeyValueView.dart';
import 'package:nic/models/life/LifepolicyMode.dart';
import 'package:nic/services/life/customer_policies.dart';
import 'package:nic/utils.dart';

class LifeSearcForm extends StatefulWidget {
  const LifeSearcForm({super.key});

  @override
  State<LifeSearcForm> createState() => _LifeSearcFormState();
}

class _LifeSearcFormState extends State<LifeSearcForm> {
  final _key = GlobalKey<FormState>();
  // final Map<String, dynamic> _postData = {};
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Form(
        key: _key,
        child: DynamicForm(
          fields: const [
            DynamicFormField(
              name: "customerKey",
              label: "Customer Number",
              placeholder: "Enter Nida number",
            ),
          ],
          onCancel: () => Navigator.of(context).pop(),
          submitLabel: "Check",
          onSubmit: searchPolicies,
          onSuccess: customerPolicies,
        ),
      ),
    );
  }

  Future<dynamic> searchPolicies(Map<String, dynamic> formData) async {
    return await getCustomerPolicies(customerId: formData['customerKey']);
  }

  void customerPolicies(dynamic results) async {
    if (results == null) {
      return null;
    }

    Navigator.of(context).pop();
    if (results is List<LifePolicyModel>) {
      List<Widget> keyValueViews = [];

      for (var policy in results) {
        keyValueViews.add(
          GestureDetector(
            onTap: () {
              print("Policy Id: ${policy}");
            },
            child: KeyValueView(
              data: {
                "Policy Number": policy.productName,
              },
            ),
          ),
        );
      }

      if (results.isNotEmpty) {
        openAlert(
          title: "Select Policy",
          child: Column(
            children: keyValueViews,
          ),
        );
      } else {
        openErrorAlert(message: "No Policy(ies) for this Data");
      }
    } else {
      print("Invalid type for results. Expected List<LifePolicyModel>.");
    }
  }
}

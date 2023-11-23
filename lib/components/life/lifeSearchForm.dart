import 'package:flutter/material.dart';
import 'package:nic/color_schemes.g.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/FormActions.dart';
import 'package:nic/components/KeyValueView.dart';
import 'package:nic/components/ListItem.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/models/life/LifepolicyModel.dart';
import 'package:nic/pages/FormPage.dart';
import 'package:nic/pages/life/premiumCards.dart';
import 'package:nic/services/life/customer_policies.dart';
import 'package:nic/utils.dart';

class LifeSearcForm extends StatefulWidget {
  const LifeSearcForm({super.key});

  @override
  State<LifeSearcForm> createState() => _LifeSearcFormState();
}

class _LifeSearcFormState extends State<LifeSearcForm> {
  final _key = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();

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
    return Form(
      key: _key,
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
      ),
    );
  }

  Future<dynamic> searchPolicies(Map<String, dynamic>? formData) async {
    if (formData == null) {
      return null;
    }

    String? customerKey = formData['customerKey'];

    return await getCustomerPolicies(customerId: customerKey);
  }

  void customerPolicies(dynamic results) async {
    if (results == null) return;

    if (results is List<LifePolicyModel>) {
      // Navigator.pop(context);
      List<Widget> keyValueViews = [];

      for (var policy in results) {
        keyValueViews.add(Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: ListItem(
            title: "${policy.policyNumber}",
            action: ActionButton(
              label: "Open",
              onClick: (p0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PremiumCard(
                      policyId: '${policy.id}',
                      policyNumber: '${policy.policyNumber}',
                      checkNumber: '${policy.checkNumber}',
                      sumInsured: '${policy.sumInsured}',
                      product: '${policy.product?.name}',
                      customer:
                          '${policy.customer?.firstName} ${policy.customer?.lastName}',
                    ),
                  ),
                );
              },
            ),
          ),
        ));
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
    } else {}
  }
}

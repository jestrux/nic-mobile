import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/Loader.dart';
import 'package:nic/components/PolicyPaymentDetails.dart';
import 'package:nic/services/policy_service.dart';
import 'package:nic/utils.dart';

class BimaRenewal extends StatefulWidget {
  final String? registrationNumber;
  const BimaRenewal({this.registrationNumber, Key? key}) : super(key: key);

  @override
  State<BimaRenewal> createState() => _BimaRenewalState();
}

class _BimaRenewalState extends State<BimaRenewal> {
  Map<String, dynamic>? policyDetails;

  @override
  void initState() {
    super.initState();
    if (widget.registrationNumber != null) {
      fetchPolicyDetails(widget.registrationNumber);
    }
  }

  Future<Map<String, dynamic>?> fetchPolicyDetails(registrationNumber) async {
    var res = await renewPolicy(registrationNumber);

    setState(() {
      policyDetails = res;
    });

    return res;
  }

  showPolicySummary(dynamic details) {
    if (details == null) return;

    Navigator.of(context).pop();

    openAlert(
      title: "Policy Details",
      child: PolicyPaymentDetails(
        details: details,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.registrationNumber == null && policyDetails == null) {
      return DynamicForm(
        // initialValues: const {"registration_number": "t591dtp"},
        payloadFormat: DynamicFormPayloadFormat.regular,
        fields: const [
          DynamicFormField(
            name: "registration_number",
            label: "Registration No.",
            placeholder: "Enter policy number or plate number",
          ),
        ],
        onCancel: () => Navigator.of(context).pop(),
        onSubmit: (values) => fetchPolicyDetails(values["registration_number"]),
      );
    }

    if (policyDetails == null) return const Loader();

    return PolicyPaymentDetails(
      details: policyDetails!,
    );
  }
}

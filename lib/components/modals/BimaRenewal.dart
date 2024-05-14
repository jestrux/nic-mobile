import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/Loader.dart';
import 'package:nic/components/PolicyPaymentDetails.dart';
import 'package:nic/pages/FormPage.dart';
import 'package:nic/services/policy_service.dart';
import 'package:nic/services/product_service.dart';
import 'package:nic/services/underwritting_service.dart';
import 'package:nic/utils.dart';

class BimaRenewal extends StatefulWidget {
  final String? registrationNumber;
  final bool? shortRenewal;
  const BimaRenewal({this.registrationNumber, this.shortRenewal, Key? key})
      : super(key: key);

  @override
  State<BimaRenewal> createState() => _BimaRenewalState();
}

class _BimaRenewalState extends State<BimaRenewal> {
  Map<String, dynamic>? policyDetails;
  Map<String, dynamic>? proposalForm;
  late bool shortRenewal;

  @override
  void initState() {
    super.initState();
    shortRenewal = widget.shortRenewal ?? true;

    if (widget.registrationNumber != null) {
      fetchPolicyDetails(widget.registrationNumber);
    }
  }

  Future<Map<String, dynamic>?> fetchPolicyDetails(registrationNumber) async {
    var res = await renewPolicy(
      registrationNumber,
      shortRenewal: shortRenewal,
    );

    if (!shortRenewal) {
      try {
        if (res == null) throw ();

        var productRes = await getProductById(res['product']);
        if (productRes == null) throw ();

        res['productId'] = productRes['id'];
        res['tag'] = productRes['tag'];

        var proposalRes = await fetchProposalForm(
          productId: res['product'],
          proposal: res['proposal'],
          phoneNumber: "",
          renewal: true,
        );

        if (proposalRes == null) throw ();

        res = {...res, ...proposalRes};

        openProposalForm({
          "productId": res['productId'],
          "proposal": res['proposal'],
          "product": res['product'],
          "tag": res['tag'],
          "form": res['form'],
          "phoneNumber": "",
        });

        return null;
      } catch (e) {
        openErrorAlert(message: "Failed to renew Bima. Please try again!");
      }
    }

    setState(() {
      policyDetails = res;
    });

    return res;
  }

  openProposalForm(Map<String, dynamic> proposalDetails) {
    Navigator.pop(context);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FormPage(
          title: "Renew Policy",
          renewal: true,
          proposalDetails: proposalDetails,
        ),
      ),
    );
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

    if (!shortRenewal) {
      if (proposalForm == null) return Loader();

      return Container();

      // return DynamicForm(
      //   fields: proposalForm,
      //   onSubmit: (payload) async {},
      // );
    }

    return PolicyPaymentDetails(
      details: policyDetails!,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/KeyValueView.dart';
import 'package:nic/models/policy_model.dart';
import 'package:nic/services/claim_service.dart';
import 'package:nic/utils.dart';

class ReportClaim extends StatefulWidget {
  const ReportClaim({Key? key}) : super(key: key);

  @override
  State<ReportClaim> createState() => _ReportClaimState();
}

class _ReportClaimState extends State<ReportClaim> {
    Future<dynamic> reportClaim(Map<String, dynamic> values) async {
      return await ClaimService().reportClaim(registrationNumber: values["registrationNumber"]);
    }

    reportClaimResponse(dynamic claim) {
      print(claim);
    // if (policy == null) return;
    //
    // var thePolicy = policy as PolicyModel;
    //
    // Navigator.of(context).pop();
    //
    // var expired = thePolicy.isExpired!;
    //
    // openAlert(
    //   title: "Policy Details",
    //   child: KeyValueView(
    //     data: {
    //       "Policy Number": thePolicy.policyNumber,
    //       "Assured / Insured": thePolicy.policyPropertyName,
    //       "Policy Start Date": {"type": "date", "value": thePolicy.startDate},
    //       "Policy End Date": {"type": "date", "value": thePolicy.endDate},
    //       "Status": {
    //         "type": "status",
    //         "value": expired ? "Expired" : "Active",
    //         "variant": expired
    //             ? KeyValueStatusVariant.danger
    //             : KeyValueStatusVariant.success,
    //       },
    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DynamicForm(
          payloadFormat: DynamicFormPayloadFormat.regular,
          fields: const [
            DynamicFormField(
              name: "registrationNumber",
              label: "Registration Number",
              placeholder: "Enter policy number or plate number",
            ),
          ],
          onCancel: () => Navigator.of(context).pop(),
          submitLabel: "Report",
          onSubmit: reportClaim,
          onSuccess: reportClaimResponse,
        ),
      ],
    );
  }
}

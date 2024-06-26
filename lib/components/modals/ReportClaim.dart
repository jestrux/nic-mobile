import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/constants.dart';
import 'package:nic/pages/ReportClaimFormPage.dart';
import 'package:nic/services/claim_service.dart';
import 'package:nic/utils.dart';

class ReportClaim extends StatefulWidget {
  const ReportClaim({Key? key}) : super(key: key);

  @override
  State<ReportClaim> createState() => _ReportClaimState();
}

class _ReportClaimState extends State<ReportClaim> {
  Future<dynamic> reportClaim(Map<String, dynamic> values) async {
    return await ClaimService()
        .initiateReportClaim(values["registrationNumber"]);
  }

  reportClaimResponse(dynamic claim) {
    // print(claim);
    Navigator.of(context).pop();
    if (claim == null) {
      return openAlert(
          title: "Report Claim",
          message:
              "Failed find your insured item, communicate with NIC nearest branch. ${Constants.supportPhoneNumber}",
          type: AlertType.error);
    } else if (claim['success'] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReportClaimForm(
            claimForm: claim['form'],
            formId: claim['proposal'],
            viewMode: 1,
          ),
        ),
      );
    }
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
              label: "Policy Reference No.",
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

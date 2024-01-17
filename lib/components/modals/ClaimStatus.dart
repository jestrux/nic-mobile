import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/KeyValueView.dart';
import 'package:nic/models/claim_model.dart';
import 'package:nic/services/claim_service.dart';
import 'package:nic/utils.dart';

class ClaimStatus extends StatefulWidget {
  const ClaimStatus({Key? key}) : super(key: key);

  @override
  State<ClaimStatus> createState() => _ClaimStatusState();
}

class _ClaimStatusState extends State<ClaimStatus> {
  Future<ClaimModel?> getClaim(Map<String, dynamic> values) async {
    return await ClaimService().getClaim(values["searchKey"]);
  }

  showClaimStatus(dynamic claimant) {
    Navigator.of(context).pop();
    if (claimant == null) {
      return openAlert(
          title: "Claim Status",
          message: "Failed find your claim",
          type: AlertType.error);
    }
    var claimAmount =
        claimant.claimAmount == '0E-20' ? 0.0 : claimant.claimAmount;
    openAlert(
      title: "Policy Details",
      child: KeyValueView(
        data: {
          "Claimant Number": claimant.claimantNumber,
          "Claimant Name": claimant.fullClaimantName,
          "Intimation Date": {
            "type": "date",
            "value": DateFormat('dd/MM/yyyy').parse(claimant.intimationDate)
          },
          "Claimed Amount": {"type": "money", "value": claimAmount},
          "NIC Net-payable": claimant.netPayable > 0
              ? {"type": "money", "value": claimant.netPayable}
              : 'Not Yet Calculated',
          "Status": {
            "type": "status",
            "value": claimant.claimantStatus,
            "variant": KeyValueStatusVariant.success,
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
          payloadFormat: DynamicFormPayloadFormat.regular,
          fields: const [
            DynamicFormField(
              name: "searchKey",
              label: "Claimant File No.",
              placeholder: "Enter claimant file no..",
            ),
          ],
          onCancel: () => Navigator.of(context).pop(),
          submitLabel: "Check",
          onSubmit: getClaim,
          onSuccess: showClaimStatus,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/DynamicForm/proccessFields.dart';
import 'package:nic/components/InlineList.dart';
import 'package:nic/components/KeyValueView.dart';
import 'package:nic/components/RoundedHeaderPage.dart';
import 'package:nic/models/ActionButton.dart';
import 'package:nic/models/ActionItem.dart';
import 'package:nic/services/claim_service.dart';
import 'package:nic/utils.dart';

class ReportClaimForm extends StatefulWidget {
  final int formId;
  final dynamic claimForm;
  final int viewMode;
  const ReportClaimForm({
    Key? key,
    this.claimForm,
    required this.formId,
    required this.viewMode,
  }) : super(key: key);

  @override
  State<ReportClaimForm> createState() => _ReportClaimFormState();
}

class _ReportClaimFormState extends State<ReportClaimForm> {
  List<DynamicFormField>? formFields;
  int viewMode = 1;
  dynamic payLoad;

  Future<dynamic> submitClaimForm(dynamic payload) async {
    if ([payload["data"]].contains(null)) return null;
    return await ClaimService().submitClaimForm(proposal: widget.formId,data: payload['data']);
  }

  handleClaimFormResponse(dynamic response){
    // print(response);
    if(response == null || response['success'] == false){
      return openAlert(
          title: "Report Claim",
          message: "Failed to submit, please try again!",
          type: AlertType.error
      );
    }else{
      formFields = null;
      setState(() {
        viewMode = 2;
        payLoad = response;
      });
    }

  }
  @override
  void initState() {
    if(viewMode == 1){
      formFields = processFields(fields: widget.claimForm);
    }
    super.initState();
  }

  Widget buildContent() {
    // print(widget.claimForm);
    // print(widget.viewMode);
    Widget content = Container();
    if (formFields != null && viewMode == 1) {
      content = DynamicForm(
        fields: formFields!,
        onSubmit: submitClaimForm,
        onSuccess: handleClaimFormResponse,
      );
    }else if(viewMode == 2){
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          KeyValueView(
            title: "Notification Summary",
            data: {
              "Notification No.": payLoad["notification"],
              "Insured/Assured": payLoad["propertyName"],
              "Notification Date": {"type": "date","value":DateFormat('dd/MM/yyyy').parse(payLoad["notificationDate"])},
            },
          ),
          const Divider(height: 40, thickness: 0.3),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child:InlineList(
              title: "Download Document(s)",
              data: [
                ActionItem(
                  leading: const Icon(Icons.download),
                  label: "Claim Form",
                  description: "Download or share",
                  action: ActionButton.filled("Download"),
                ),
                ActionItem(
                  leading: const Icon(Icons.download),
                  label: "Acknowledgement Document",
                  description: "Download or share",
                  action: ActionButton.filled("Download"),
                )
              ],
            ),
          )
        ],
      );
    }

    return content;
  }

  @override
  Widget build(BuildContext context) {
    return RoundedHeaderPage(
      // showBackButton: true,
      title: "Report Claim",
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 12),
            buildContent(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

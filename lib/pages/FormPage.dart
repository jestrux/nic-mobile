import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/DynamicForm/proccessFields.dart';
import 'package:nic/components/DynamicForm/sampleFields.dart';
import 'package:nic/components/RoundedHeaderPage.dart';
import 'package:nic/services/underwritting_service.dart';
import 'package:nic/utils.dart';

class FormPage extends StatefulWidget {
  final String title;
  final Map<String, dynamic>? proposalDetails;
  const FormPage({
    Key? key,
    this.proposalDetails,
    this.title = "Form page",
  }) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  Map<String, dynamic>? proposalDetails;
  List<DynamicFormField>? formFields;

  @override
  void initState() {
    proposalDetails = widget.proposalDetails;
    formFields = processFields(
      fields: proposalDetails?["form"] ?? sampleFields,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RoundedHeaderPage(
      // showBackButton: true,
      title: widget.title.toUpperCase(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 12),
            if (formFields != null)
              DynamicForm(
                fields: formFields!,
                onSubmit: (payload) async {
                  if ([payload["data"], proposalDetails].contains(null))
                    return null;

                  return submitProposalForm(
                    productId: proposalDetails!["productId"],
                    proposal: proposalDetails!["proposal"],
                    phoneNumber: proposalDetails!["phoneNumber"],
                    data: payload["data"],
                  );
                },
                onSuccess: (response) {
                  if (response == null) {
                    devLog("No response from submit proposal");
                    return null;
                  }

                  devLog("Submit proposal response $response");
                },
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

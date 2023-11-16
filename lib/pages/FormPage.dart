import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/DynamicForm/proccessFields.dart';
import 'package:nic/components/DynamicForm/sampleFields.dart';
import 'package:nic/components/RoundedHeaderPage.dart';

class FormPage extends StatefulWidget {
  final String title;
  const FormPage({Key? key, this.title = "Form page"}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
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
            DynamicForm(
              fields: processFields(fields: sampleFields)!,
              onSubmit: (d) async {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

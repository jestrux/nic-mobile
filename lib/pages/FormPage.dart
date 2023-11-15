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
  processedFields() {
    var fields = processFields(fields: sampleFields);

    return fields!
        .map(
          (field) => DynamicFormField(
            name: field["name"],
            label: field["label"],
            choices: field["choices"],
            max: field["max_value"],
            min: field["min_value"],
            type: dynamicFormFieldTypeMap[field["type"]] ??
                DynamicFormFieldType.text,
          ),
        )
        .toList();
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
            DynamicForm(
              fields: processedFields(),
              onSubmit: (d) async {},
            ),
          ],
        ),
      ),
    );
  }
}

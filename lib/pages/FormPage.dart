import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/DynamicForm/proccessFields.dart';
import 'package:nic/components/DynamicForm/sampleFields.dart';
import 'package:nic/utils.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  processedFields() {
    var fields = processFields(fields: sampleFields);
    devLog("Sample fields: $fields");

    return fields!
        .map(
          (field) => DynamicFormField(
            name: field["name"],
            label: field["label"],
            choices: field["choices"],
            type: dynamicFormFieldTypeMap[field["type"]] ??
                DynamicFormFieldType.text,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // backgroundColor: Constants.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Form page".toUpperCase(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: colorScheme(context).background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
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
      ),
    );
  }
}

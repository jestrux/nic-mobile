import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nic/utils.dart';

enum DynamicFormFieldType { text, select }

class DynamicFormFieldChoice {
  final String label;
  final String value;

  const DynamicFormFieldChoice({required this.label, required this.value});
}

class DynamicFormField {
  final String name;
  final String? label;
  final DynamicFormFieldType type;
  final String? placeholder;

  const DynamicFormField({
    required this.name,
    this.label,
    this.type = DynamicFormFieldType.text,
    this.placeholder,
  });
}

class DynamicForm extends StatefulWidget {
  final List<DynamicFormField> fields;
  final Future Function(Map<String, dynamic>) handler;
  final Function(dynamic)? onSuccess;
  final Widget Function(Function onSubmit, bool loading)? builder;

  const DynamicForm({
    Key? key,
    required this.fields,
    required this.handler,
    this.onSuccess,
    this.builder,
  }) : super(key: key);

  @override
  State<DynamicForm> createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool loading = false;

  Future<dynamic> onSubmit() async {
    var form = _formKey.currentState;
    if (form == null) return;

    if (!form.saveAndValidate()) return;

    setState(() {
      loading = true;
    });

    dynamic response;

    try {
      response = widget.handler(form.instantValue);
      devLog("Policy: $response");
    } catch (e) {
      devLog("Failed to fetch dynamic form: $e");
      Utils.showToast("Failed to fetch");
    } finally {
      setState(() {
        loading = false;
      });
    }

    if (widget.onSuccess != null) widget.onSuccess!(response);

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: widget.fields
                  .map(
                    (field) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: FormBuilderTextField(
                        name: field.name,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              // errorText: "Enter policy number or plate number",
                              ),
                          // FormBuilderValidators.email(),
                        ]),
                        autofocus: widget.fields.length == 1,
                        decoration:
                            field.label == null && field.placeholder == null
                                ? const InputDecoration()
                                : InputDecoration(
                                    label: field.label != null
                                        ? Text(field.label!)
                                        : null,
                                    hintText: field.placeholder != null
                                        ? field.placeholder!
                                        : null,
                                  ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        if (widget.builder != null) widget.builder!(onSubmit, loading)
      ],
    );
  }
}

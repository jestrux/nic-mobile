import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:nic/components/FormActions.dart';
import 'package:nic/components/FormInput.dart';
import 'package:nic/components/Loader.dart';
import 'package:nic/utils.dart';

enum DynamicFormFieldType {
  text,
  date,
  number,
  email,
  choice,
  boolean,
  checkbox,
  radio,
  password
}

var keyboardTypeMap = {
  DynamicFormFieldType.number: TextInputType.number,
  DynamicFormFieldType.email: TextInputType.emailAddress,
};

var dynamicFormFieldTypeMap = {
  "text": DynamicFormFieldType.text,
  "password": DynamicFormFieldType.password,

  "integer": DynamicFormFieldType.number,
  "decimal": DynamicFormFieldType.number,
  "currency": DynamicFormFieldType.number,

  "bool": DynamicFormFieldType.boolean,

  "radio": DynamicFormFieldType.radio,
  "checkbox": DynamicFormFieldType.checkbox,

  // "checkbox": DynamicFormFieldType.choice,
  "select": DynamicFormFieldType.choice,
  "bank": DynamicFormFieldType.choice,
  "branch": DynamicFormFieldType.choice,
  "corporate": DynamicFormFieldType.choice,

  "future_date": DynamicFormFieldType.date,
  "past_date": DynamicFormFieldType.date,
  "days_of_year": DynamicFormFieldType.date,
  "date": DynamicFormFieldType.date,
  "datetime": DynamicFormFieldType.date,
  "past_datetime": DynamicFormFieldType.date,
  "future_datetime": DynamicFormFieldType.date,

  // textarea: "choice",
  // file: "choice",
};

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
  final List<Map<String, dynamic>>? choices;
  final dynamic min;
  final dynamic max;

  const DynamicFormField({
    required this.name,
    this.label,
    this.type = DynamicFormFieldType.text,
    this.placeholder,
    this.choices,
    this.min,
    this.max,
  });
}

class DynamicForm extends StatefulWidget {
  final List<DynamicFormField> fields;
  final String? submitLabel;
  final Future Function(Map<String, dynamic>) onSubmit;
  final Function(dynamic response)? onSuccess;
  final Function? onCancel;
  final Widget Function(Function onSubmit, bool loading)? builder;

  const DynamicForm({
    Key? key,
    required this.fields,
    required this.onSubmit,
    this.submitLabel,
    this.onSuccess,
    this.onCancel,
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
      response = await widget.onSubmit(form.instantValue);
      devLog("Policy: $response");
    } catch (e) {
      devLog("Failed to fetch dynamic form: $e");
      showToast("Failed to fetch");
    } finally {
      setState(() {
        loading = false;
      });
    }

    if (widget.onSuccess != null) widget.onSuccess!(response);

    return response;
  }

  Widget _buildFormField(DynamicFormField field) {
    var isBooleanField = field.type == DynamicFormFieldType.boolean;

    return FormBuilderField(
      name: field.name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(
          errorText:
              isBooleanField ? "You have to accept this condition" : null,
        ),
        if (isBooleanField) FormBuilderValidators.equal(true)
      ]),
      builder: (FormFieldState<dynamic> fieldState) {
        var textColor = fieldState.errorText != null && !isBooleanField
            ? colorScheme(context).error
            : colorScheme(context).onSurface;

        IconData? icon;
        Function? onClick;
        String? hint = field.placeholder;
        String? selectedValueLabel;

        if ([DynamicFormFieldType.choice, DynamicFormFieldType.radio]
            .contains(field.type)) {
          var choices = field.choices ?? [];
          hint = "Choose one";
          icon = Icons.expand_more_rounded;

          var selectedChoice = choices
              .cast<Map<String, dynamic>?>()
              .singleWhere((element) => element!["value"] == fieldState.value,
                  orElse: () => null);

          selectedValueLabel = selectedChoice?["label"];

          onClick = () async {
            var selectedChioce = await showChoicePicker(
              title: field.placeholder ?? "Choose one",
              choices: choices,
              value: "No",
            );

            if (selectedChioce != null) {
              fieldState.didChange(selectedChioce);
            }
          };
        }

        if (field.type == DynamicFormFieldType.date) {
          hint = hint ?? "Select date";
          icon = Icons.event;

          // selectedValueLabel = formatDate(fieldState.value, format: 'MM/yyyy');
          selectedValueLabel = formatDate(fieldState.value, format: "dayMY");

          onClick = () async {
            var newDate = await selectDate(
              value: fieldState.value,
              minDate: field.min,
              maxDate: field.max,
            );
            if (newDate != null) {
              fieldState.didChange(newDate);
            }
          };
        }

        Widget? fieldWidget;
        var fieldLabel = Text(
          field.label!,
          style: TextStyle(
            color: textColor,
            fontSize: 13,
            // letterSpacing: 0.5,
          ),
        );

        if (field.type == DynamicFormFieldType.boolean) {
          fieldWidget = InkWell(
            onTap: () {
              fieldState.didChange(!(fieldState.value ?? false));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Checkbox(
                  value: fieldState.value ?? false,
                  onChanged: (newValue) {
                    fieldState.didChange(newValue);
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: fieldLabel,
                  ),
                ),
              ],
            ),
          );
        }

        if (field.type == DynamicFormFieldType.radio) {
          var choices = field.choices ?? [];
          var yesNoChoices = choices.length > 1 &&
              ["Yes", "No"].contains(
                choices[0]["label"],
              );

          if (yesNoChoices) {
            fieldWidget = Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 8.0),
              child: Wrap(
                spacing: 6,
                children: field.choices!
                    .map(
                      (choice) => ChoiceChip(
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 6,
                        ),
                        showCheckmark: false,
                        label: Text("${choice['label']}"),
                        selected: fieldState.value == choice['value'],
                        onSelected: (bool selected) {
                          fieldState
                              .didChange(selected ? choice['value'] : null);
                        },
                      ),
                    )
                    .toList(),
              ),
            );
          }
        }

        fieldWidget ??= FormInput(
          hint: hint ?? "",
          value: selectedValueLabel ?? fieldState.value,
          icon: icon,
          onClick: onClick,
          autoFocus: widget.fields.length == 1,
          obscureText: field.type == DynamicFormFieldType.password,
        );

        return Padding(
          padding: EdgeInsets.only(
            left: isBooleanField ? 6 : 16,
            top: isBooleanField ? 0 : 10,
            bottom: 10,
            right: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (field.label != null && !isBooleanField)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 3),
                  child: fieldLabel,
                ),
              fieldWidget,
              if (fieldState.errorText != null)
                Padding(
                  padding: EdgeInsets.only(
                    left: isBooleanField ? 20 : 8,
                    top: isBooleanField ? 8 : 0,
                  ),
                  child: Text(
                    fieldState.errorText!,
                    style: TextStyle(
                      color: colorScheme(context).error,
                      fontSize: 10,
                      // letterSpacing: 0.5,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: widget.fields.map(_buildFormField).toList(),
            ),
          ),
        ),
        widget.builder != null
            ? widget.builder!(onSubmit, loading)
            : widget.onCancel == null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: FilledButton(
                      style: ButtonStyle(
                        visualDensity: VisualDensity.compact,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 12,
                          ),
                        ),
                      ),
                      onPressed: loading ? null : () => onSubmit(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (loading)
                            const Padding(
                              padding: EdgeInsets.only(right: 6),
                              child: Loader(
                                message: "",
                                loaderSize: 14,
                                loaderStrokeWidth: 2,
                                small: true,
                              ),
                            ),
                          Text(
                            widget.submitLabel ?? "Submit",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : FormActions(
                    loading: loading,
                    onCancel: widget.onCancel,
                    okayText: widget.submitLabel ?? "Submit",
                    onOkay: onSubmit,
                  ),
      ],
    );
  }
}
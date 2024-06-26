import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nic/components/FormActions.dart';
import 'package:nic/components/FormInput.dart';
import 'package:nic/components/VideoThumbnailImage.dart';
import 'package:nic/pages/PlayVideoPage.dart';
import 'package:nic/utils.dart';

enum DynamicFormFieldType {
  text,
  date,
  number,
  money,
  email,
  choice,
  boolean,
  checkbox,
  radio,
  password,
  file,
  video,
  phoneNumber,
  hidden
}

var keyboardTypeMap = {
  DynamicFormFieldType.number: TextInputType.number,
  DynamicFormFieldType.money: TextInputType.number,
  DynamicFormFieldType.phoneNumber: TextInputType.phone,
  DynamicFormFieldType.email: TextInputType.emailAddress,
};

var dynamicFormFieldTypeMap = {
  "phone": DynamicFormFieldType.phoneNumber,
  "phone_number": DynamicFormFieldType.phoneNumber,
  "phoneNumber": DynamicFormFieldType.phoneNumber,

  "hidden": DynamicFormFieldType.hidden,
  "video": DynamicFormFieldType.video,
  "file": DynamicFormFieldType.file,
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
  "employer": DynamicFormFieldType.choice,

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
  final List<String>? children;
  final dynamic min;
  final dynamic max;
  final String? tags;
  final bool required;
  final bool autoFocus;
  final bool disabled;
  final bool canClear;
  final Function? show;

  const DynamicFormField({
    required this.name,
    this.label,
    this.type = DynamicFormFieldType.text,
    this.placeholder,
    this.choices,
    this.min,
    this.max,
    this.tags,
    this.autoFocus = false,
    this.disabled = false,
    this.canClear = false,
    this.required = true,
    this.show,
    this.children,
  });
}

enum DynamicFormPayloadFormat { regular, questionAnswer }

class DynamicForm extends StatefulWidget {
  final List<DynamicFormField> fields;
  final Map<String, dynamic>? initialValues;
  final String? submitLabel;
  final Function(FormBuilderState? formData)? onChange;
  final Future Function(Map<String, dynamic>) onSubmit;
  final void Function(dynamic error, Map<String, dynamic> formData)? onError;
  final Function(dynamic response)? onSuccess;
  final DynamicFormPayloadFormat payloadFormat;
  final ChoicePickerMode choicePickerMode;
  final Function? onCancel;
  final bool onBottomSheet;
  final Map<String, List<String?>>? errors;
  final Widget Function(Function onSubmit, bool loading)? builder;

  const DynamicForm({
    Key? key,
    required this.fields,
    required this.onSubmit,
    this.onError,
    this.submitLabel,
    this.onChange,
    this.onSuccess,
    this.onCancel,
    this.onBottomSheet = false,
    this.builder,
    this.payloadFormat = DynamicFormPayloadFormat.questionAnswer,
    this.choicePickerMode = ChoicePickerMode.regular,
    this.initialValues,
    this.errors,
  }) : super(key: key);

  @override
  State<DynamicForm> createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool submitAttempted = false;
  bool loading = false;
  List<DynamicFormField> fields = [];

  @override
  void initState() {
    super.initState();
    updateFields(_formKey.currentState);
  }

  Future<Map<String, dynamic>> getFormData() async {
    var form = _formKey.currentState!.instantValue;

    Map<String, dynamic> payload = {};

    var data = [];

    for (var fieldName in form.keys) {
      var value = form[fieldName];
      dynamic actualValue;
      var isFile = value is File;

      // if (value == true) value = "on";

      if (isFile) {
        if (value == null) continue;

        var fileName = value.path.split('.').last;
        var fileBytes = await value.readAsBytes();

        actualValue = http.MultipartFile.fromBytes(
          'file',
          fileBytes,
          filename: fileName,
          contentType: MediaType('application', 'octet-stream'),
        );
      } else {
        actualValue = value;
      }

      if (widget.payloadFormat == DynamicFormPayloadFormat.questionAnswer) {
        var entry = {
          "field_name": fieldName,
          "answer": actualValue,
          "type": isFile ? "file" : "regular",
        };

        // isFile ? files.add(entry) : data.add(entry);
        data.add(entry);
      } else {
        payload[fieldName] = value;
      }
    }

    return widget.payloadFormat == DynamicFormPayloadFormat.questionAnswer
        ? {"data": data}
        : payload;
  }

  Future<dynamic> onSubmit() async {
    var form = _formKey.currentState;
    if (form == null) return;

    setState(() {
      submitAttempted = true;
    });

    if (!form.saveAndValidate()) return;

    setState(() {
      loading = true;
    });

    dynamic response;

    try {
      response = await widget.onSubmit(await getFormData());
    } catch (e) {
      devLog("Failed to fetch dynamic form: $e");
      if (widget.onError != null) {
        getFormData().then((value) => widget.onError!(e, value));
        return;
      }

      openErrorAlert(message: e.toString());
    } finally {
      setState(() {
        loading = false;
      });
    }

    if (widget.onSuccess != null) widget.onSuccess!(response);

    return response;
  }

  List<String> collectChildren(DynamicFormField field) {
    if ((field.children ?? []).isEmpty) return [field.name];

    return List.from([]).fold([field.name, ...(field.children!)],
        (agg, childName) {
      List<String> children = [];

      try {
        var child = fields.singleWhere((element) => element.name == childName);
        children = collectChildren(child);
      } catch (e) {}

      return [
        ...agg,
        ...children,
      ];
    });
  }

  void updateFields(FormBuilderState? form) {
    var formValue = form?.instantValue;
    var removedFieldNames = widget.fields
        .where((element) {
          return element.show != null && !element.show!(formValue);
        })
        .fold([], (agg, field) => [...agg, ...collectChildren(field)])
        .toSet()
        .toList();

    var newFields = widget.fields;

    if (removedFieldNames.isNotEmpty) {
      newFields = widget.fields
          .where((field) => !removedFieldNames.contains(field.name))
          .toList();

      if (form != null && formValue != null) {
        for (var name in removedFieldNames) {
          form.removeInternalFieldValue(name);
          // form.fields[name]?.reset();
        }
      }
    }

    setState(() {
      fields = newFields;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: FormBuilder(
            key: _formKey,
            initialValue: widget.initialValues ?? {},
            onChanged: () {
              updateFields(_formKey.currentState);
              if (widget.onChange != null) {
                widget.onChange!(_formKey.currentState);
              }
            },
            child: Column(
              children: fields.map(
                (field) {
                  var form = _formKey.currentState;

                  return FormField(
                    field: field,
                    autoFocus: widget.fields.length == 1 || field.autoFocus,
                    choicePickerMode: widget.choicePickerMode,
                    autoValidate: submitAttempted &&
                        (form?.fields[field.name]?.isDirty ?? false),
                    errors: widget.errors?[field.name]
                        ?.map((element) => element ?? "")
                        .where((element) => element.isNotEmpty)
                        .toList(),
                  );
                },
              ).toList(),
            ),
          ),
        ),
        widget.builder != null
            ? widget.builder!(onSubmit, loading)
            : FormActions(
                loading: loading,
                onCancel: widget.onCancel,
                okayText: widget.submitLabel ?? " Submit ",
                onOkay: onSubmit,
                onBottomSheet: widget.onBottomSheet,
              )
      ],
    );
  }
}

class FormField extends StatelessWidget {
  const FormField({
    super.key,
    required this.field,
    required this.choicePickerMode,
    this.autoFocus,
    this.autoValidate,
    this.errors,
  });

  final ChoicePickerMode choicePickerMode;
  final bool? autoFocus;
  final bool? autoValidate;
  final DynamicFormField field;
  final List<String>? errors;

  @override
  Widget build(BuildContext context) {
    var isBooleanField = field.type == DynamicFormFieldType.boolean;

    return FormBuilderField(
      name: field.name,
      autovalidateMode:
          !(autoValidate ?? false) ? null : AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose([
        if (field.required)
          FormBuilderValidators.required(
            errorText:
                isBooleanField ? "You have to accept this condition" : null,
          ),
        if (field.type == DynamicFormFieldType.phoneNumber)
          FormBuilderValidators.minLength(
            5,
            errorText: isBooleanField ? "Phone number is to short" : null,
          ),
        if (field.tags != null &&
            field.tags!.toString().toLowerCase().contains("nida"))
          FormBuilderValidators.minLength(
            5,
            errorText: isBooleanField ? "Number is to short" : null,
          ),
        if (isBooleanField) FormBuilderValidators.equal(true)
      ]),
      builder: (FormFieldState<dynamic> fieldState) {
        List<String> allErrors = [];

        if (field.type == DynamicFormFieldType.hidden) return Container();

        if (fieldState.errorText != null) allErrors.add(fieldState.errorText!);
        if (errors != null) allErrors.addAll(errors!);

        var textColor = allErrors.isNotEmpty && !isBooleanField
            ? colorScheme(context).error
            : colorScheme(context).onSurface;

        IconData? icon;
        Function? onClick;
        String? hint = field.placeholder;
        String? selectedValueLabel;
        Widget? leading;

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
              value: fieldState.value,
              mode: choicePickerMode,
            );

            if (selectedChioce != null) {
              fieldState.didChange(selectedChioce);
            }
          };
        }

        if (field.type == DynamicFormFieldType.video) {
          hint = hint ?? "Click to record a video";
          icon = Icons.videocam;

          if (fieldState.value != null) {
            selectedValueLabel = "Click to record new video";
          }

          onClick = () async {
            final imagePicker = ImagePicker();
            final pickedFile = await imagePicker.pickVideo(
              source: ImageSource.camera,
              maxDuration: const Duration(seconds: 60),
            );
            if (pickedFile != null) {
              fieldState.didChange(File(pickedFile.path));
            }
          };
        }

        if (field.type == DynamicFormFieldType.file) {
          var allowFilePicker =
              field.tags != null && field.tags!.contains("AllowFilePicker");

          if (allowFilePicker) {
            hint = hint ?? "Click to pick file";
            icon = Icons.add_box;

            if (fieldState.value != null) {
              icon = Icons.edit_square;
              selectedValueLabel =
                  fieldState.value.path.toString().split("/").last;
              leading = const Opacity(
                opacity: 0.7,
                child: Icon(Icons.description),
              );
            }

            onClick = () async {
              var choice = await showChoicePicker(choices: [
                {"icon": Icons.image, "label": "Camera"},
                {"icon": Icons.upload_file, "label": "Pick file"},
              ]);

              if (choice == null) return;

              if (choice == "Camera") {
                final imagePicker = ImagePicker();
                final pickedFile = await imagePicker.pickImage(
                  source: ImageSource.camera,
                );

                if (pickedFile != null) {
                  fieldState.didChange(File(pickedFile.path));
                }
              }

              if (choice == "Pick file") {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();

                if (result != null) {
                  fieldState.didChange(File(result.files.single.path!));
                }
              }
            };
          } else {
            hint = hint ?? "Click to take picture";
            icon = Icons.camera_alt;

            if (fieldState.value != null) {
              selectedValueLabel = "Click to change picture";
            }

            onClick = () async {
              final imagePicker = ImagePicker();
              final pickedFile = await imagePicker.pickImage(
                source: ImageSource.camera,
              );

              if (pickedFile != null) {
                fieldState.didChange(File(pickedFile.path));
              }
            };

            if (fieldState.value != null) {
              var image = FileImage(fieldState.value);

              leading = GestureDetector(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image(image: image, fit: BoxFit.cover),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorScheme(context).surface.withOpacity(0.95),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(2),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                          left: 1,
                          right: 1,
                          bottom: 1,
                        ),
                        height: 14,
                        width: 14,
                        child: const Icon(
                          Icons.open_in_full,
                          size: 10,
                        ),
                      ),
                    )
                  ],
                ),
                onTap: () {
                  openBottomSheet(
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.6,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image(
                          image: image,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
        }

        if (field.type == DynamicFormFieldType.date) {
          hint = hint ?? "Select date";
          icon = Icons.event;

          // selectedValueLabel = formatDate(fieldState.value, format: 'MM/yyyy');
          selectedValueLabel = formatDate(fieldState.value, format: "dayMY");

          onClick = () async {
            var newDate = await selectDate(
              value: fieldState.value == null
                  ? null
                  : DateTime.parse(fieldState.value),
              minDate: field.min,
              maxDate: field.max,
            );
            if (newDate != null) {
              fieldState.didChange(formatDate(newDate));
            }
          };
        }

        Widget? fieldWidget;
        var fieldLabel = Text(
          field.label ?? "",
          style: TextStyle(
            color: textColor,
            fontSize: 13,
            // letterSpacing: 0.5,
          ),
        );

        if (fieldState.value != null) {
          if (field.type == DynamicFormFieldType.video) {
            leading = GestureDetector(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  VideoThumbnailImage(
                    fieldState.value,
                    previewOnly: true,
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black38,
                      child: const Icon(
                        Icons.play_arrow,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PlayVideoPage(
                      video: fieldState.value,
                    ),
                  ),
                );

                // openBottomSheet(
                //   child: Container(
                //     width: double.infinity,
                //     constraints: BoxConstraints(
                //       maxHeight: MediaQuery.of(context).size.height * 0.6,
                //     ),
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(4),
                //       child: VideoThumbnailImage(fieldState.value),
                //     ),
                //   ),
                // );
              },
            );
          }
        }

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
          type: keyboardTypeMap[field.type] ?? TextInputType.text,
          money: field.type == DynamicFormFieldType.money,
          hint: hint ?? "",
          leading: leading,
          value: selectedValueLabel ?? fieldState.value,
          icon: icon,
          onClick: field.disabled ? () => {} : onClick,
          autoFocus: autoFocus,
          obscureText: field.type == DynamicFormFieldType.password,
          onChange: (value) {
            fieldState.didChange(value);
          },
          onClear: !field.canClear
              ? null
              : () {
                  fieldState.didChange(null);
                },
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
              if (allErrors.isNotEmpty)
                ...allErrors
                    .map(
                      (error) => Padding(
                        padding: EdgeInsets.only(
                          left: isBooleanField ? 20 : 8,
                          top: isBooleanField ? 8 : 0,
                        ),
                        child: Text(
                          error,
                          style: TextStyle(
                            color: colorScheme(context).error,
                            fontSize: 10,
                            // letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    )
                    .toList()
            ],
          ),
        );
      },
    );
  }
}

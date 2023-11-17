import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/DynamicForm/proccessFields.dart';
import 'package:nic/components/Loader.dart';
import 'package:nic/pages/FormPage.dart';
import 'package:nic/services/underwritting_service.dart';
import 'package:nic/utils.dart';

class InitialProductForm extends StatefulWidget {
  final String productId;
  final String productName;
  const InitialProductForm({
    Key? key,
    required this.productId,
    required this.productName,
  }) : super(key: key);

  @override
  State<InitialProductForm> createState() => _InitialProductFormState();
}

class _InitialProductFormState extends State<InitialProductForm> {
  bool loading = false;

  Future<dynamic> fetchForm() async {
    List<DynamicFormField>? form;
    try {
      var res = await getInitialProductForm(productId: widget.productId);
      if (res == null) throw ("Failed to fetch form. Please try again later.");

      var fixedInitialFields = [
        if (productIsNonMotor(productId: widget.productId))
          {
            "type": "text",
            "name": "owner_full_name",
            "label": "Full name",
            "placeholder": "E.g. Juma Samson Gratis",
            "required": true,
          },
        {
          "type": "text",
          "name": "owner_phone",
          "label": "Phone Number",
          "required": true,
        }
      ];

      form = processFields(fields: [...List.from(res), ...fixedInitialFields]);
    } catch (e) {
      Navigator.pop(context);
      openErrorAlert(message: e.toString());
    }

    return form;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchForm(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DynamicForm(
            choicePickerMode: ChoicePickerMode.dialog,
            fields: snapshot.data,
            onCancel: () => Navigator.of(context).pop(),
            onSubmit: (payload) async {
              if (payload["data"] != null) null;

              return initiateProposal(
                data: payload["data"],
                productId: widget.productId,
              );
            },
            onSuccess: (data) {
              if (data != null) {
                Navigator.pop(context);
                devLog("Open form page $data");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FormPage(
                      title: widget.productName,
                      proposalDetails: {
                        ...data,
                        "productId": widget.productId,
                      },
                    ),
                  ),
                );
              }
            },
          );
        }

        return const Loader();
      },
    );
  }
}

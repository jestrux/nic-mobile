import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/services/claim_service.dart';
import 'package:nic/components/KeyValueView.dart';
import 'package:nic/utils.dart';

class UploadNotificationImages extends StatefulWidget {
  final int notificationNumber;
  const UploadNotificationImages({Key? key, required this.notificationNumber}) : super(key: key);

  @override
  State<UploadNotificationImages> createState() => _UploadNotificationImagesState();
}

class _UploadNotificationImagesState extends State<UploadNotificationImages> {
  Future<dynamic?> uploadImages(Map<String, dynamic> values) async {
    return await ClaimService().uploadImagesService(
        frontRight: values["frontRight"],
        frontLeft: values['frontLeft'],
        backRight: values['backRight'],
        backLeft: values['backLeft'],
        sideImage:values['sideImage'],
        notificationNumber:widget.notificationNumber,

    );
  }

  showUploadResponse(dynamic response) {
    if (response == null) return;
    print(response);

    Navigator.of(context).pop();

    if (response['success'] == true) {
      openAlert(
          title: "Upload Response",
          child: Text(response['message']),
          type: AlertType.success
      );
  }else{
      openAlert(
          title: "Upload Response",
          child: Text(response['message']),
          type: AlertType.error
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DynamicForm(
          payloadFormat: DynamicFormPayloadFormat.regular,
          fields: const [
            DynamicFormField(
              name: "frontRight",
              label: "Front Right",
              placeholder: "Take a front right image...",
              type: DynamicFormFieldType.file,
              tags: "AllowFilePicker"
            ),
            // DynamicFormField(
            //   name: "frontLeft",
            //   label: "Front Left",
            //   placeholder: "Take a front Left image...",
            //   type: DynamicFormFieldType.file,
            // ),
            // DynamicFormField(
            //   name: "backRight",
            //   label: "Back Right",
            //   placeholder: "Take a back right image...",
            //   type: DynamicFormFieldType.file,
            // ),
            // DynamicFormField(
            //   name: "backLeft",
            //   label: "Back Left",
            //   placeholder: "Take a back left image...",
            //   type: DynamicFormFieldType.file,
            // ),
            // DynamicFormField(
            //   name: "sideImage",
            //   label: "Side image",
            //   placeholder: "Take a side image...",
            //   type: DynamicFormFieldType.file,
            // ),
          ],
          onCancel: () => Navigator.of(context).pop(),
          submitLabel: "Upload",
          onSubmit: uploadImages,
          onSuccess: showUploadResponse,
        ),
      ],
    );
  }
}

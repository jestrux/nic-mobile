import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/components/DynamicForm/proccessFields.dart';
import 'package:nic/services/claim_service.dart';
import 'package:nic/components/KeyValueView.dart';
import 'package:nic/utils.dart';

class UploadNotificationImages extends StatefulWidget {
  final int notificationNumber;
  const UploadNotificationImages({Key? key, required this.notificationNumber})
      : super(key: key);

  @override
  State<UploadNotificationImages> createState() =>
      _UploadNotificationImagesState();
}

class _UploadNotificationImagesState extends State<UploadNotificationImages> {
  Future<dynamic> uploadImages(Map<String, dynamic> images) async {
    return await ClaimService().uploadImagesService(
      images,
      notificationNumber: widget.notificationNumber,
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
          type: AlertType.success);
    } else {
      openAlert(
          title: "Upload Response",
          child: Text(response['message']),
          type: AlertType.error);
    }
  }

  get fields => processFields(
        ["frontRight", "frontLeft", "backRight", "backLeft", "sideImage"].map(
          (fieldName) => {
            "name": fieldName,
            "type": "file",
            "tags": "AllowFilePicker",
            "required": false,
            "hint":
                "Take a ${camelToSentence(fieldName).toLowerCase()} image..."
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DynamicForm(
          payloadFormat: DynamicFormPayloadFormat.regular,
          fields: fields,
          onCancel: () => Navigator.of(context).pop(),
          submitLabel: "Upload",
          onSubmit: uploadImages,
          onSuccess: showUploadResponse,
        ),
      ],
    );
  }
}

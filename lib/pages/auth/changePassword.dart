import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/services/authentication_service.dart';
import 'package:nic/utils.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  Future<dynamic> changePassword(Map<String, dynamic> values) async {
    if(values['newPassword'] != values['repeatPassword']){
      return openAlert(
          title: "Authenticating",
          message: "New Password and Repeat Password, do not match!",
          type: AlertType.error
      );
    }
    return await AuthenticationService().changePassword(
      currentPassword: values['currentPassword'],
      newPassword: values['newPassword'],
      repeatPassword: values['repeatPassword']
    );
  }

  showResponse(dynamic response) {
    if(response != null){
      if(response['status']){
        openAlert(
            title: "Authenticating",
            message: response['message'],
            type: AlertType.success
        );
      }else {
        openAlert(
            title: "Authenticating",
            message: response['message'],
            type: AlertType.error
        );
      }
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
              label: "Current Password",
              name: "currentPassword",
              type: DynamicFormFieldType.password,
            ),
            DynamicFormField(
              label: "New Password",
              name: "newPassword",
              type: DynamicFormFieldType.password,
            ),
            DynamicFormField(
              label: "Repeat Password",
              name: "repeatPassword",
              type: DynamicFormFieldType.password,
            ),
          ],
          onCancel: () => Navigator.of(context).pop(),
          submitLabel: "Update",
          onSubmit: changePassword,
          onSuccess: showResponse,
        ),
      ],
    );
  }
}

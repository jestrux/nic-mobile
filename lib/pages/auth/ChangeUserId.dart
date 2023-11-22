import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/services/authentication_service.dart';
import 'package:nic/utils.dart';

class ChangeUserId extends StatefulWidget {
  const ChangeUserId({Key? key}) : super(key: key);

  @override
  State<ChangeUserId> createState() => _ChangeUserIdState();
}

class _ChangeUserIdState extends State<ChangeUserId> {

  Future<dynamic> changeUserId(Map<String, dynamic> values) async {
    return await AuthenticationService().changeUserId(
        userId: values['userId']
    );
  }

  showResponse(dynamic response) {
    if(response != null){
      if(response['status']){
        openAlert(
            title: "Update ID",
            message: response['message'],
            type: AlertType.success
        );
      }else {
        openAlert(
            title: "Update ID",
            message: response['message'],
            type: AlertType.error
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.symmetric(horizontal:20.0),
            child: Opacity(
              opacity: .5,
              child: Text(
                "Please enter any of this:-",
                style: TextStyle(fontSize: 16),
              ),
            )),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal:30.0),
          child: Opacity(
            opacity: 0.5,
            child: Text(
              '''1. Driving License\n2. Passport number\n3. Voters registration number\n4. Zanzibar Resident Id(ZANID)\n5. Tax Identification Number (TIN)\n6.	National Identification Number (NIDA)''',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ),
        DynamicForm(
          payloadFormat: DynamicFormPayloadFormat.regular,
          fields: const [
            DynamicFormField(
              label: "ID Number",
              name: "userId",
              placeholder: "Enter new ID number..."
            ),
          ],
          onCancel: () => Navigator.of(context).pop(),
          submitLabel: "Update",
          onSubmit: changeUserId,
          onSuccess: showResponse,
        ),
      ],
    );
  }
}

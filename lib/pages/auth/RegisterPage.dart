import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/data/preferences.dart';
import 'package:nic/models/user_model.dart';
import 'package:nic/pages/auth/AuthComponets.dart';
import 'package:nic/pages/control/bContainer.dart';
import 'package:nic/services/authentication_service.dart';
import 'package:nic/services/branch_service.dart';
import 'package:nic/utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  // final String title;
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? initialValue;
  List<Map<String, dynamic>> branchList = [];

  Future<UserModel?> registerCustomer(Map<String, dynamic> values) async {
    var user = await AuthenticationService().registerCustomer(
      fullName: values['fullName'],
      phoneNumber: values['phoneNumber'],
      nida: values['nidaId'],
      password: values['password'],
      salesPerson: false,
      selectedGender: values['gender'],
      dob: values['birthDate'],
      branch: values['branch'],
    );

    await persistAuthUser(user);

    return user;
  }

  showResponse(dynamic response) async {
    if (response != null && response!['status']) {
      UserModel? user = response!['data'];
      persistAuthUser(user);
      String? res = "Welcome ${user!.firstName} ${user!.lastName}";
      showToast(res);
      Navigator.of(context).popUntil(ModalRoute.withName("/"));
    } else if (response != null) {
      String? errors = "Failed to Register";
      if (response!['errors'] != null) {
        for (var i in response!['errors']) {
          String field = i['field'];
          String messages = i['messages'][0];
          errors = "$errors \n $field :  $messages";
        }
        print("errors---: $errors");
      }
      openAlert(
          title: "Authenticating", message: "$errors", type: AlertType.error);
    } else {
      openAlert(
          title: "Authenticating",
          message: "Connection failure, Please try again!",
          type: AlertType.error);
    }
  }

  Future<dynamic> getBranches() async {
    var tempBranchList = await BranchService().getBranches();
    setState(() {
      for (var i in tempBranchList) {
        branchList.add({"label": i['node']['name'], "value": i['node']['id']});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getBranches();
    initialValue = DateTime(
        DateTime.now().year - 10, DateTime.now().month, DateTime.now().day);
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.green[800],
                size: 25.0,
              ),
            ),
            Text('Back',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.green[800]))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: colorScheme(context).surface,
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -height * .15,
            right: -MediaQuery.of(context).size.width * .5,
            child: const BezierContainer(
              customColor: Color(0xff1b5e20),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: ListView(
                primary: false,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                children: <Widget>[
                  SizedBox(height: height * .1),
                  title(context),
                  const SizedBox(height: 30),
                  DynamicForm(
                    payloadFormat: DynamicFormPayloadFormat.regular,
                    fields: [
                      const DynamicFormField(
                          label: "Full Name",
                          name: "fullName",
                          placeholder: 'Enter full name..',
                          canClear: true),
                      const DynamicFormField(
                          label: "ID No.",
                          name: "nidaId",
                          placeholder:
                              "Enter NIDA/ ZANID/ TIN/ Driving License Number..",
                          canClear: true),
                      const DynamicFormField(
                          label: "Phone Number",
                          name: "phoneNumber",
                          placeholder: "Enter eg. +255712 345 678",
                          canClear: true),
                      const DynamicFormField(
                        label: "Select Gender",
                        name: "gender",
                        choices: [
                          {"value": 1, "label": "Male"},
                          {"value": 2, "label": "Female"}
                        ],
                        placeholder: "Select your gender..",
                        type: DynamicFormFieldType.radio,
                      ),
                      DynamicFormField(
                          label: "Birth Date",
                          name: "birthDate",
                          type: DynamicFormFieldType.date,
                          max: initialValue,
                          placeholder: "Pick a birthdate.."),
                      DynamicFormField(
                          label: "Preferred branch",
                          name: "branch",
                          type: DynamicFormFieldType.choice,
                          choices: branchList,
                          canClear: true,
                          placeholder: "Select preferred branch.."),
                      const DynamicFormField(
                          label: "Password",
                          name: "password",
                          type: DynamicFormFieldType.password,
                          placeholder:
                              "Enter password, (Must be 8 characters or more).."),
                      const DynamicFormField(
                        label: "Accept terms and Condition",
                        name: "terms",
                        type: DynamicFormFieldType.boolean,
                      ),
                    ],
                    submitLabel: "Register",
                    onSubmit: registerCustomer,
                    onSuccess: (user) {
                      showToast("Welcome ${user.firstName} ${user.lastName}");
                      Navigator.of(context).popUntil(ModalRoute.withName("/"));
                    },
                    onError: (error, formData) => openErrorAlert(
                      message: error.toString(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  divider(),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 0),
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already have an account ?',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: colorScheme(context).onSurface),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.green[800],
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    );
  }
}

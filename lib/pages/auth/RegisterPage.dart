// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/models/user_model.dart';
import 'package:nic/pages/control/bContainer.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:hive/hive.dart';
// import 'package:imis_client_app/authentication_bloc/authentication_bloc.dart';
// import 'package:imis_client_app/models/branch_model.dart';
// import 'package:imis_client_app/screens/pages/bima/tools/form_initilizer.dart';
// import 'package:imis_client_app/screens/pages/doc_viewer.dart';
// import 'package:imis_client_app/services/branch_service.dart';
import 'package:intl/intl.dart';
import 'package:nic/services/authentication_service.dart';


class RegisterPage extends StatefulWidget {
  // RegisterPage({Key key, this.title}) : super(key: key);

  // final String title;
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Future<UserModel?> tokenAuth(Map<String, dynamic> values) async {
    return await AuthenticationService().loginUser(username:  values["username"], password : values["password"]);
  }
  TextEditingController birthDateField = TextEditingController();
  DateTime? initialValue;



  @override
  void initState() {
    super.initState();
    initialValue = DateTime(DateTime.now().year-10, DateTime.now().month, DateTime.now().day);
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

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 1, color: Colors.grey[300]),
            ),
          ),
          Text(
            'or',
            style: TextStyle(color: Colors.grey[800]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 1, color: Colors.grey[300]),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return Align(
      alignment: Alignment.center,
      child: Image.asset('assets/img/nic_4.png', width: 130.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -height * .15,
            right: -MediaQuery.of(context).size.width * .5,
            child: const BezierContainer(customColor: Color(0xff1b5e20),),
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
                  _title(),
                  const SizedBox(height: 30),
                  DynamicForm(
                    payloadFormat: DynamicFormPayloadFormat.regular,
                    fields:  [
                      const DynamicFormField(
                        label: "Full Name",
                        name: "fullName",
                        placeholder: 'Enter full name..',
                        canClear: true
                      ),
                      const DynamicFormField(
                        label: "ID No.",
                        name: "nidaId",
                        placeholder:"Enter ID Number..",
                        canClear: true
                      ),
                      const DynamicFormField(
                        label: "Phone Number",
                        name: "phoneNumber",
                        placeholder: "Enter eg. +255712 345 678",
                          canClear: true
                      ),
                      const DynamicFormField(
                          label: "Select Gender",
                          name: "selectedGender",
                          choices: [
                            {"value":1,"label":"Male"},
                            {"value":2,"label":"Female"}
                          ],
                          placeholder: "Select your gender",
                          type: DynamicFormFieldType.radio,

                      ),
                      DynamicFormField(
                        label: "Birth Date",
                          name: "birth_date",
                          type: DynamicFormFieldType.date,
                          max: initialValue,
                          canClear: true
                      ),
                      const DynamicFormField(
                        label: "Preferred branch",
                        name: "branch",
                        type: DynamicFormFieldType.choice,
                        choices: [],
                        canClear: true
                      ),
                      const DynamicFormField(
                        label: "Password",
                        name: "password",
                        type: DynamicFormFieldType.password,
                      ),
                      const DynamicFormField(
                        label: "Accept terms and Condition",
                        name: "terms",
                        type: DynamicFormFieldType.boolean,
                      ),
                    ],
                    submitLabel: "Register",
                    onSubmit: tokenAuth,
                    // onSuccess: showResponse,
                  ),
                  const SizedBox(height: 20),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width - 20,
                  //   height: 45,
                  //   child: RaisedButton(
                  //     padding: const EdgeInsets.all(0.0),
                  //     onPressed: () {
                  //       if (loading == false) {
                  //         if (checkedValue && selectedGender != 2) {
                  //           if (formKey.currentState!.validate()) {
                  //             BlocProvider.of<AuthenticationBloc>(
                  //                 context)
                  //                 .add(
                  //               RegisterEvent(
                  //                 fullName: fullName.text,
                  //                 nida: nidaId.text,
                  //                 phoneNumber: phoneNumber.text,
                  //                 password: password.text,
                  //                 salesPerson: salesPerson,
                  //                 selectedGender: selectedGender,
                  //                 dob:dob,
                  //                 branch: branch,
                  //               ),
                  //             );
                  //             setState(() {
                  //               loading = true;
                  //             });
                  //           }
                  //         } else if(selectedGender == 2){
                  //           showSystemSnack(
                  //             context,
                  //             message:
                  //             "Please select gender",
                  //             color: Colors.red,
                  //             globalKey: scaffoldKey,
                  //           );
                  //         }else if(dob == null){
                  //           showSystemSnack(
                  //             context,
                  //             message:
                  //             "Please select Birth Date",
                  //             color: Colors.red,
                  //             globalKey: scaffoldKey,
                  //           );
                  //         }
                  //         else {
                  //           showSystemSnack(
                  //             context,
                  //             message:
                  //             "Terms and Conditions need to be accepted",
                  //             color: Colors.red,
                  //             globalKey: scaffoldKey,
                  //           );
                  //         }
                  //       }
                  //     },
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width - 20,
                  //       alignment: Alignment.center,
                  //       decoration: BoxDecoration(
                  //           borderRadius:
                  //           BorderRadius.all(Radius.circular(5)),
                  //           gradient: LinearGradient(
                  //               begin: Alignment.centerLeft,
                  //               end: Alignment.centerRight,
                  //               colors: [
                  //                 Color(0xff43a047),
                  //                 Color(0xff1b5e20)
                  //               ])),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           loading
                  //               ? SpinKitThreeBounce(
                  //             color: Colors.white,
                  //             size: 30.0,
                  //           )
                  //               : Text(
                  //             'Register',
                  //             style: TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.w400,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     color: Colors.transparent,
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  _divider(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 0),
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already have an account ?',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800]),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            // _authenticationBloc.add(LoginStartedEvent());
                            Navigator.pushNamed(context, '/login');
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
    );;
  }
}

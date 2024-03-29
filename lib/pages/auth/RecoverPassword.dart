import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/models/recover_user_model.dart';
import 'package:nic/pages/auth/AuthComponets.dart';
import 'package:nic/services/authentication_service.dart';
import 'package:nic/utils.dart';
import '../control/bContainer.dart';

class RecoverPassword extends StatefulWidget {
  @override
  _RecoverPasswordState createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  var formKey = GlobalKey<FormState>();
  int hasUserState = 0;
  RecoverUserModel? userObject;
  bool agreed = false;
  String? searchKey ;
  Future<RecoverUserModel?> recoverAccount(Map<String, dynamic> values) async {
    setState(() {
      searchKey = values["username"];
    });
    return await AuthenticationService().recoverAccount(searchKey:  values["username"]);
  }

  Future<bool> userAgreed({String? searchKey}) async{
    return  await AuthenticationService().recoverAccountAgreed(searchKey: searchKey);
  }
  showResponse(dynamic user) {
    if(user != null){
      String? res = "Hey:  ${user.firstName} ${user.phone}  has just recovered acc-in";
      setState(() {
        hasUserState = 1;
        userObject = user;
      });
      showToast(res);
    }else{
      setState(() {
        hasUserState = 2;
      });

    }
  }

  @override
  void initState() {
    // context.read<UserRecoveryNotifier>().resetProvider();
    super.initState();
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

  Widget _recovery(height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: height * .2),
        title(context),
        const SizedBox(height: 30),
        DynamicForm(
          payloadFormat: DynamicFormPayloadFormat.regular,
          fields: const [
            DynamicFormField(
              label: "",
              name: "username",
              placeholder: 'Enter here.....',
            ),
          ],
          submitLabel: "Submit",
          onSubmit: recoverAccount,
          onSuccess: showResponse,
        ),
        const Padding(
            padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 10.0),
            child: Opacity(
              opacity: .5,
              child: Text(
                "Please enter any of this:-",
                style: TextStyle(fontSize: 16),
              ),
            )),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal:20.0),
          child: Opacity(
            opacity: 0.5,
            child: Text(
              '''1. Email\n2. Phone Number\n3. Driving License\n4. Passport number\n5. Voters registration number\n6. Zanzibar Resident Id(ZANID)\n7. Tax Identification Number (TIN)\n8.	National Identification Number (NIDA)''',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _recoveryResponse(height,user) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: height * .2),
          // ignore: unnecessary_null_comparison
          user != null
              ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                restoreIcon(),
                const SizedBox(height: 30),
                agreed == false
                    ? Column(
                  children: [
                    Text(
                      'Are you ${user.firstName} ${user.lastName} ?',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              hasUserState = 0;
                              userObject = null;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 0,
                                      top: 10,
                                      bottom: 10),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red[800],
                                    size: 30.0,
                                  ),
                                ),
                                Text('No',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.w500,
                                        color: Colors
                                            .green[800]))
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              agreed = true;
                            });
                            userAgreed(searchKey: user.id);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 0,
                                      top: 10,
                                      bottom: 10),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.green[800],
                                    size: 30.0,
                                  ),
                                ),
                                Text('Yes',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.w500,
                                        color: Colors
                                            .green[800]))
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
                    : Column(
                  children: [
                    Text(
                      'Hello ${user.firstName} ${user.lastName}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    const Text(
                        '\nWe have sent your credential to email/sms.\nPlease login then change your password in your profile section,\nThanks :)',
                        style: TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.center),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  top: 10,
                                  bottom: 10),
                              child: Icon(
                                Icons.keyboard_arrow_left,
                                color: Colors.green[800],
                                size: 30.0,
                              ),
                            ),
                            Text('Go login',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight:
                                    FontWeight.w500,
                                    color: Colors.green[800]))
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ])
              : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                restoreFailIcon(),
                const SizedBox(height: 30),
                Text("Sorry we couldn't find any associated account with $searchKey \nPlease call free \n080 011 0041 ",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hasUserState = 0;
                      userObject = null;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                              left: 0, top: 10, bottom: 10),
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.green[800],
                            size: 30.0,
                          ),
                        ),
                        Text('Try again',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.green[800]))
                      ],
                    ),
                  ),
                ),
              ])
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: colorScheme(context).surface,
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .5,
                  child: const BezierContainer(
                    customColor: Color(0xff1b5e20),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child:  hasUserState == 0 ? _recovery(height) : _recoveryResponse(height,userObject),
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
            ],
          ),
        ));
  }
}

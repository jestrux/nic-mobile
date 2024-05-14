import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/data/preferences.dart';
import 'package:nic/models/user_model.dart';
import 'package:nic/pages/auth/AuthComponets.dart';
import 'package:nic/pages/auth/RecoverPassword.dart';
import 'package:nic/pages/auth/RegisterPage.dart';
import 'package:nic/pages/control/bContainer.dart';
import 'package:nic/utils.dart';
import 'package:nic/services/authentication_service.dart';

class LoginPage extends StatefulWidget {
  final bool popWindow;
  const LoginPage({Key? key, required this.popWindow}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Future<dynamic> handleLogin(Map<String, dynamic> values) async {
    var user = await AuthenticationService().loginUser(
      username: values["username"],
      password: values["password"],
    );

    await persistAuthUser(user).then((value) => null);

    return user;
  }

  showResponse(dynamic response) {
    if (response != null && response is UserModel) {
      persistAuthUser(response);
      // fetchDataAndPersistPendingProposals(scaffoldKey);
      String? res = "Welcome ${response.firstName} ${response.lastName}";
      showToast(res);
      print("widget.popWindow----: $widget.popWindow");
      if(widget.popWindow==true){
        Navigator.of(context).pop();
      }
      // setState(() {
      //   bool temp = true;
      // });
    } else {
      print(response);
      var message = "Failed to login,Please try again..";
      if (response != null && response.contains("credentials")) {
        message = response;
      }
      openAlert(
          title: "Authenticating", message: message, type: AlertType.error);
    }
  }

  Widget _backButton(context) {
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

  Widget _createAccountLabel() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: colorScheme(context).onSurface),
          ),
          const SizedBox(
            width: 0,
          ),
          TextButton(
            child: const Text(
              'Register',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RegisterPage()));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    title(context),
                    const SizedBox(height: 30),
                    DynamicForm(
                      payloadFormat: DynamicFormPayloadFormat.regular,
                      fields: const [
                        DynamicFormField(
                          label: "Username",
                          name: "username",
                          placeholder: 'Enter email or phone number..',
                        ),
                        DynamicFormField(
                            label: "Password",
                            name: "password",
                            type: DynamicFormFieldType.password,
                            placeholder: "Password.."),
                      ],
                      submitLabel: "Login",
                      onSubmit: handleLogin,
                      onSuccess: showResponse,
                      // onSuccess: (user) => showToast(
                      //   "Welcome ${user.firstName} ${user.lastName}",
                      // ),
                      onError: (error, formData) => openErrorAlert(
                        message: error.toString(),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerRight,
                        child: Text('Forgot Password ?',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: colorScheme(context).onSurface)),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RecoverPassword()));
                      },
                    ),
                    divider(),
                    _createAccountLabel(),
                    // _facebookButton(),
                    // SizedBox(height: height * .055),
                  ],
                ),
              ),
            ),
            // Positioned(top: 40, left: 0, child: _backButton(context)),
          ],
        ),
      ),
    );
    ;
  }
}

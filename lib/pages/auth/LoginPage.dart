import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nic/components/DynamicForm.dart';
import 'package:nic/models/user_model.dart';
import 'package:nic/pages/auth/RecoverPassword.dart';
import 'package:nic/pages/auth/RegisterPage.dart';
import 'package:nic/pages/control/bContainer.dart';
import 'package:nic/utils.dart';
import 'package:nic/services/authentication_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Future<UserModel?> tokenAuth(Map<String, dynamic> values) async {
    return await AuthenticationService().loginUser(username:  values["username"], password : values["password"]);
  }

  showResponse(dynamic user) {
    String? res = "Hey:  ${user.firstName} ${user.middleName}  has just logged-in";
    showToast(res);
    openAlert(
      title: "Authenticating",
      message: res,
      type: AlertType.success
    );
  }



  // Toggles the password show status
  void _toggle() {
    setState(() {

    });
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
              child: Divider(
                thickness: 1,
                color: Colors.grey[300],
              ),
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
                color: Colors.grey[800]),
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
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => RegisterPage()));
            },
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
      key: scaffoldKey,
      backgroundColor: Colors.white,
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
                    _title(),
                    const SizedBox(height: 30),
                    DynamicForm(
                      payloadFormat: DynamicFormPayloadFormat.regular,
                      fields: const [
                        DynamicFormField(
                          label: "Username",
                          name: "username",
                          placeholder: 'Email  and Phone Number',
                        ),
                        DynamicFormField(
                          label: "Password",
                          name: "password",
                          type: DynamicFormFieldType.password,
                        ),
                      ],
                      submitLabel: "Login",
                      onSubmit: tokenAuth,
                      onSuccess: showResponse,
                    ),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerRight,
                        child: Text('Forgot Password ?',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800])),
                      ),
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => RecoverPassword()));
                      },
                    ),
                    _divider(),
                    _createAccountLabel(),
                    // _facebookButton(),
                    // SizedBox(height: height * .055),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton(context)),
          ],
        ),
      ),
    );
    ;
  }
}

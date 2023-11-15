import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nic/pages/auth/RecoverPassword.dart';
// import 'package:imis_client_app/screens/auth/register.dart';
import 'package:nic/pages/control/bContainer.dart';
import '../../components/Loader.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading = false;

  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
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

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
              controller: username,
              obscureText: isPassword,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
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
              // Navigator.push(context, SlideRightRoute(page: RegisterPage()));
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
                child: BezierContainer(customColor: Color(0xff1b5e20),)),
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
                    Form(
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            child: TextFormField(
                              controller: username,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: false,
                              style: TextStyle(color: Colors.grey[800]),
                              decoration: InputDecoration(
                                  hintText: 'Email  and Phone Number',
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[800]),
                                  border: InputBorder.none,
                                  fillColor: const Color(0xfff3f3f4),
                                  filled: true,
                                  icon: Icon(Icons.person_outline,
                                      size: 30.0,
                                      color: Colors.green[800])),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Field is required";
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            child: TextFormField(
                                controller: password,
                                obscureText: _obscureText,
                                style:
                                TextStyle(color: Colors.grey[800]),
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[800]),
                                    icon: Icon(
                                      Icons.lock_outline,
                                      size: 30.0,
                                      color: Colors.green[800],
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey[600],
                                      ),
                                      onPressed: _toggle,
                                    ),
                                    border: InputBorder.none,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Field is required";
                                  }
                                  return null;
                                }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 45,
                      child: FilledButton(
                        style: ButtonStyle(
                          visualDensity: VisualDensity.compact,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (loading == false) {
                            if (formKey.currentState!.validate()) {
                              var temp_username;
                              temp_username = username.text.trim();

                              if (int.tryParse(username.text.trim()) != null){
                                if (temp_username[0] == "0"){
                                  temp_username = temp_username.replaceFirst("0", "255");
                                }
                                print(temp_username);
                              }

                            }
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (loading)
                              const Padding(
                                padding: EdgeInsets.only(right: 6),
                                child: Loader(
                                  message: "",
                                  loaderSize: 14,
                                  loaderStrokeWidth: 2,
                                  small: true,
                                ),
                              ),
                            const Text("Login"),
                          ],
                        ),
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
                                color: Colors.grey[800])),
                      ),
                      onTap: (){
                        Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>RecoverPassword()));
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
    );;
  }
}

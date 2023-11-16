import 'package:flutter/material.dart';
import 'package:nic/notifier/user_recovery_notifier.dart';
import '../../components/Loader.dart';
import '../../models/recover_user_model.dart';
import '../control/bContainer.dart';
import 'package:provider/provider.dart';

class RecoverPassword extends StatefulWidget {
  @override
  _RecoverPasswordState createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  var formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  bool loading = false;

  late String _search;
  @override
  void initState() {
    context.read<UserRecoveryNotifier>().resetProvider();
    super.initState();
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        // BlocProvider.of<AuthenticationBloc>(context).add(AuthStartedEvent());
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

  Widget _title() {
    return Align(
      alignment: Alignment.center,
      child: Image.asset('assets/img/nic_2.png', width: 130.0),
    );
  }

  Widget _restoreIcon() {
    return Align(
        alignment: Alignment.center,
        child: ImageIcon(
          AssetImage('assets/img/renewable.png'),
          color: Colors.green.shade900,
          size: 100,
        ));
  }

  Widget _restoreFailIcon() {
    return Align(
        alignment: Alignment.center,
        child: ImageIcon(
          AssetImage('assets/img/pend.png'),
          color: Colors.red.shade600,
          size: 100,
        ));
  }

  Widget _recovery(height) {
    return Column(
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
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  style: TextStyle(color: Colors.grey[800]),
                  decoration: InputDecoration(
                      hintText: 'Enter here...',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.grey[800]),
                      border: InputBorder.none,
                      fillColor: const Color(0xfff3f3f4),
                      filled: true,
                      icon: Icon(Icons.person,
                          size: 30.0, color: Colors.green[800])),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field is required";
                    }
                    if (value.length < 6) {
                      return 'It should be greater than 6 letters';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    this._search = value!.trim();
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  '''1. Email\n2. Phone Number\n3. Driving License\n4. Passport number\n5. Voters registration number\n6. Zanzibar Resident Id(ZANID)\n7. Tax Identification Number (TIN)\n8.	National Identification Number (NIDA)''',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            height: 45,
            child: Selector<UserRecoveryNotifier, bool>(
                selector: (BuildContext, ur) => ur.initLoading,
                builder: (context, data, child) {
                  if (data) {
                    return const Loader(
                      message: "",
                      loaderSize: 14,
                      loaderStrokeWidth: 2,
                      small: true,
                    );
                  }
                  return FilledButton(
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
                  );
                })),
      ],
    );
  }

  Widget _recoveryResponse(height) {
    RecoverUserModel? user = context.read<UserRecoveryNotifier>().user;
    return Selector<UserRecoveryNotifier, bool>(
        selector: (buildContent, ur) => ur.agreed,
        builder: (context, agreedResponse, child) {
          bool agreed = agreedResponse;
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
                            _restoreIcon(),
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
                                              context
                                                  .read<UserRecoveryNotifier>()
                                                  .resetTryAgain();
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
                                              context
                                                  .read<UserRecoveryNotifier>()
                                                  .userAgreed(
                                                      searchKey: user.id);
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
                            _restoreFailIcon(),
                          const SizedBox(height: 30),
                           Text("Sorry we couldn't find any associated account with ${this?._search} \nPlease call free \n080 011 0041 ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                              textAlign: TextAlign.center,
                            ),
                            InkWell(
                              onTap: () {
                                context
                                    .read<UserRecoveryNotifier>()
                                    .resetTryAgain();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
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
        });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                  child: Selector<UserRecoveryNotifier, int>(
                      selector: (buildContent, ur) => ur.stageIndex,
                      builder: (context, data, child) {
                        // RecoverUserModel?  user = context.read<UserRecoveryNotifier>().user;
                        // print(user);
                        if (data == 0) {
                          _recovery(height);
                        }
                        if (data == 1) {
                          return _recoveryResponse(height);
                        }
                        return _recovery(height);
                      }),
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
            ],
          ),
        ));
  }
}

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:imis_client_app/authentication_bloc/authentication_bloc.dart';
import 'package:imis_client_app/models/branch_model.dart';
import 'package:imis_client_app/screens/control/bContainer.dart';
import 'package:imis_client_app/screens/pages/bima/tools/form_initilizer.dart';
import 'package:imis_client_app/screens/pages/doc_viewer.dart';
import 'package:imis_client_app/services/branch_service.dart';
import 'package:intl/intl.dart';

// String register_mutation = r"""
//     mutation ($full_name: String!, $email: String!, $phone: String!, $nida: String!, $password: String!, $password2: String!, $sales_person: Boolean!) {
//   register(fullName: $full_name, email: $email, phoneNumber: $phone, nida: $nida, password: $password, passwordRepeat: $password2, sales_person: $sales_person) {
//     success
//     accountAvailable
//   }
// }
// """;
class PastDateField extends StatefulWidget {
  // final FieldModel? field;
  String? dob;

  PastDateField({ this.dob, Key? key}) : super(key: key);

  @override
  _PastDateFieldState createState() => _PastDateFieldState();
}

class _PastDateFieldState extends State<PastDateField> {
  DateTime? selectedDate;
  late List<FormFieldValidator> validators;
  DateTime? initialvalue;

  @override
  void initState() {
    super.initState();
    initialvalue = DateTime(DateTime.now().year-10, DateTime.now().month, DateTime.now().day);
    validators = [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            FormBuilderDateTimePicker(
              name: 'birth_date',
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: 'Birth Date',
              ),
              format: DateFormat.yMd(),
              initialValue: initialvalue,
              lastDate: initialvalue,
              enabled: true,
              // validator: (value){
              //   print("value---1${value}");
              // },
              onChanged: (value){
                setState(() {
                  widget.dob = "${value}";
                });
              },
            ),
            Divider()
          ],
        ),
      ],
    );
  }
}
const List<Widget> genders = <Widget>[
  Text('Male'),
  Text('Female'),
];

class RegisterPage extends StatefulWidget {
  // RegisterPage({Key key, this.title}) : super(key: key);

  // final String title;
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController fullName = TextEditingController();
  String? fullNameError;
  TextEditingController phoneNumber = TextEditingController();
  String? phoneNumberError;
  TextEditingController nidaId = TextEditingController();
  String? nidaIdError;
  TextEditingController password = TextEditingController();
  String? passwordError;
  bool loading = false;
  bool checkedValue = false;
  bool salesPerson = false;
  AuthenticationBloc? _authenticationBloc;
  // Initially password is obscure
  bool _obscureText = true;
  final List<bool> _selectedGender = <bool>[false, false];
  String? dob;
  TextEditingController birthDateField = TextEditingController();
  // if selectedGender == 0 then is Male 1 == female & 2 == not selected
  int selectedGender = 2;
  String? branch;
  var branches_box = Hive.box('branches');
  DateTime? initialvalue;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  @override
  void initState() {
    super.initState();
    initialvalue = DateTime(DateTime.now().year-10, DateTime.now().month, DateTime.now().day);
  }

  Widget _backButton() {

    return InkWell(
      onTap: () {
        // BlocProvider.of<AuthenticationBloc>(context).add(AuthStartedEvent());
        Navigator.of(context).pop();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
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
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 1, color: Colors.grey[300]),
            ),
          ),
          Text(
            'or',
            style: TextStyle(color: Colors.grey[800]),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 1, color: Colors.grey[300]),
            ),
          ),
          SizedBox(
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
    return BlocProvider.value(
      value: BlocProvider.of<AuthenticationBloc>(context),
      child: BlocListener(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        listener: (context, dynamic state) {
          if (state is AuthenticatedState) {
            loading = false;
            showSystemSnack(
              context,
              message: "Successfully Registered and Logged In",
              color: Colors.green,
              globalKey: scaffoldKey,
            );
            fullNameError = null;
            nidaIdError = null;
            phoneNumberError = null;
            passwordError = null;

            // FirebaseMessaging.instance.getToken().then((token) {
            //   var box = Hive.box('ftoken');
            //   if (box.get("token") == null) {
            //     AuthenticationService().createToken(token);
            //   }
            // });
            Navigator.of(context).popAndPushNamed("/home");
          }

          if (state is RegistrationFailedState) {
            showSystemSnack(
              context,
              message: "Failed To Register",
              globalKey: scaffoldKey,
            );
          }
        },
        child: BlocBuilder(
          bloc: BlocProvider.of<AuthenticationBloc>(context),
          builder: (context, dynamic state) {
            if (state is RegistrationFailedState) {
              if (state.errors != null) {
                fullNameError = state.errors!['fullName'];
                nidaIdError = state.errors!['nida'];
                phoneNumberError = state.errors!['phone'];
                passwordError = state.errors!['password'];
              }

              loading = false;
            }

            if (state is RegistrationStartedState) {
              loading = true;
              fullNameError = null;
              nidaIdError = null;
              phoneNumberError = null;
              passwordError = null;
            }
            return Scaffold(
              backgroundColor: Colors.white,
              key: scaffoldKey,
              body: Stack(
                children: <Widget>[
                  Positioned(
                    top: -height * .15,
                    right: -MediaQuery.of(context).size.width * .5,
                    child: BezierContainer(customColor: Color(0xff1b5e20),),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: ListView(
                        primary: false,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
                          SizedBox(height: height * .1),
                          _title(),
                          SizedBox(height: 30),
                          Form(
                            key: formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: fullName,
                                        keyboardType: TextInputType.text,
                                        obscureText: false,
                                        style:
                                            TextStyle(color: Colors.grey[800]),
                                        decoration: InputDecoration(
                                            hintText: 'Full Name',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey[800]),
                                            border: InputBorder.none,
                                            fillColor: Color(0xfff3f3f4),
                                            filled: true,
                                            icon: Icon(
                                              Icons.person,
                                              size: 30.0,
                                              color: Colors.green[800],
                                            )),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Field is required";
                                          }
                                          return null;
                                        },
                                      ),
                                      fullNameError != null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50.0),
                                              child: Text(
                                                '${fullNameError}',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            )
                                          : SizedBox()
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: nidaId,
                                        keyboardType: TextInputType.text,
                                        obscureText: false,
                                        style:
                                            TextStyle(color: Colors.grey[800]),
                                        decoration: InputDecoration(
                                          hintText: 'ID No.',
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey[800]),
                                          border: InputBorder.none,
                                          fillColor: Color(0xfff3f3f4),
                                          filled: true,
                                          icon: Icon(
                                            Icons.featured_play_list,
                                            size: 30.0,
                                            color: Colors.green[800],
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Field is required";
                                          }
                                          return null;
                                        },
                                      ),
                                      nidaIdError != null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50.0),
                                              child: Text(
                                                '${nidaIdError}',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50.0),
                                              child: Text(
                                                '''1. Driving License\n2. Passport number\n3. Voters registration number\n4. Zanzibar Resident Id(ZANID)\n5. Tax Identification Number (TIN)\n6.	National Identification Number (NIDA)''',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: phoneNumber,
                                        keyboardType: TextInputType.phone,
                                        obscureText: false,
                                        style:
                                            TextStyle(color: Colors.grey[800]),
                                        decoration: InputDecoration(
                                            hintText: 'Phone Number ',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey[800]),
                                            border: InputBorder.none,
                                            fillColor: Color(0xfff3f3f4),
                                            filled: true,
                                            icon: Icon(
                                              Icons.phone,
                                              size: 30.0,
                                              color: Colors.green[800],
                                            )),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Field is required";
                                          }
                                          return null;
                                        },
                                      ),
                                      phoneNumberError != null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50.0),
                                              child: Text(
                                                '${phoneNumberError}',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50.0),
                                              child: Text(
                                                "eg +255 711 444 555",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                              ),
                                            )
                                    ],
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Select Gender',
                                            style: TextStyle(
                                                color: Colors.grey[800],fontSize: 16),
                                          ),
                                          ToggleButtons(
                                            direction: Axis.horizontal,
                                            onPressed: (int index) {
                                              setState(() {
                                                selectedGender = index;
                                                // The button that is tapped is set to true, and the others to false.
                                                for (int i = 0; i < 2; i++) {
                                                  _selectedGender[i] = i == index;
                                                };
                                              });
                                            },
                                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                                            selectedBorderColor: Colors.green[700],
                                            selectedColor: Colors.white,
                                            fillColor: Colors.green[800],
                                            color: Colors.green[800],
                                            constraints: const BoxConstraints(
                                              minHeight: 40.0,
                                              minWidth: 80.0,
                                            ),
                                            isSelected: _selectedGender,
                                            children: genders,
                                          )
                                        ]
                                    )
                                ),
                                FormBuilderDateTimePicker(
                                  name: 'birth_date',
                                  inputType: InputType.date,
                                  decoration: InputDecoration(
                                    labelText: 'Birth Date',
                                  ),
                                  format: DateFormat.yMd(),
                                  initialValue: initialvalue,
                                  lastDate: initialvalue,
                                  enabled: true,
                                  // validator: (value){
                                  //   print("value---1${value}");
                                  // },
                                  onChanged: (value){
                                    setState(() {
                                      dob = "${value}";
                                    });
                                  },
                                ),
                                SizedBox(height: 10),
                                FormBuilderDropdown(
                                  name: 'branch',
                                  decoration: InputDecoration(
                                    labelText: "Prefered Branch",
                                  ),
                                  allowClear: true,
                                  hint: Text('Select Prefered branch'),
                                  // validator: FormBuilderValidators.compose(validators),
                                  items: branches_box.values.toList()
                                      .map(
                                        (choice) => DropdownMenuItem(
                                      value: choice['id'],
                                      child: Text('${choice['name']}'),
                                    ),
                                  ).toList(),
                                  onChanged: (value){
                                    branch = "${value}";
                                  },
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: password,
                                        keyboardType: TextInputType.text,
                                        obscureText: _obscureText,
                                        style:
                                            TextStyle(color: Colors.grey[800]),
                                        decoration: InputDecoration(
                                          hintText: 'Password ',
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey[800]),
                                          border: InputBorder.none,
                                          fillColor: Color(0xfff3f3f4),
                                          filled: true,
                                          icon: Icon(
                                            Icons.lock,
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
                                        ),
                                        validator: (value) {
                                          print("Length: ${value}");
                                          if (value!.isEmpty) {
                                            return "Field is required";
                                          }else if(value.length < 8){
                                            return "Minimum password length is 8 digits.";
                                          }
                                          return null;
                                        },
                                      ),
                                      passwordError != null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50.0),
                                              child: Text(
                                                '${passwordError}',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            )
                                          : SizedBox()
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 0,
                                      ),
                                      SwitchListTile(
                                        value: checkedValue,
                                        activeColor: Colors.green[800],
                                        inactiveThumbColor: Colors.grey,
                                        inactiveTrackColor: Colors.grey[300],
                                        onChanged: (newValue) {
                                          setState(() {
                                            checkedValue = newValue;
                                          });
                                        },
                                        title: Text(
                                          'Accept terms and Condition',
                                          style: TextStyle(
                                              color: Colors.grey[800]),
                                        ),
                                        contentPadding: EdgeInsets.all(0.0),
                                        // subtitle: Text(''),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(CupertinoPageRoute(
                                              builder: (context) => DocViewer(
                                                title: "Terms and Condition",
                                                path: "https://www.nicinsurance.co.tz/privancy-policy.pdf",
                                              )));
                                        },
                                        child: Container(
                                          // padding: EdgeInsets.all(4.0),
                                          child: Text(
                                            'Terms and conditions',
                                            style: TextStyle(
                                                color: Colors.green[800],
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 20,
                            height: 45,
                            child: RaisedButton(
                              padding: const EdgeInsets.all(0.0),
                              onPressed: () {
                                if (loading == false) {
                                  if (checkedValue && selectedGender != 2) {
                                    if (formKey.currentState!.validate()) {
                                      BlocProvider.of<AuthenticationBloc>(
                                              context)
                                          .add(
                                        RegisterEvent(
                                          fullName: fullName.text,
                                          nida: nidaId.text,
                                          phoneNumber: phoneNumber.text,
                                          password: password.text,
                                          salesPerson: salesPerson,
                                          selectedGender: selectedGender,
                                          dob:dob,
                                          branch: branch,
                                        ),
                                      );
                                      setState(() {
                                        loading = true;
                                      });
                                    }
                                  } else if(selectedGender == 2){
                                    showSystemSnack(
                                      context,
                                      message:
                                      "Please select gender",
                                      color: Colors.red,
                                      globalKey: scaffoldKey,
                                    );
                                  }else if(dob == null){
                                    showSystemSnack(
                                      context,
                                      message:
                                      "Please select Birth Date",
                                      color: Colors.red,
                                      globalKey: scaffoldKey,
                                    );
                                  }
                                  else {
                                    showSystemSnack(
                                      context,
                                      message:
                                          "Terms and Conditions need to be accepted",
                                      color: Colors.red,
                                      globalKey: scaffoldKey,
                                    );
                                  }
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width - 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xff43a047),
                                          Color(0xff1b5e20)
                                        ])),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    loading
                                        ? SpinKitThreeBounce(
                                            color: Colors.white,
                                            size: 30.0,
                                          )
                                        : Text(
                                            'Register',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              color: Colors.transparent,
                            ),
                          ),
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
                                FlatButton(
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
            );
          },
        ),
      ),
    );
  }
}

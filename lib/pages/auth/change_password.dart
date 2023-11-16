// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:imis_client_app/authentication_bloc/authentication_bloc.dart';
// import 'package:imis_client_app/screens/common/user_id_function.dart';
// import 'package:imis_client_app/screens/common/wrapper_page.dart';
// import 'package:imis_client_app/screens/pages/bima/tools/form_initilizer.dart';

// class UserProfileChangePassword extends StatefulWidget {
//   @override
//   _UserProfileChangePasswordState createState() =>
//       _UserProfileChangePasswordState();
// }

// class _UserProfileChangePasswordState extends State<UserProfileChangePassword> {
//   var formKey = GlobalKey<FormState>();
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//   TextEditingController currentPassword = TextEditingController();
//   TextEditingController newPassword = TextEditingController();
//   TextEditingController repeatPassword = TextEditingController();
//   bool loading = false;

//   // Initially password is obscure
//   bool _obscureText = true;

//   // Toggles the password show status
//   void _toggle() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener(
//           bloc: BlocProvider.of<AuthenticationBloc>(context, listen: false),
//           listener: (context, dynamic state) {
//             print(state);

//            if (state is ResetPasswordResponseState) {
//              setState(() {
//                loading = false;
//              });
//              if(state.response!['status'].toString() == 'false') {
//                showSystemSnack(
//                  context,
//                  message: "${state.response!['message']}",
//                  globalKey: scaffoldKey,
//                );
//              }else{
//                showSystemSnack(context,
//                    message: "${state.response!['message']}",
//                    color: Colors.green,
//                    globalKey: scaffoldKey);
//                BlocProvider.of<AuthenticationBloc>(context, listen: false).add(LogoutEvent());
//                Navigator.pushNamedAndRemoveUntil(
//                  context,
//                  "/home",
//                      (context) => false,
//                );
//              }
//           }
//           },
//           child: BlocBuilder(
//               bloc: BlocProvider.of<AuthenticationBloc>(context, listen: false),
//               builder: (context, dynamic auth) {
//                 print("auth:----${auth}");
//                 return ValueListenableBuilder(
//                     valueListenable: Hive.box('theme').listenable(),
//                     builder: (context, dynamic theme, widget) {
//                       return WrapperPage(
//                           title: "Change Password",
//                           globalKey: scaffoldKey,
//                           content: _UserProfileChangePasswordPage(context));
//                     });
//               }),
//         );
//   }

//   Widget _UserProfileChangePasswordPage(context) {
//     // var userBox = ;
//     return ValueListenableBuilder<Box<dynamic>>(
//       valueListenable: Hive.box("user").listenable(),
//       builder: (context, box, state) {
//         String? img = box.get("pic", defaultValue: "http://imis.nictanzania.co.tz/static/assets/images/user.png");
//         // print(state is AuthenticatedState);
//         return NeumorphicBackground(
//           child: Stack(
//             children: [
//               SingleChildScrollView(
//                 child: Neumorphic(
//                   // color: Colors.white,
//                   style: NeumorphicStyle(depth: 0),
//                   child: Padding(
//                     padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CircleAvatar(
//                               backgroundImage:
//                               NetworkImage('${img}'),
//                               radius: 40.0,
//                               backgroundColor: Colors.green[100],
//                             ),
//                             Container(
//                               padding: EdgeInsets.only(left: 10.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       NeumorphicText(
//                                         '${box.get("fullName", defaultValue: "No Name")}',
//                                         style: NeumorphicStyle(
//                                           color: Colors.green[800],
//                                           depth: 0,
//                                         ),
//                                         textStyle: NeumorphicTextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18.0,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       // Icon(Icons.phone,color: Colors.green[800],),
//                                       NeumorphicText(
//                                         '${box.get("phone", defaultValue: "No Mobile Phone")}',
//                                         style: NeumorphicStyle(
//                                           color: Colors.green[800],
//                                           depth: 0,
//                                         ),
//                                         textStyle: NeumorphicTextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16.0,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       NeumorphicText(
//                                         '${box.get("customCustomerNumber", defaultValue: "Update Your ID")}',
//                                         style: NeumorphicStyle(
//                                           color: Colors.grey[700],
//                                           depth: 0,
//                                         ),
//                                         textStyle: NeumorphicTextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16.0,
//                                         ),
//                                       ),
//                                       userIdName(box.get("customerNumberType",defaultValue: 0)),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       NeumorphicText(
//                                         '${box.get("branchName", defaultValue: "No Branch")}',
//                                         style: NeumorphicStyle(
//                                           color: Colors.grey,
//                                           depth: 0,
//                                         ),
//                                         textStyle: NeumorphicTextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 15.0,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10.0,
//                         ),
//                         Divider(
//                           height: 30.0,
//                           color: Colors.grey,
//                         ),
//                         SingleChildScrollView(
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                               Form(
//                                   key: formKey,
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         margin:
//                                             EdgeInsets.symmetric(vertical: 15),
//                                         child: TextFormField(
//                                             controller: currentPassword,
//                                             obscureText: _obscureText,
//                                             style: TextStyle(
//                                                 color: Colors.grey[800]),
//                                             decoration: InputDecoration(
//                                                 hintText: 'Currrent Password',
//                                                 hintStyle: TextStyle(
//                                                     fontWeight: FontWeight.w400,
//                                                     color: Colors.grey[800]),
//                                                 icon: Icon(
//                                                   Icons.lock_outline,
//                                                   size: 30.0,
//                                                   color: Colors.green[800],
//                                                 ),
//                                                 suffixIcon: IconButton(
//                                                   icon: Icon(
//                                                     _obscureText
//                                                         ? Icons.visibility
//                                                         : Icons.visibility_off,
//                                                     color: Colors.grey[600],
//                                                   ),
//                                                   onPressed: _toggle,
//                                                 ),
//                                                 border: InputBorder.none,
//                                                 fillColor: Color(0xfff3f3f4),
//                                                 filled: true),
//                                             validator: (value) {
//                                               if (value!.isEmpty) {
//                                                 return "Field is required";
//                                               }
//                                               if (value.isNotEmpty) {
//                                                 value = value.trim();
//                                                 if (value.length < 8) {
//                                                   currentPassword.clear();
//                                                   return 'Password must have 8 character or more';
//                                                 }
//                                               }
//                                               return null;
//                                             }),
//                                       ),
//                                       Container(
//                                         margin:
//                                             EdgeInsets.symmetric(vertical: 15),
//                                         child: TextFormField(
//                                             controller: newPassword,
//                                             obscureText: _obscureText,
//                                             style: TextStyle(
//                                                 color: Colors.grey[800]),
//                                             decoration: InputDecoration(
//                                                 hintText: 'New Password',
//                                                 hintStyle: TextStyle(
//                                                     fontWeight: FontWeight.w400,
//                                                     color: Colors.grey[800]),
//                                                 icon: Icon(
//                                                   Icons.lock_outline,
//                                                   size: 30.0,
//                                                   color: Colors.green[800],
//                                                 ),
//                                                 suffixIcon: IconButton(
//                                                   icon: Icon(
//                                                     _obscureText
//                                                         ? Icons.visibility
//                                                         : Icons.visibility_off,
//                                                     color: Colors.grey[600],
//                                                   ),
//                                                   onPressed: _toggle,
//                                                 ),
//                                                 border: InputBorder.none,
//                                                 fillColor: Color(0xfff3f3f4),
//                                                 filled: true),
//                                             validator: (value) {
//                                               if (value!.isEmpty) {
//                                                 setState(() {
//                                                   loading = false;
//                                                 });
//                                                 return "Field is required";
//                                               }
//                                               if (value.isNotEmpty) {
//                                                 value = value.trim();
//                                                 if (value.length < 8) {
//                                                   newPassword.clear();
//                                                   setState(() {
//                                                     loading = false;
//                                                   });
//                                                   return 'Password must have 8 character or more';
//                                                 }
//                                               }
//                                               return null;
//                                             }),
//                                       ),
//                                       Container(
//                                         margin:
//                                             EdgeInsets.symmetric(vertical: 15),
//                                         child: TextFormField(
//                                             controller: repeatPassword,
//                                             obscureText: _obscureText,
//                                             style: TextStyle(
//                                                 color: Colors.grey[800]),
//                                             decoration: InputDecoration(
//                                                 hintText: 'Repeat Password',
//                                                 hintStyle: TextStyle(
//                                                     fontWeight: FontWeight.w400,
//                                                     color: Colors.grey[800]),
//                                                 icon: Icon(
//                                                   Icons.lock_outline,
//                                                   size: 30.0,
//                                                   color: Colors.green[800],
//                                                 ),
//                                                 suffixIcon: IconButton(
//                                                   icon: Icon(
//                                                     _obscureText
//                                                         ? Icons.visibility
//                                                         : Icons.visibility_off,
//                                                     color: Colors.grey[600],
//                                                   ),
//                                                   onPressed: _toggle,
//                                                 ),
//                                                 border: InputBorder.none,
//                                                 fillColor: Color(0xfff3f3f4),
//                                                 filled: true),
//                                             validator: (value) {
//                                               if (value!.isEmpty) {
//                                                 return 'Field is required';
//                                               }
//                                               if (value.isNotEmpty) {
//                                                 value = value.trim();
//                                                 if (value.length < 8) {
//                                                   repeatPassword.clear();
//                                                   setState(() {
//                                                     loading = false;
//                                                   });
//                                                   return 'Password must have 8 character or more';
//                                                 }
//                                               }
//                                               if (repeatPassword.text != newPassword.text) {
//                                                 repeatPassword.clear();
//                                                 setState(() {
//                                                   loading = false;
//                                                 });
//                                                 return 'Password not match';
//                                               }

//                                               return null;
//                                             }),
//                                       ),
//                                       SizedBox(height: 20),
//                                       SizedBox(
//                                         width:
//                                             MediaQuery.of(context).size.width -
//                                                 20,
//                                         height: 45,
//                                         child: RaisedButton(
//                                           padding: const EdgeInsets.all(0.0),
//                                           onPressed: () {
//                                             _updateProfile();
//                                           },
//                                           child: Container(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width -
//                                                 20,
//                                             alignment: Alignment.center,
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(5)),
//                                               gradient: LinearGradient(
//                                                 begin: Alignment.centerLeft,
//                                                 end: Alignment.centerRight,
//                                                 colors: [
//                                                   Color(0xff43a047),
//                                                   Color(0xff1b5e20)
//                                                 ],
//                                               ),
//                                             ),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 loading
//                                                     ? SpinKitThreeBounce(
//                                                         color: Colors.white,
//                                                         size: 30.0,
//                                                       )
//                                                     : Text(
//                                                         'Update',
//                                                         style: TextStyle(
//                                                             fontSize: 18,
//                                                             fontWeight:
//                                                                 FontWeight.w400,
//                                                             color:
//                                                                 Colors.white),
//                                                       )
//                                               ],
//                                             ),
//                                           ),
//                                           color: Colors.transparent,
//                                         ),
//                                       ),
//                                     ],
//                                   ))
//                             ]))
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future _updateProfile() async {
//     // print("========update user profile");

//     // print(
//     //     "reset password wirh ${currentPassword} and new password ${newPassword}");
//     if (formKey.currentState!.validate()) {
//       print("am in success");

//         if(loading == false){
//           // print("*********attempting to send*************");
//           BlocProvider.of<AuthenticationBloc>(context).add(
//             ResetPasswordEvent(
//                 currentPassword: currentPassword.text,
//                 newPassword: newPassword.text,
//                 repeatPassword: repeatPassword.text),
//           );
//           setState(() {
//             loading = true;
//           });
//         }
//     }

//     formKey.currentState!.save();
//   }

//   void showErrorSnack({String? message}) {
//     Scaffold.of(context).showSnackBar(SnackBar(
//       backgroundColor: Colors.red,
//       content: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Icon(Icons.error, color: Colors.white),
//           SizedBox(
//             width: 3.0,
//           ),
//           Text(
//             "$message",
//             style: TextStyle(fontSize: 16.0),
//           )
//         ],
//       ),
//       duration: Duration(seconds: 1),
//     ));
//   }
// }

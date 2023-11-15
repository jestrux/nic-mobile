// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:imis_client_app/screens/control/bContainer.dart';

// class VerificationCode extends StatefulWidget {
//   @override
//   _VerificationCodeState createState() => _VerificationCodeState();
// }

// class _VerificationCodeState extends State<VerificationCode> {
//   var formKey = GlobalKey<FormState>();
//   TextEditingController username = TextEditingController();
//   bool loading = false;

//   Widget _backButton() {
//     return InkWell(
//       onTap: () {
//         Navigator.of(context).pop();
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10),
//         child: Row(
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
//               child: Icon(
//                 Icons.keyboard_arrow_left,
//                 color: Colors.green[800],
//                 size: 25.0,
//               ),
//             ),
//             Text('Back',
//                 style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.green[800]))
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _title() {
//     return Align(
//         alignment: Alignment.center,
//         child: ImageIcon(
//           AssetImage("assets/img/recovery.png"),
//           size: 100,
//           color: Colors.green[800],
//         ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Container(
//           height: height,
//           child: Stack(
//             children: <Widget>[
//               Positioned(
//                 top: -height * .15,
//                 right: -MediaQuery.of(context).size.width * .5,
//                 child: BezierContainer(
//                   customColor: Color(0xff1b5e20),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       SizedBox(height: height * .2),
//                       _title(),
//                       SizedBox(height: 30),
//                       Form(
//                         key: formKey,
//                         child: Column(
//                           children: <Widget>[
//                             Container(
//                               margin: EdgeInsets.symmetric(vertical: 15),
//                               child: TextFormField(
//                                 controller: username,
//                                 keyboardType: TextInputType.phone,
//                                 obscureText: false,
//                                 style: TextStyle(color: Colors.grey[800]),
//                                 decoration: InputDecoration(
//                                     hintText: 'Phone number/ NIDA No.',
//                                     hintStyle: TextStyle(
//                                         fontWeight: FontWeight.w400,
//                                         color: Colors.grey[800]),
//                                     border: InputBorder.none,
//                                     fillColor: Color(0xfff3f3f4),
//                                     filled: true,
//                                     icon: Icon(Icons.person,
//                                         size: 30.0, color: Colors.green[800])),
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return "Field is required";
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width - 20,
//                         height: 45,
//                         child: RaisedButton(
//                           padding: const EdgeInsets.all(0.0),
//                           onPressed: () {},
//                           child: Container(
//                             width: MediaQuery.of(context).size.width - 20,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(5)),
//                                 gradient: LinearGradient(
//                                     begin: Alignment.centerLeft,
//                                     end: Alignment.centerRight,
//                                     colors: [
//                                       Color(0xff43a047),
//                                       Color(0xff1b5e20)
//                                     ])),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 loading
//                                     ? SpinKitThreeBounce(
//                                         color: Colors.white,
//                                         size: 30.0,
//                                       )
//                                     : Text(
//                                         'Verify',
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.white),
//                                       )
//                               ],
//                             ),
//                           ),
//                           color: Colors.transparent,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(top: 40, left: 0, child: _backButton()),
//             ],
//           ),
//         ));
//   }
// }

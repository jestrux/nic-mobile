import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nic/pages/HomePage.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:hive/hive.dart';
// import 'package:imis_client_app/authentication_bloc/authentication_bloc.dart';
// import 'package:imis_client_app/screens/auth/register.dart';
// import 'package:imis_client_app/screens/control/route_animations.dart';
// import 'package:imis_client_app/screens/pages/Home.dart';
// import 'package:imis_client_app/services/repository.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // AuthenticationBloc? _authenticationBloc;
  TextEditingController? policy_number;

  Widget _submitButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 20,
      height: 45,
      child: OutlinedButton(
        onPressed: () {
          // Respond to button press
        },
        child: const Text("Login"),
      )
      // NeumorphicButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/login');
      //   },
      //   child: NeumorphicText(
      //     'Login',
      //     textAlign: TextAlign.center,
      //     style: NeumorphicStyle(
      //       color: Color(0xff1b5e20),
      //     ),
      //     textStyle: NeumorphicTextStyle(
      //       fontSize: 18,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      //   style: NeumorphicStyle(color: Colors.white, depth: 1),
      // ),
    );
  }

  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 0),
        child: Column(
          children: <Widget>[
            TextButton(
              child: const Text(
                'Not Now',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {

              },
              child: Icon(Icons.exit_to_app, size: 70, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {

              },
              child: const Text(
                'Go Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ));
  }

  Widget _title() {
    return const Align(
        alignment: Alignment.center,
        child: ImageIcon(
          AssetImage(
            'assets/img/nic_4.png',
          ),
          color: Colors.white,
          size: 170.0,
        )
        // Image.asset('assets/img/nic_2.png', width: 130.0),
        );
  }

  @override
  void initState() {
    super.initState();
    // _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    policy_number = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              borderRadius:  BorderRadius.all(Radius.circular(0)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff66bb6a), Color(0xff1b5e20)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _title(),
              const SizedBox(
                height: 30,
              ),
              //LOGIN
              _submitButton(),
              const SizedBox(
                height: 20,
              ),
              //REGISTER
              SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    // Respond to button press
                  },
                  child: const Text('Register Now'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _label()
            ],
          ),
        ),
      ),
    );
  }

}

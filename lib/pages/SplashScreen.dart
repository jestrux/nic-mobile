import 'package:flutter/material.dart';
import 'package:nic/components/Loader.dart';
import 'package:nic/data/preferences.dart';
import 'package:nic/pages/MainApp.dart';
import 'package:nic/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loading = false;
  bool initialized = false;

  @override
  void initState() {
    init();

    super.initState();
  }

  void init() async {
    await setupPreferences(context);
    await Future.delayed(const Duration(milliseconds: 200));
    updateAndOpen();
  }

  void updateAndOpen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainApp(),
      ),
    );
  }

  Widget _buildLoadScreen() {
    return Material(
      color: Colors.white,
      child: Center(
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(20),
          child: Image.asset(
            'assets/img/ic_launcher.png',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildLoadScreen();
  }
}

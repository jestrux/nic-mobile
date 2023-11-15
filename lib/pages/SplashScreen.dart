import 'package:flutter/material.dart';
import 'package:nic/components/Loader.dart';
import 'package:nic/data/preferences.dart';
import 'package:nic/pages/MainApp.dart';

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
    return const Material(
      child: Center(child: Loader()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildLoadScreen();
  }
}

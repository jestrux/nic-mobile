import 'package:flutter/material.dart';
import 'package:nic/constants.dart';
import 'package:nic/data/preferences.dart';
import 'package:nic/data/providers/AppProvider.dart';
import 'package:nic/models/user_model.dart';
import 'package:nic/pages/BimaPage.dart';
import 'package:nic/pages/HomePage.dart';
import 'package:nic/pages/MorePage.dart';
import 'package:nic/pages/ProfilePage.dart';
import 'package:nic/pages/UtilitiesPage.dart';
import 'package:nic/pages/auth/LoginPage.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Timer? _sessionTimer;

  @override
  void initState() {
    super.initState();
    // Start session timeout timer
    startSessionTimeout();
  }

  void startSessionTimeout() {
    const int sessionTimeoutInMinutes = 15;
    const Duration timeoutDuration = Duration(minutes: sessionTimeoutInMinutes);

    _sessionTimer = Timer(timeoutDuration, () {
      // Session timeout reached, log the user out
      persistAuthUser(null);
    });
  }

  void logoutUser() {
    // Perform user logout actions here, such as clearing session data
    // Redirect to the login page or display a session timeout message
  }
  void resetSessionTimeout() {
    print("in-----resetSessionTimeout");
    _sessionTimer?.cancel();
    startSessionTimeout();
  }

  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    UserModel? userObj = Provider.of<AppProvider>(context).authUser;

    var pages = [
      HomePage(
        goToMainPage: (page) {
          setState(() {
            currentPageIndex = page;
          });
        },
      ),
      const BimaPage(),
      const UtilitiesPage(),
      userObj != null ?  const ProfilePage() : const LoginPage(),
      const MorePage(),
    ];

    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: pages[currentPageIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 0.05,
            ),
          ),
        ),
        child:GestureDetector(
          behavior:  HitTestBehavior.translucent,
          onTap: () {
          resetSessionTimeout();
          // Handle user interactions here
          },
          child: NavigationBar(
          height: 60,
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.shopping_cart),
              icon: Icon(Icons.shopping_cart_checkout_outlined),
              label: 'Bima',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.tips_and_updates),
              icon: Icon(Icons.tips_and_updates_outlined),
              label: 'Utilities',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person_2),
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu),
              label: 'More',
            ),
          ],
        )),
      ),
    );
  }
  @override
  void dispose() {
    _sessionTimer?.cancel(); // Cancel the timer when the app is disposed
    super.dispose();
  }
}

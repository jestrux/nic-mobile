import 'package:flutter/material.dart';
import 'package:nic/constants.dart';
import 'package:nic/pages/BimaPage.dart';
import 'package:nic/pages/HomePage.dart';
import 'package:nic/pages/MorePage.dart';
import 'package:nic/pages/ProfilePage.dart';
import 'package:nic/pages/UtilitiesPage.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
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
      const ProfilePage(),
      const MorePage(),
    ];

    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
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
      ),
    );
  }
}

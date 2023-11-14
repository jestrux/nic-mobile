import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nic/color_schemes.g.dart';
import 'package:nic/constants.dart';
import 'package:nic/pages/BimaPage.dart';
import 'package:nic/pages/FormPage.dart';
import 'package:nic/pages/HomePage.dart';
import 'package:nic/pages/MorePage.dart';
import 'package:nic/pages/ProfilePage.dart';
import 'package:nic/pages/UtilitiesPage.dart';

void main() => runApp(const NICKiganjani());

class NICKiganjani extends StatelessWidget {
  const NICKiganjani({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeWithFont(ThemeData theme) => theme.copyWith(
          textTheme: GoogleFonts.notoSansTextTheme(theme.textTheme).copyWith(
              // bodyMedium: GoogleFonts.oswald(textStyle: textTheme.bodyMedium),
              ),
        );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Constants.globalAppKey,
      home: const MyApp(),
      theme: themeWithFont(
          ThemeData(useMaterial3: true, colorScheme: lightColorScheme)),
      darkTheme: themeWithFont(
          ThemeData(useMaterial3: true, colorScheme: darkColorScheme)),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    var pages = [
      const FormPage(),
      // HomePage(
      //   goToMainPage: (page) {
      //     setState(() {
      //       currentPageIndex = page;
      //     });
      //   },
      // ),
      const BimaPage(),
      const UtilitiesPage(),
      const ProfilePage(),
      const MorePage(),
    ];

    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: 0.3,
                scale: 10,
                image: AssetImage(
                  "assets/img/patterns.png",
                ),
                repeat: ImageRepeat.repeat,
              ),
            ),
          ),
          pages[currentPageIndex]
        ],
      ),
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

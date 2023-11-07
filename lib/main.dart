import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nic/color_schemes.g.dart';
import 'package:nic/pages/HomePage.dart';

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
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomePage(),
      bottomNavigationBar: NavigationBar(
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          NavigationDestination(
            // selectedIcon: Icon(CupertinoIcons.shopping_cart),
            icon: Icon(CupertinoIcons.shopping_cart),
            label: 'Bima',
          ),
          NavigationDestination(
            // selectedIcon: Icon(Icons.account_circle),
            icon: Icon(CupertinoIcons.person),
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nic/color_schemes.g.dart';
import 'package:nic/constants.dart';
import 'package:nic/data/providers/AppProvider.dart';
import 'package:nic/pages/SplashScreen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const NICKiganjani());

class NICKiganjani extends StatefulWidget {
  const NICKiganjani({super.key});

  @override
  State<NICKiganjani> createState() => _NICKiganjaniState();

  static _NICKiganjaniState of(BuildContext context) =>
      context.findAncestorStateOfType<_NICKiganjaniState>()!;
}

class _NICKiganjaniState extends State<NICKiganjani> {
  ThemeMode? _themeMode = ThemeMode.system;

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeWithFont(ThemeData theme) => theme.copyWith(
          textTheme: GoogleFonts.notoSansTextTheme(theme.textTheme).copyWith(
              // bodyMedium: GoogleFonts.oswald(textStyle: textTheme.bodyMedium),
              ),
        );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MaterialApp(
        navigatorKey: Constants.globalAppKey,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        themeMode: _themeMode,
        theme: themeWithFont(
          ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        ),
        darkTheme: themeWithFont(
          ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        ),
      ),
    );
  }
}

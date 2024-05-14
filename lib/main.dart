import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nic/color_schemes.g.dart';
import 'package:nic/constants.dart';
import 'package:nic/data/providers/AppProvider.dart';
import 'package:nic/pages/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print('Handling a background message ${message.notification!.body}');
}
// void main() => runApp(const NICKiganjani());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  String? apnsToken;
  if (Platform.isIOS) {
    apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    if (apnsToken != null) {
      await FirebaseMessaging.instance.subscribeToTopic("imisMobile");
    } else {
      await Future<void>.delayed(
        const Duration(
          seconds: 3,
        ),
      );
      apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        await FirebaseMessaging.instance.subscribeToTopic("imisMobile");
      }
    }
    print("fcmToken---: $apnsToken");
  } else {
    await FirebaseMessaging.instance.subscribeToTopic("imisMobile");
    apnsToken = await FirebaseMessaging.instance.getToken();
    print("fcmToken---: $apnsToken");
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message: ${message.notification!.body}');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  // Set the background messaging handler early on, as a named top-level function
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  // if (!kIsWeb) {
  //   await setupFlutterNotifications();
  // }

  runApp(const NICKiganjani());
}
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
        // textTheme: GoogleFonts.notoSansTextTheme(theme.textTheme).copyWith(
        //     // bodyMedium: GoogleFonts.oswald(textStyle: textTheme.bodyMedium),
        //     ),
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
          ThemeData(
              useMaterial3: true,
              fontFamily: 'NotoSans',
              colorScheme: lightColorScheme),
        ),
        darkTheme: themeWithFont(
          ThemeData(
              useMaterial3: true,
              fontFamily: 'NotoSans',
              colorScheme: darkColorScheme),
        ),
      ),
    );
  }
}

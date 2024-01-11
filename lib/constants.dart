import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Sample control number 994754846842

class Constants {
  static const primaryColor = Color(0xFF2E6B27);
  static const bgLightColor = Color(0XFFebf5f2);
  static const supportPhoneNumber = "080 0110 041";
  static const whatsappChatbotNumber = "15550297411";
  static const supportEmail = "info-nic@nicinsurance.co.tz";
  static const contactsUrl = "https://www.nicinsurance.co.tz/contact-us";
  static const portalUrl = "https://www.nicinsurance.co.tz";

  static final GlobalKey<NavigatorState> globalAppKey =
      GlobalKey<NavigatorState>();

  static void randoFunction() {
    return;
  }

  static whiteAppBarTheme() {
    final _theme = ThemeData(
      // fontFamily: "Ubuntu",
      brightness: Brightness.light,
    );

    return _theme.copyWith(
      appBarTheme: _theme.appBarTheme.copyWith(
          elevation: 0,
          color: Colors.transparent,
          toolbarTextStyle: _theme.textTheme
              .copyWith(
                titleLarge: _theme.textTheme.titleLarge?.copyWith(
                  // color: Colors.black,
                  fontSize: 20,
                ),
              )
              .bodyMedium,
          titleTextStyle: _theme.textTheme
              .copyWith(
                titleLarge: _theme.textTheme.titleLarge?.copyWith(
                  // color: Colors.black,
                  fontSize: 20,
                ),
              )
              .titleLarge,
          iconTheme: _theme.iconTheme.copyWith(color: const Color(0XFF555555))),
      // colorScheme:
      //     ColorScheme.fromSwatch().copyWith(secondary: Pier().primaryColor),
    );
  }

  static darkAppBarTheme() {
    final _theme = ThemeData(
      // fontFamily: "Ubuntu",
      brightness: Brightness.dark,
    );

    return _theme.copyWith(
      appBarTheme: _theme.appBarTheme.copyWith(
        elevation: 0,
        color: Colors.transparent,
        toolbarTextStyle: _theme.textTheme
            .copyWith(
              titleLarge: _theme.textTheme.titleLarge?.copyWith(
                // color: Colors.black,
                fontSize: 20,
              ),
            )
            .bodyMedium,
        titleTextStyle: _theme.textTheme
            .copyWith(
              titleLarge: _theme.textTheme.titleLarge?.copyWith(
                // color: Colors.black,
                fontSize: 20,
              ),
            )
            .titleLarge,
      ),
      // colorScheme:
      //     ColorScheme.fromSwatch().copyWith(secondary: Pier().primaryColor),
    );
  }

  static showToast(String message, {String type = "success"}) {
    Color backgroundColor = Colors.black;
    Color textColor = Colors.white;

    if (type == "error") {
      backgroundColor = Colors.redAccent[100]!;
      textColor = Colors.black;
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }
}

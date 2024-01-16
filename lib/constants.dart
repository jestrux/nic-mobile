import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Sample control number 994754846842

// Sample user local
// effort.mlimbila@nictanzania.co.tz
// Devastator@1

// Sample user uat
// effort.mlimbila@nicinsurance.co.tz
// devastator

class Constants {
  static const primaryColor = Color(0xFF2E6B27);
  static const bgLightColor = Color(0XFFebf5f2);
  static const hqCoordinates = {
    "latitude": -6.815990607109203,
    "longitude": 39.29028651278273,
  };
  static const hqMapLocation =
      "https://www.google.com/maps/place/NIC+Insurance/@-6.8159397,39.2903665,17z/data=!3m1!4b1!4m6!3m5!1s0x185c4b103a6c557d:0x267e2848f72c7e76!8m2!3d-6.8159397!4d39.2903665!16s%2Fg%2F11vlhqm3cd?hl=en-TZ&entry=ttu";
  // static const hqMapLocation =
  //     "https://maps.app.goo.gl/SEdc3zSEQwqaHCWy9?g_st=ic";
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

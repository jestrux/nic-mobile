import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

ColorScheme colorScheme(BuildContext context) {
  return Theme.of(context).colorScheme;
}

class Utils {
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

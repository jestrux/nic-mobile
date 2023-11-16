import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nic/constants.dart';
import 'package:nic/data/providers/AppProvider.dart';
import 'package:nic/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future setupPreferences(BuildContext context) async {
  return await SharedPreferences.getInstance().then((prefs) async {
    var user = prefs.getString("authUser");
    var theme = prefs.getString("appTheme") ?? "System";

    Map<String, dynamic>? authUser = user == null ? null : jsonDecode(user);

    persistAuthUser(authUser);
    persistAppTheme(theme);
  });
}

Future persistAuthUser(Map<String, dynamic>? user) async {
  return await SharedPreferences.getInstance().then((prefs) async {
    if (user == null) {
      prefs.remove("authUser");
    } else {
      prefs.setString("authUser", jsonEncode(user));
    }

    Provider.of<AppProvider>(
      Constants.globalAppKey.currentContext!,
      listen: false,
    ).setAuthUser(user);
  });
}

Future persistAppTheme(String theme) async {
  return await SharedPreferences.getInstance().then((prefs) async {
    prefs.setString("appTheme", theme);

    var context = Constants.globalAppKey.currentContext!;

    Provider.of<AppProvider>(context, listen: false).setTheme(theme);

    NICKiganjani.of(context).changeTheme(
      {
            "Dark": ThemeMode.dark,
            "Light": ThemeMode.light,
            "System": ThemeMode.system,
          }[theme] ??
          ThemeMode.system,
    );
  });
}
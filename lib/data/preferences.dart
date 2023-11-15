import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nic/constants.dart';
import 'package:nic/data/providers/AppProvider.dart';
import 'package:nic/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future setupPreferences(BuildContext context) async {
  return await SharedPreferences.getInstance().then((prefs) async {
    var user = prefs.getString("user");
    var theme = prefs.getString("theme") ?? "system";

    Map<String, dynamic>? authUser = user == null ? null : jsonDecode(user);

    Provider.of<AppProvider>(context, listen: false).setAuthUser(authUser);
    setTheme(context: context, theme: theme);
  });
}

Future setTheme({
  required BuildContext context,
  required String theme,
}) async {
  return await SharedPreferences.getInstance().then((prefs) async {
    prefs.setString("theme", theme);

    var context = Constants.globalAppKey.currentContext!;
    Provider.of<AppProvider>(context, listen: false).setTheme(theme);

    NICKiganjani.of(context).changeTheme(
      {
            "dark": ThemeMode.dark,
            "light": ThemeMode.light,
            "system": ThemeMode.system,
          }[theme] ??
          ThemeMode.system,
    );
  });
}

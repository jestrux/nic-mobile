import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nic/constants.dart';
import 'package:nic/data/providers/AppProvider.dart';
import 'package:nic/main.dart';
import 'package:nic/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future setupPreferences(BuildContext context) async {
  return await SharedPreferences.getInstance().then((prefs) async {
    var user = prefs.getString("authUser");
    var theme = prefs.getString("appTheme") ?? "System";

    Map<String, dynamic>? authUser = user == null ? null : jsonDecode(user);

    var provider = Provider.of<AppProvider>(context, listen: false);
    provider
        .setAuthUser(authUser == null ? null : UserModel.fromJson(authUser));
    provider.setTheme(theme);
  });
}

Future persistAuthUser(UserModel? user) async {
  return await SharedPreferences.getInstance().then((prefs) async {
    if (user == null) {
      prefs.remove("authUser");
    } else {
      prefs.setString("authUser", jsonEncode(user.toMap()));
    }

    Provider.of<AppProvider>(
      Constants.globalAppKey.currentContext!,
      listen: false,
    ).setAuthUser(user);
  });
}

Future<String?> getUserToken() async {
  return await SharedPreferences.getInstance().then((prefs) async {
    var user = prefs.getString("authUser");
    Map<String, dynamic>? authUser = user == null ? null : jsonDecode(user);

    if (authUser != null) {
      if (authUser['token'] != null) {
        return authUser['token'];
      } else {
        persistAuthUser(user = null);
        return null;
      }
    }
    return null;
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

// Persist pending proposals to SharedPreferences
Future<void> persistDataPendingProposals(
    List<Map<String, dynamic>> dataList) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("proposal_data");
  print(dataList);
  final String jsonData = jsonEncode(dataList);
  prefs.setString('proposal_data', jsonData);

  // notify listerners
  prefs.setBool('data_available', true);
  // proposalProvider.setProposalDataAvailable(true);
}

// Retrieve pending proposals from SharedPreferences
Future<List<Map<String, dynamic>>> retrievePendingProposals() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String storedData = prefs.getString('proposal_data') ?? '[]';

  try {
    final List<dynamic> decodedData = jsonDecode(storedData);

    if (decodedData is List && decodedData.isNotEmpty) {
      final List<Map<String, dynamic>> dataList = decodedData
          .map<Map<String, dynamic>>(
              (dynamic item) => Map<String, dynamic>.from(item))
          .toList();
      return dataList;
    } else {
      // Handle the case where the stored data is not a valid List<Map<String, dynamic>>
      print('Invalid format of stored data: $storedData');
      return [];
    }
  } catch (e) {
    // Handle JSON parsing error
    print('Error decoding stored data: $e');
    return [];
  }
}

Future<void> clearSpecificData(keyToRemove) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(keyToRemove);
}

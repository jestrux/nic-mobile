import 'dart:convert';
import 'package:hive/hive.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class Repository {
  Future<String?> getToken() async {
    return "";
    // var userInfo = Hive.box("userInfo");
    // return userInfo.get("token");
  }
}

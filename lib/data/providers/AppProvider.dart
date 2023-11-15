import 'package:flutter/foundation.dart';

class AppProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Map<String, dynamic>? _user = {};

  Map<String, dynamic>? get authUser => _user;

  void setAuthUser(Map<String, dynamic>? user) {
    _user = user;
    notifyListeners();
  }

  String _theme = "system";

  String get theme => _theme;

  void setTheme(String theme) {
    _theme = theme;
    notifyListeners();
  }
}

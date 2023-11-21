import 'package:flutter/foundation.dart';
import 'package:nic/models/user_model.dart';

class AppProvider with ChangeNotifier, DiagnosticableTreeMixin {
  UserModel? _user;

  UserModel? get authUser => _user;

  void setAuthUser(UserModel? user) {
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

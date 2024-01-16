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

  // PROPOSALS
  List<Map<String, dynamic>>? _proposals;

  List<Map<String, dynamic>>? get proposals => _proposals;

  void setProposals(List<Map<String, dynamic>> proposals) {
    _proposals = (_proposals ?? [])..addAll(proposals);
    notifyListeners();
  }

  void clearProposals() {
    _proposals?.clear();
    notifyListeners();
  }

//   CLAIMS
  List<Map<String, dynamic>>? _userClaims;

  List<Map<String, dynamic>>? get userClaims => _userClaims;

  void setClaims(List<Map<String, dynamic>> userClaims) {
    _userClaims = (_userClaims ?? [])..addAll(userClaims);
    notifyListeners();
  }

  void clearClaims() {
    _userClaims?.clear();
    notifyListeners();
  }

}

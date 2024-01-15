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

  // bool _proposalDataAvailable = false;
  //
  // bool get proposalDataAvailable => _proposalDataAvailable;
  //
  // void checkProposalDataStored() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _proposalDataAvailable = prefs.getBool('data_available') ?? false;
  //   notifyListeners();
  // }
  //
  // void setProposalDataAvailable(bool value) {
  //   _proposalDataAvailable = value;
  //   notifyListeners();
  // }

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
}

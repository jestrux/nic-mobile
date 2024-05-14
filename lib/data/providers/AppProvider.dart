import 'package:flutter/foundation.dart';
import 'package:nic/models/user_model.dart';
import 'package:nic/services/underwritting_service.dart';

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

  // PRODUCTS
  List<Map<String, dynamic>>? _products;

  List<Map<String, dynamic>>? get products => _products;

  void setProducts(List<Map<String, dynamic>> products) {
    _products = (_products ?? [])..addAll(products);
    notifyListeners();
  }

  // BRANCHES
  List<Map<String, dynamic>>? _branches;

  List<Map<String, dynamic>>? get branches => _branches;

  void setBranches(List<Map<String, dynamic>> branches) {
    _branches = (_branches ?? [])..addAll(branches);
    notifyListeners();
  }
//   USER POLICIES
  List<Map<String, dynamic>>? _userPolicies;

  List<Map<String, dynamic>>? get userPolicies => _userPolicies;

  void setPolicies(List<Map<String, dynamic>> userPolicies) {
    _userPolicies = (_userPolicies ?? [])..addAll(userPolicies);
    notifyListeners();
  }

  void clearPolicies() {
    _userPolicies?.clear();
    notifyListeners();
  }

//  USER LIFE CONTRIBUTIONS
  List<Map<String, dynamic>>? _userContributions;

  List<Map<String, dynamic>>? get userContributions => _userContributions;

  void setUserContributions(List<Map<String, dynamic>> userContributions) {
    _userContributions = (_userContributions ?? [])..addAll(userContributions);
    notifyListeners();
  }

  void clearUserContributions() {
    _userContributions?.clear();
    notifyListeners();
  }

  // Commission Statement
  List<Map<String, dynamic>>? _commissionStatement;

  List<Map<String, dynamic>>? get commissionStatement => _commissionStatement;

  void setCommissionStatement(List<Map<String, dynamic>> commissionStatements) {
    _commissionStatement = (_commissionStatement ?? [])..addAll(commissionStatements);
    notifyListeners();
  }

 // Popular PRODUCTS
  List<Map<String, dynamic>>? _popularProducts;

  List<Map<String, dynamic>>? get popularProducts => _popularProducts;

  void setPopularProducts(List<Map<String, dynamic>> popularProducts) {
    _popularProducts = (_popularProducts ?? [])..addAll(popularProducts);
    notifyListeners();
  }

}

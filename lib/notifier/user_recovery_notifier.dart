import 'package:flutter/foundation.dart';
import 'package:nic/models/recover_user_model.dart';
import 'package:nic/services/authentication_service.dart';

class UserRecoveryNotifier extends ChangeNotifier {
  int stageIndex = 0;
  bool initLoading = false;
  RecoverUserModel? user;
  late bool agreed;
  AuthenticationService userService = AuthenticationService();

  void resetProvider() {
    this.stageIndex = 0;
    this.initLoading = false;
    this.agreed = false;
    this.user = null;
  }

  void setStageIndex(int value) {
    this.stageIndex = value;
    notifyListeners();
  }
  void setAgreed(bool value){
    this.agreed = value;
    notifyListeners();
  }
  void setInitLoading(bool value) {
    this.initLoading = value;
    notifyListeners();
  }

  void resetTryAgain() {
    this.stageIndex = 0;
    this.initLoading = false;
    this.user = null;
    notifyListeners();
  }
  void checkUserRecovery({String? searchKey}) async {
    setInitLoading(true);
    user = await userService.recoverAccount(searchKey: searchKey);
    setInitLoading(false);
    setStageIndex(1);
  }
  void userAgreed({String? searchKey}) async{
    setInitLoading(true);
    setAgreed(true);
    agreed = await userService.recoverAccountAgreed(searchKey: searchKey);
    setInitLoading(false);
  }
}
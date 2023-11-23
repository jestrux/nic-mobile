import 'package:nic/data/preferences.dart';
import 'package:nic/models/user_model.dart';

// enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class Repository {
  Future<String?> getToken() async {
    var token = await getUserToken();
    // print(user!.token);
    return token ?? "";
  }
}

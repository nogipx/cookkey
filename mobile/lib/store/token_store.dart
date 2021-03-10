import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefStore {
  final SharedPreferences sharedPreferences;

  const SharedPrefStore(this.sharedPreferences);

  String get token {
    return sharedPreferences.getString("auth_token");
  }

  Future<void> saveToken(String token) {
    return sharedPreferences.setString("auth_token", token);
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class AppSharedStore {
  final SharedPreferences sharedPreferences;

  const AppSharedStore(this.sharedPreferences);

  String get token => sharedPreferences.getString("auth_token");

  Future<bool> saveToken(String token) async =>
      await sharedPreferences.setString("auth_token", token);

  Future<bool> removeToken() async => sharedPreferences.remove("auth_token");
}

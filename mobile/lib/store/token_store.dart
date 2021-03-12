import 'dart:convert';

import 'package:sdk/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedStore {
  final SharedPreferences sharedPreferences;

  const AppSharedStore(this.sharedPreferences);

  String get token => sharedPreferences.getString("auth_token");

  Future<bool> saveToken(String token) async =>
      await sharedPreferences.setString("auth_token", token);

  Future<bool> removeToken() async => sharedPreferences.remove("auth_token");

  User get user {
    final userJson = sharedPreferences.getString("user");
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<bool> saveUser(User user) async =>
      await sharedPreferences.setString("user", jsonEncode(user.toJson()));
  Future<bool> clearUser() async => await sharedPreferences.remove("user");
}

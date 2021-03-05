import 'dart:convert';

import 'package:angel_auth/angel_auth.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:backend/config.dart';
import 'package:backend/module/user/export.dart';
import 'package:domain/domain.dart';
import 'package:meta/meta.dart';

Future<AngelAuth> configureAuth({
  @required Angel app,
  @required UserService userService,
}) async {
  final auth = AngelAuth<User>(
    jwtKey: jwtKey,
    allowCookie: false,
  );

  auth.serializer = (user) async => user.id;
  auth.deserializer = (id) async => await userService.getUser(id as String);

  auth.strategies['local'] = LocalAuthStrategy((username, password) async {
    return await userService.findUserByCredentials(
      username: username,
      hashPassword: password,
    );
  });

  app.post('/auth/local', (req, res) {
    res.serializer = (dynamic value) {
      final data = value as Map<String, dynamic>;
      return jsonEncode(Auth(
        user: data["data"] as User,
        token: data["token"] as String,
      ).toJson());
    };
    return auth.authenticate("local");
  });

  await auth.configureServer(app);
  return auth;
}

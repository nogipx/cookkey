import 'package:angel_auth/angel_auth.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:backend/config.dart';
import 'package:backend/module/user/export.dart';
import 'package:sdk/domain.dart';
import 'package:meta/meta.dart';

Future<AngelAuth> configureAuth({
  @required Angel app,
  @required UserRepo userRepo,
}) async {
  final auth = AngelAuth<User>(
    jwtKey: jwtKey,
    allowCookie: false,
  );

  auth.serializer = (user) async => user.id;
  auth.deserializer = (id) async => await userRepo.getUserById(id as String);

  auth.strategies['local'] = LocalAuthStrategy((username, password) async {
    return await userRepo.findUserByCredentials(
      username: username,
      password: password,
    );
  });

  await auth.configureServer(app);
  return auth;
}

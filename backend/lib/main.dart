library backend;

import 'dart:io';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_container/mirrors.dart';
import 'package:angel_hot/angel_hot.dart';
import 'package:backend/configurations/auth.dart';
import 'package:backend/configurations/database.dart';
import 'package:backend/configurations/error.dart';
import 'package:backend/module/user/controller/user_controller.dart';

import 'module/user/export.dart';

Future<void> main() async {
  final hot = HotReloader(createServer, <dynamic>[
    Directory('lib/'),
    Uri.parse('package:angel_hot/angel_hot.dart'),
  ]);
  await hot.startServer('0.0.0.0', 3000);
  // print('Listening at ${hot}');
}

Future<Angel> createServer() async {
  final app = Angel(reflector: MirrorsReflector());
  final db = await configureDatabase(app: app);

  final UserRepo userRepo = ImplMongoUserRepo(mongo: db);

  final auth = await configureAuth(app: app, userRepo: userRepo);

  final controllers = [
    AuthController(auth: auth),
    UserController(userRepo: userRepo),
  ];

  controllers.forEach((e) async => e.configureServer(app));

  await configureError(app);
  return app;
}

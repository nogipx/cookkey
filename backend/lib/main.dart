library backend;

import 'dart:io';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_hot/angel_hot.dart';
import 'package:backend/configurations/auth.dart';
import 'package:backend/configurations/error.dart';

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
  final app = Angel();

  final UserRepo userService = ImplTestUserRepo();

  final auth = await configureAuth(
    app: app,
    userService: userService,
  );
  app.container.registerNamedSingleton("auth", auth);

  await configureUserModule(
    app: app,
    userService: userService,
  );

  await configureError(app);
  return app;
}

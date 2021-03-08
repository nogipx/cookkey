library backend;

import 'dart:io';

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_container/mirrors.dart';
import 'package:angel_hot/angel_hot.dart';
import 'package:backend/configurations/auth.dart';
import 'package:backend/configurations/database.dart';
import 'package:backend/configurations/error.dart';
import 'package:backend/configurations/log.dart';
import 'package:backend/module/user/controller/user_controller.dart';
import 'package:logging/logging.dart';

import 'module/recipe/export.dart';
import 'module/user/export.dart';

Future<void> main() async {
  final logger = Logger("APP");
  final hot = HotReloader(
    () => createServer(logger: logger),
    <dynamic>[
      Directory('lib/'),
      Uri.parse('package:angel_hot/angel_hot.dart'),
    ],
  );

  hot.onChange.listen((event) {
    logger.clearListeners();
  });

  await hot.startServer('0.0.0.0', 3000);
  // print('Listening at ${hot}');
}

Future<Angel> createServer({Logger logger}) async {
  final app = Angel(reflector: MirrorsReflector());
  if (logger != null) {
    await configureLogging(app: app, logger: logger);
  }

  final db = await configureDatabase(app: app);

  final UserRepo userRepo = ImplMongoUserRepo(mongo: db);
  final RecipeRepo recipeRepo = ImplMongoRecipeRepo(mongo: db);

  final auth = await configureAuth(app: app, userRepo: userRepo);

  final controllers = [
    AuthController(auth: auth),
    UserController(userRepo: userRepo),
    RecipeController(
      userRepo: userRepo,
      recipeRepo: recipeRepo,
    ),
  ];

  controllers.forEach((e) async => e.configureServer(app));

  await configureError(app);
  return app;
}

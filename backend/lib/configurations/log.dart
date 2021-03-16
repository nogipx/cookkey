import 'dart:developer' as dev;

import 'package:angel_framework/angel_framework.dart';
import 'package:convenient_bloc/convenient_bloc.dart';
import 'package:logging/logging.dart';

Future<void> configureLogging({Angel app, Logger logger}) async {
  app.logger = Logger("APP");
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((record) {
    dev.log(
      record.message.color([ansiCyan]),
      name: "${record.loggerName} ${record.level}".color([ansiPurple]),
    );
  });
}

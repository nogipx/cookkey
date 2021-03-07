import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:angel_framework/angel_framework.dart';
import 'package:backend/util/log.dart';
import 'package:convenient_bloc/convenient_bloc.dart';
import 'package:logging/logging.dart';
import 'package:sdk/domain.dart';

Future<void> configureError(Angel app) async {
  app.errorHandler = (err, req, res) async {
    ApiError apiError;
    if (err.error is ApiError) {
      final customErr = err.error as ApiError;
      res.statusCode = customErr.statusCode;
      apiError = customErr;
    } else {
      apiError = ApiError(
        statusCode: err.statusCode,
        message: err.message,
      );
    }

    await logError(
      apiError.message.color([ansiRedBg, ansiWhite]),
      name: "${req.method} /${req.uri.pathSegments.join("/")}"
          .color([ansiGreenBg, ansiDarkGray]),
    );
    res.headers.addAll({
      HttpHeaders.contentTypeHeader: "application/json",
    });
    res.write(jsonEncode(apiError.toJson()));
  };

  app.logger = Logger("APP");
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((record) {
    dev.log(
      record.message.color([ansiCyan]),
      name: "${record.loggerName} ${record.level}".color([ansiPurple]),
    );
  });

  app.fallback((req, res) {
    throw AngelHttpException.notFound(
      message: "Unknown method: ${req.method} /${req.uri.pathSegments.join("/")}",
    );
  });
}

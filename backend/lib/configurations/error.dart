import 'dart:convert';
import 'dart:io';

import 'package:angel_framework/angel_framework.dart';
import 'package:backend/util/log.dart';
import 'package:convenient_bloc/convenient_bloc.dart';

Future<void> configureError(Angel app) async {
  app.errorHandler = (err, req, res) async {
    final stacktrace = err?.stackTrace != null ? "\n${err.stackTrace}" : '';
    await req.parseBody();
    await logError(
      "${err.message} ${req.bodyAsMap} $stacktrace".color([ansiRed]),
      name: "${req.method} /${req.uri.pathSegments.join("/")}".color([ansiGreen]),
    );
    res.headers.addAll({
      HttpHeaders.contentTypeHeader: "application/json",
    });
    res.write(jsonEncode(err.toJson()));
  };

  app.fallback((req, res) {
    throw AngelHttpException.notFound(
      message: "Unknown method: ${req.method} /${req.uri.pathSegments.join("/")}",
    );
  });
}

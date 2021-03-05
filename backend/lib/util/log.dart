import 'dart:developer' as dev;

Future<void> logError(
  dynamic message, {
  String name = "Error",
}) async {
  dev.log(message.toString(), name: name);
}

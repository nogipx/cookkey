library backend;

import 'package:angel_framework/angel_framework.dart';
import 'package:angel_framework/http.dart';

Future<void> main() async {
  final app = Angel(), http = AngelHttp(app);
  app
    ..get('/', (req, res) => res.writeln('Hello, Angel!'))
    ..fallback((req, res) => throw AngelHttpException.notFound());
  await http.startServer('127.0.0.1', 3000);
  print('Listening at ${http.uri}');
}

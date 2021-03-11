import 'package:cookkey/route/export.dart';

extension CookkeyRoute on AppRoute {
  static final mainPage = AppRoute("/");
  static final search = AppRoute("/search/{query}");
  static final unknown = AppRoute("/404");

  static final routes = [mainPage, search, unknown];
}

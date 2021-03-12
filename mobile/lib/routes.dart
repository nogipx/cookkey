import 'package:navigation_manager/navigation_manager.dart';

extension CookkeyRoute on AppRoute {
  static final dashboard = AppRoute("/");
  static final search = AppRoute("/search{/query}");
  static final profile = AppRoute("/profile");
  static final unknown = AppRoute("/404");
  static final login = AppRoute("/login");

  static final routes = [dashboard, search, unknown];
}

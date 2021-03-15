import 'package:navigation_manager/navigation_manager.dart';

extension CookkeyRoute on AppRoute {
  static final dashboard = AppRoute.subroot("/{/a,empty}");
  static final search = AppRoute.subroot("/search{/query}");
  static final profile = AppRoute.subroot("/profile");
  static final unknown = AppRoute("/404");
  static final login = AppRoute("/login");

  static final routes = [dashboard, search, unknown];
  static final withBottomNavigation = [search, dashboard, profile, unknown];
  static final authRequired = [profile];
}

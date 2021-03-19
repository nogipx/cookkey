import 'package:cookkey/ui/export.dart';
import 'package:navigation_manager/navigation_manager.dart';

extension CookkeyRoute on AppRoute {
  static final dashboard =
      AppRoute<SearchPageArgs>.subroot("/dashboard", (t) => DashboardPage());
  static final search = AppRoute.subroot("/search{/query}", (_) => SearchPage());
  static final profile = AppRoute.subroot("/profile", (_) => null);
  static final unknown = AppRoute("/404", (_) => null);
  static final login = AppRoute("/login", (_) => null);

  static final routes = [dashboard, search, unknown, profile, login];
  static final withBottomNavigation = [search, dashboard, profile, unknown];
  static final authRequired = [profile];
}

class SearchPageArgs extends AppRouteArgs {
  final String query;

  SearchPageArgs(this.query);

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{"query": query};
}

class OtherPageArgs extends AppRouteArgs {
  final String query;

  OtherPageArgs(this.query);

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{"query": query};
}

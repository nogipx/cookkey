import 'package:cookkey/route/export.dart';
import 'package:flutter/material.dart';

class RouteManager with ChangeNotifier {
  final Widget Function() unknownRoute;
  final Map<AppRoute, Widget Function()> mapRoute;

  static Widget rootScreen;

  RouteManager({
    @required this.mapRoute,
    @required this.unknownRoute,
  }) : assert(mapRoute != null && unknownRoute != null);

  List<Page> get pages => List.unmodifiable(_pages);
  final List<Page> _pages = [
    if (rootScreen != null)
      MaterialPage<dynamic>(
        key: ValueKey("/"),
        child: rootScreen ?? Scaffold(),
        name: "/",
      )
  ];

  void removeRoute(Route<dynamic> route, dynamic result) {
    _pages.removeWhere((e) => e.name == route.settings.name);
    notifyListeners();
  }

  void addRoute(AppRoute route) {
    final page = MaterialPage<dynamic>(
      key: ValueKey(route.actualUri),
      child: getScreen(route).call(),
      name: route.actualUri.toString(),
    );
    _pages.add(page);
    notifyListeners();
  }

  Widget Function() getScreen(AppRoute route) {
    return mapRoute[route] ?? unknownRoute;
  }
}

class MyPage extends Page<dynamic> {
  final Widget child;

  MyPage({@required this.child, LocalKey key}) : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder<dynamic>(
      settings: this,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

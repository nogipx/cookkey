import 'package:cookkey/route/export.dart';
import 'package:flutter/material.dart';

class RouteManager with ChangeNotifier {
  final AppRoute initialRoute;
  final Widget Function() unknownRoute;
  final Map<AppRoute, Widget Function()> mapRoute;

  static Widget rootScreen;
  List<Page> _pages;

  RouteManager({
    @required this.initialRoute,
    @required this.mapRoute,
    @required this.unknownRoute,
  }) : assert(mapRoute != null && unknownRoute != null && initialRoute != null) {
    _pages = [
      MaterialPage<dynamic>(
        key: ValueKey("/"),
        child: getPage(initialRoute).call(),
        name: "/",
      )
    ];
  }

  List<Page> get pages => List.unmodifiable(_pages);

  void removeRoute(Route<dynamic> route, dynamic result) {
    _pages.removeWhere((e) => e.name == route.settings.name);
    notifyListeners();
  }

  void pushRoute(AppRoute route) {
    final page = MaterialPage<dynamic>(
      key: ValueKey(route.actualUri),
      child: getPage(route).call(),
      name: route.actualUri.toString(),
    );
    _pages.add(page);
    notifyListeners();
  }

  Widget Function() getPage(AppRoute route) => mapRoute[route] ?? unknownRoute;
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

import 'package:cookkey/route/export.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRouteDelegate extends RouterDelegate<AppRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoute> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  final RouteManager routeManager;

  AppRouteDelegate({
    @required this.routeManager,
  }) : assert(routeManager != null) {
    routeManager.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RouteManager>(
      builder: (contex, manager, child) {
        return Navigator(
          key: _navigatorKey,
          pages: manager.pages,
          onPopPage: (route, dynamic result) {
            final didPop = route.didPop(result);
            if (!didPop) {
              return false;
            }
            routeManager.removeRoute(route, result);
            return true;
          },
        );
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoute configuration) async =>
      routeManager.pushRoute(configuration);

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}

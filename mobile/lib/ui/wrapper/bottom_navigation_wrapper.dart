import 'package:cookkey/ui/export.dart';
import 'package:flutter/material.dart';
import 'package:navigation_manager/navigation_manager.dart';

class BottomNavigationWrapper extends StatelessWidget {
  final Widget child;
  final RouteManager routeManager;
  final AppRoute currentRoute;
  final List<AppRoute> bottomNavigationRoutes;

  const BottomNavigationWrapper({
    Key key,
    @required this.child,
    @required this.routeManager,
    @required this.currentRoute,
    @required this.bottomNavigationRoutes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bottomNavigationRoutes.contains(currentRoute)) {
      return AppBottomNavigation(
        routeManager: routeManager,
        child: child,
      );
    } else {
      return child;
    }
  }
}

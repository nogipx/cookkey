import 'package:cookkey/ui/export.dart';
import 'package:flutter/material.dart';
import 'package:navigation_manager/navigation_manager.dart';

class BottomNavigationWrapper extends StatelessWidget {
  final Widget child;
  final RouteManager routeManager;
  final AppRoute currentRoute;
  final List<AppRoute> bottomNavigationRoutes;
  final double height;

  const BottomNavigationWrapper({
    Key key,
    @required this.child,
    @required this.routeManager,
    @required this.currentRoute,
    @required this.bottomNavigationRoutes,
    this.height = 56,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bottomNavigationRoutes.contains(currentRoute)) {
      return Stack(
        textDirection: TextDirection.ltr,
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: height,
            width: MediaQuery.of(context).size.width,
            child: child,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            height: height,
            child: AppBottomNavigation(
              routeManager: routeManager,
              child: Center(child: child),
            ),
          ),
        ],
      );
    } else {
      return child;
    }
  }
}

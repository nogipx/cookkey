import 'package:cookkey/color.dart';
import 'package:cookkey/routes.dart';
import 'package:navigation_manager/navigation_manager.dart';

import 'package:flutter/material.dart';

class AppBottomNavigation extends StatefulWidget {
  final RouteManager routeManager;
  final Widget child;
  final double borderWidth;

  const AppBottomNavigation({
    Key key,
    @required this.routeManager,
    @required this.child,
    this.borderWidth = 1,
  }) : super(key: key);

  @override
  _AppBottomNavigationState createState() => _AppBottomNavigationState();
}

class _AppBottomNavigationState extends State<AppBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    final currentRoot =
        widget.routeManager.pages.getVisibleSubTree()?.root?.customPage?.route;
    return Material(
      elevation: 1,
      shape: Border(
        top: BorderSide(color: CookkeyColor.substrate),
        bottom: BorderSide(color: CookkeyColor.substrate),
      ),
      color: CookkeyColor.background,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              color: currentRoot != null && currentRoot == CookkeyRoute.search
                  ? CookkeyColor.text
                  : Colors.grey,
              icon: Icon(Icons.search),
              onPressed: () {
                widget.routeManager.pushRoute(CookkeyRoute.search);
              },
            ),
            IconButton(
              color: currentRoot != null && currentRoot == CookkeyRoute.profile
                  ? CookkeyColor.text
                  : Colors.grey,
              icon: Icon(Icons.person),
              onPressed: () {
                widget.routeManager.pushRoute(CookkeyRoute.profile);
              },
            ),
          ],
        ),
      ),
    );
  }
}

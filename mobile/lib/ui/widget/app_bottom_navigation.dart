import 'package:cookkey/routes.dart';
import 'package:navigation_manager/navigation_manager.dart';

import 'package:flutter/material.dart';

class AppBottomNavigation extends StatefulWidget {
  final double height;
  final RouteManager routeManager;
  final Widget child;

  const AppBottomNavigation({
    Key key,
    @required this.routeManager,
    @required this.child,
    this.height = 56,
  }) : super(key: key);

  @override
  _AppBottomNavigationState createState() => _AppBottomNavigationState();
}

class _AppBottomNavigationState extends State<AppBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      child: Stack(
        textDirection: TextDirection.ltr,
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: widget.height,
            width: MediaQuery.of(context).size.width,
            child: widget.child,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: Colors.black12,
              height: widget.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.dashboard),
                    onPressed: () {
                      widget.routeManager.pushRoute(CookkeyRoute.dashboard);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      widget.routeManager.pushRoute(CookkeyRoute.search);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      widget.routeManager.pushRoute(CookkeyRoute.profile);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

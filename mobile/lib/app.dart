import 'package:cookkey/cookkey_route.dart';
import 'package:navigation_manager/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CookkeyMobileApp extends StatelessWidget {
  const CookkeyMobileApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RouteManager>(
      builder: (context, manager, child) {
        return MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routeInformationParser: AppRouteInformationParser(
            routes: CookkeyRoute.routes,
            unknownRoute: CookkeyRoute.unknown,
          ),
          routerDelegate: AppRouteDelegate(
            routeManager: manager,
          ),
        );
      },
    );
  }
}

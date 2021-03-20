import 'package:cookkey/color.dart';
import 'package:cookkey/routes.dart';
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
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
            backgroundColor: CookkeyColor.background,
            scaffoldBackgroundColor: CookkeyColor.background,
          ),
          routeInformationParser: AppRouteInformationParser(
            routes: CookkeyRoute.routes,
            debugging: true,
            initialRoute: CookkeyRoute.search,
            unknownRoute: CookkeyRoute.unknown,
            transformUri: (uri) {
              if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == "m") {
                return uri.replace(path: "/" + uri.pathSegments.skip(1).join("/"));
              } else {
                return uri;
              }
            },
          ),
          routerDelegate: AppRouteDelegate(
            routeManager: manager,
            navigatorWrapper: (navigator) {
              return navigator;
            },
          ),
        );
      },
    );
  }
}

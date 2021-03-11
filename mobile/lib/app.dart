import 'package:cookkey/route/delegate.dart';
import 'package:cookkey/route/export.dart';
import 'package:cookkey/route/manager.dart';
import 'package:cookkey/route/parser.dart';
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
          routeInformationParser: AppRouteInformationParser(),
          routerDelegate: AppRouteDelegate(
            routeManager: manager,
          ),
        );
      },
    );
  }
}

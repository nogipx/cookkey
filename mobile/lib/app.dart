import 'package:cookkey/bloc/scaffold_feedback.dart';
import 'package:cookkey/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
            navigatorWrapper: (navigator) {
              context.watch<FeedbackBloc>().listen((state) {
                Fluttertoast.showToast(msg: state.message);
              });
              return navigator;
            },
          ),
        );
      },
    );
  }
}

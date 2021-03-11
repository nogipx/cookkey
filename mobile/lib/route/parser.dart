import 'package:cookkey/cookkey_route.dart';
import 'package:cookkey/route/export.dart';
import 'package:flutter/material.dart';
import 'package:uri/uri.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRoute> {
  @override
  Future<AppRoute> parseRouteInformation(RouteInformation routeInformation) async {
    final _uri = Uri.parse(routeInformation.location);
    final route = CookkeyRoute.routes.firstWhere((route) {
      return UriParser(route.uriTemplate).matches(_uri);
    }).copyWith(actualUri: _uri);
    return route;
  }
}

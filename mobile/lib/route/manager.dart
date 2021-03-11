import 'dart:developer' as dev;

import 'package:cookkey/route/export.dart';
import 'package:flutter/material.dart';

class RouteManager with ChangeNotifier {
  final AppRoute initialRoute;
  final AppRoute Function(AppRoute route) onUnknownRoute;
  final Map<AppRoute, Widget Function(Map<String, dynamic> data)> mapRoute;
  final Widget Function(RouteManager manager, AppRoute route, Widget page) pageWrapper;

  List<Page> _pages;
  List<Page> get pages => List.unmodifiable(_pages);

  RouteManager({
    @required this.initialRoute,
    @required this.mapRoute,
    @required this.onUnknownRoute,
    this.pageWrapper,
  }) : assert(mapRoute != null && onUnknownRoute != null && initialRoute != null) {
    _pages = [
      MaterialPage<dynamic>(
        key: ValueKey(initialRoute.actualUri),
        child: getPageBuilder(initialRoute).call(<String, dynamic>{}),
        name: initialRoute.fill().actualUri.toString(),
      )
    ];
  }

  void removeRoute(Page page, dynamic result) {
    _pages.remove(page);
    notifyListeners();
  }

  void pushRoute(AppRoute route, {Map<String, dynamic> data}) {
    final _filledRoute = route.fill(data: data);
    final _actualUri = _filledRoute.actualUri.toString();
    final page = MaterialPage<dynamic>(
      key: ValueKey(_actualUri),
      child: getPageBuilder(_filledRoute).call(data),
      name: _actualUri,
    );
    _pages.add(page);
    notifyListeners();
  }

  /// Returns page builder function defined in mapping.
  /// If route is unknown, then ask for redirection route.
  Widget Function(Map<String, dynamic> data) getPageBuilder(AppRoute route) {
    Widget Function(Map<String, dynamic> data) _pageBuilder = mapRoute[route];

    if (_pageBuilder == null) {
      dev.log("No page builder for $route", name: runtimeType.toString());

      final _unknownRoute = onUnknownRoute(route).fill(data: route.data);
      _pageBuilder = mapRoute[_unknownRoute];

      if (_pageBuilder == null) {
        throw Exception("Push aborted. No page builder for 'unknown' $_unknownRoute");
      }
    }

    if (pageWrapper != null) {
      return (Map<String, dynamic> data) {
        return pageWrapper.call(this, route, _pageBuilder.call(data));
      };
    } else {
      return _pageBuilder;
    }
  }
}

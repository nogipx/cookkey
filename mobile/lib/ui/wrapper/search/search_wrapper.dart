import 'package:cookkey/bloc/filter/filter_bloc.dart';
import 'package:cookkey/ui/wrapper/search/search_header.dart';
import 'package:flutter/material.dart';
import 'package:navigation_manager/navigation_manager.dart';
import 'package:provider/provider.dart';

class SearchWrapper extends StatelessWidget {
  final Widget child;
  final RouteManager routeManager;
  final AppRoute currentRoute;
  final List<AppRoute> searchRoutes;
  final double searchHeight;

  const SearchWrapper({
    Key key,
    @required this.child,
    @required this.routeManager,
    @required this.currentRoute,
    @required this.searchRoutes,
    this.searchHeight = 56,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchRoutes.contains(currentRoute)) {
      return SafeArea(
        child: Stack(
          textDirection: TextDirection.ltr,
          children: [
            Positioned(
              left: 0,
              top: 0,
              height: searchHeight,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: SearchHeader(
                  filterBloc: context.read<FilterBloc>(),
                ),
              ),
            ),
            Positioned(
              top: searchHeight,
              left: 0,
              height: MediaQuery.of(context).size.height - searchHeight - 24,
              width: MediaQuery.of(context).size.width,
              child: child,
            )
          ],
        ),
      );
    } else {
      return child;
    }
  }
}

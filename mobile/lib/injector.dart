import 'dart:io' show HttpHeaders;

import 'package:convenient_bloc/request_cubit.dart';
import 'package:cookkey/routes.dart';
import 'package:cookkey/ui/export.dart';
import 'package:cookkey/repo/export.dart';
import 'package:cookkey/store/token_store.dart';
import 'package:cookkey/bloc/export.dart';
import 'package:cookkey/ui/wrapper/search/search_wrapper.dart';
import 'package:navigation_manager/navigation_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sdk/sdk.dart';
import 'package:cookkey/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DependencyInjector extends StatefulWidget {
  final Widget child;
  final SharedPreferences sharedPreferences;
  final ServerConfig server;

  const DependencyInjector({
    Key key,
    @required this.server,
    @required this.sharedPreferences,
    this.child,
  }) : super(key: key);

  @override
  _DependencyInjectorState createState() => _DependencyInjectorState();
}

class _DependencyInjectorState extends State<DependencyInjector> with CookkeyApi {
  AppSharedStore _sharedStore;
  RecipeRepo _recipeRepo;
  AuthRepo _authRepo;
  UserRepo _userRepo;
  TagRepo _tagRepo;
  RouteManager _routeManager;

  AuthBloc _authBloc;
  FilterBloc _filterBloc;

  RequestCubit<List<RecipeTag>, ApiError> _tagsCubit;

  @override
  void initState() {
    setupInjection();
    _routeManager = getRouteManager();
    _authBloc.restoreLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _routeManager),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: _sharedStore),
          RepositoryProvider.value(value: _authRepo),
          RepositoryProvider.value(value: _recipeRepo),
          RepositoryProvider.value(value: _userRepo),
          RepositoryProvider.value(value: _tagRepo),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: _authBloc),
            BlocProvider.value(value: _filterBloc),
            BlocProvider.value(value: _tagsCubit)
          ],
          child: widget.child,
        ),
      ),
    );
  }

  // Injection Setup
  void setupInjection() {
    final dio = Dio(BaseOptions(baseUrl: widget.server.toString()));
    dio.interceptors.add(getDioInterceptor(() => _sharedStore.token));

    _sharedStore = AppSharedStore(widget.sharedPreferences);

    _recipeRepo = RecipeRepoImpl(dio: dio);
    _authRepo = AuthRepo(dio: dio);
    _userRepo = UserRepoImpl(dio: dio);
    _tagRepo = TagRepoImpl(dio: dio);

    _authBloc = AuthBloc(
      authRepo: _authRepo,
      userRepo: _userRepo,
      sharedStore: _sharedStore,
    );
    _filterBloc = FilterBloc(tagRepo: _tagRepo);

    _tagsCubit = getAllRecipeTags(context, _tagRepo);
  }

  // Routing Setups
  RouteManager getRouteManager() {
    return RouteManager(
      debugging: true,
      initialRoute: CookkeyRoute.search,
      onUnknownRoute: (route) => CookkeyRoute.unknown,
      pageWrapper: (RouteManager manager, AppRoute route, Widget page) {
        return AuthRequireWrapper(
          currentRoute: route,
          authRoutes: CookkeyRoute.authRequired,
          child: SearchWrapper(
            currentRoute: route,
            routeManager: manager,
            searchRoutes: [CookkeyRoute.search],
            child: Consumer<RouteManager>(
              builder: (context, manager, _) {
                return BottomNavigationWrapper(
                  currentRoute: route,
                  routeManager: manager,
                  bottomNavigationRoutes: CookkeyRoute.withBottomNavigation,
                  child: page,
                );
              },
            ),
          ),
        );
      },
      onPushRoute: (manager, route) {
        print("PUSH $route, Stack Count: ${manager.pages}");
      },
      onRemoveRoute: (manager, route) {
        print("REMOVE $route, Stack Count: ${manager.pages}");
      },
      onDoublePushRoute: (manager, route) {
        print("DOUBLE $route, Stack Count: ${manager.pages.length}");
        return false;
      },
      onDoublePushSubRootRoute: (manager, route) {
        print("DOUBLE SUBROOT $route, Stack Count: ${manager.pages.length}");
        if (route == CookkeyRoute.search) {
          _tagsCubit.call();
        }
        return true;
      },
      transitionDuration: const Duration(milliseconds: 200),
      reverseTransitionDuration: const Duration(milliseconds: 100),
      transitionProvider: (child, animation, animation2) {
        return PageTransition<dynamic>(
          type: PageTransitionType.fade,
          child: child,
        ).buildTransitions(context, animation, animation2, child);
      },
    );
  }

  // Network Setup

  Interceptor getDioInterceptor(String Function() tokenProvider) {
    return InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        final token = tokenProvider();
        options.headers.addEntries([
          MapEntry<String, String>(HttpHeaders.contentTypeHeader, "application/json"),
          if (token != null)
            MapEntry<String, String>(HttpHeaders.authorizationHeader, "Bearer $token"),
        ]);
        return options;
      },
      onResponse: (Response response) async => response,
      onError: (DioError e) async {
        if (e.response?.data != null) {
          final _data = e.response.data as Map<String, dynamic>;
          throw ApiError.fromJson(_data);
        } else {
          return ApiError(
            statusCode: null,
            message: e.error.toString(),
          );
        }
      },
    );
  }
}

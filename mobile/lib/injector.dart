import 'dart:io' show HttpHeaders;

import 'package:cookkey/bloc/auth_bloc.dart';
import 'package:cookkey/bloc/scaffold_feedback.dart';
import 'package:cookkey/routes.dart';
import 'package:cookkey/page/wrapper/auth_require_wrapper.dart';
import 'package:cookkey/page/export.dart';
import 'package:cookkey/repo/export.dart';
import 'package:cookkey/store/token_store.dart';
import 'package:navigation_manager/navigation_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sdk/sdk.dart';
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

class _DependencyInjectorState extends State<DependencyInjector> {
  AppSharedStore _sharedStore;
  RecipeRepo _recipeRepo;
  AuthRepo _authRepo;
  UserRepo _userRepo;
  TagRepo _tagRepo;
  RouteManager _routeManager;

  AuthBloc _authBloc;
  FeedbackBloc _feedbackBloc;

  Map<AppRoute, Widget Function(Map<String, dynamic>)> get appRoutes {
    return {
      CookkeyRoute.login: (_) => LoginPage(authBloc: _authBloc),
      CookkeyRoute.dashboard: (_) => DashboardPage(),
      CookkeyRoute.search: (_) => SearchPage(),
      CookkeyRoute.profile: (_) => ProfilePage(authBloc: _authBloc),
      CookkeyRoute.unknown: (_) => Container(color: Colors.red),
    };
  }

  @override
  void initState() {
    _sharedStore = AppSharedStore(widget.sharedPreferences);

    final dio = Dio(BaseOptions(baseUrl: widget.server.toString()));
    dio.interceptors.add(getDioInterceptor(() => _sharedStore.token));

    _recipeRepo = RecipeRepoImpl(dio: dio);
    _authRepo = AuthRepo(dio: dio);
    _userRepo = UserRepoImpl(dio: dio);
    _tagRepo = TagRepoImpl(dio: dio);

    _feedbackBloc = FeedbackBloc();
    _authBloc = AuthBloc(
      authRepo: _authRepo,
      userRepo: _userRepo,
      sharedStore: _sharedStore,
    );

    _routeManager = RouteManager(
      initialRoute: CookkeyRoute.dashboard,
      onUnknownRoute: (route) => CookkeyRoute.unknown,
      mapRoute: appRoutes,
      pageWrapper: (manager, route, page) {
        _authBloc.restoreLogin();
        return BottomNavigationWrapper(
          currentRoute: route,
          routeManager: manager,
          bottomNavigationRoutes: [
            CookkeyRoute.search,
            CookkeyRoute.dashboard,
            CookkeyRoute.profile,
            CookkeyRoute.unknown,
          ],
          child: AuthRequireWrapper(
            currentRoute: route,
            authRoutes: [CookkeyRoute.profile],
            child: page,
          ),
        );
      },
      onPushRoute: (manager, route) {
        print("PUSH $route, Stack Count: ${manager.pages.length}");
      },
      onRemoveRoute: (manager, route) {
        print("REMOVE $route, Stack Count: ${manager.pages.length}");
      },
      onDoublePushRoute: (manager, route) {
        print("DOUBLE $route, Stack Count: ${manager.pages.length}");
        return false;
      },
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionProvider: (child, animation, animtation2) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );

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
            BlocProvider.value(value: _feedbackBloc),
          ],
          child: widget.child,
        ),
      ),
    );
  }

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

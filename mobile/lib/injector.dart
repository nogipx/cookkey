import 'dart:io';

import 'package:cookkey/bloc/auth_bloc.dart';
import 'package:cookkey/cookkey_route.dart';
import 'package:cookkey/repo/export.dart';
import 'package:cookkey/repo/tag_repo.dart';
import 'package:cookkey/route/export.dart';
import 'package:cookkey/screen/test_page.dart';
import 'package:cookkey/screen/test_page2.dart';
import 'package:cookkey/store/token_store.dart';
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

  @override
  void initState() {
    _sharedStore = AppSharedStore(widget.sharedPreferences);

    final dio = Dio(BaseOptions(baseUrl: widget.server.toString()));
    dio.interceptors.add(getDioInterceptor(() => _sharedStore.token));

    _recipeRepo = RecipeRepoImpl(dio: dio);
    _authRepo = AuthRepo(dio: dio);
    _userRepo = UserRepoImpl(dio: dio);
    _tagRepo = TagRepoImpl(dio: dio);

    _authBloc = AuthBloc(authRepo: _authRepo, sharedStore: _sharedStore);

    _routeManager = RouteManager(
      initialRoute: CookkeyRoute.mainPage,
      unknownRoute: () => Container(color: Colors.blue),
      mapRoute: {
        CookkeyRoute.mainPage: () => TestPage2(),
        CookkeyRoute.search: () => Scaffold(body: Container(color: Colors.yellow)),
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

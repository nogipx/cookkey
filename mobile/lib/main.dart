import 'package:bloc/bloc.dart';
import 'package:convenient_bloc/convenient_bloc.dart';
import 'package:cookkey/app.dart';
import 'package:cookkey/injector.dart';
import 'package:flutter/material.dart';
import 'package:sdk/sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

final server = ServerConfig(
  host: "192.168.1.50",
  port: 3000,
  protocol: "http",
);

Future<void> main() async {
  Bloc.observer = ConvenientBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DependencyInjector(
      server: server,
      sharedPreferences: await SharedPreferences.getInstance(),
      child: CookkeyMobileApp(),
    ),
  );
}

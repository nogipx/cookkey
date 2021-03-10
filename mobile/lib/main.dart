import 'dart:convert';
import 'dart:io';

import 'package:cookkey/app.dart';
import 'package:cookkey/injector.dart';
import 'package:cookkey/repo/recipe_repo.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sdk/sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

final server = ServerConfig(
  host: "192.168.1.50",
  port: 3000,
  protocol: "http",
);
void main() async {
  const testToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiIxOTIuMTY4LjEuNTAiLCJleHAiOi0xLCJpYXQiOiIyMDIxLTAzLTEwVDE4OjM1OjQyLjA1MDA0NSIsImlzcyI6ImFuZ2VsX2F1dGgiLCJwbGQiOnt9LCJzdWIiOiIyODlkY2JmMS1jMDEyLTQ4MzctYmYwOC1jNDA3NmQ0NDgwOWEifQ==.lyYLdv_8ItH5Qd7axqyWyBYt8HJDB0J6k5XGwKdM7Qg=";

  // final t = await recipeRepo.filterPublicRecipes(
  //   filterOption: FilterOption(
  //     text: "recipe",
  //   ),
  // );

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DependencyInjector(
      server: server,
      sharedPreferences: await SharedPreferences.getInstance(),
      child: CookkeyMobileApp(),
    ),
  );
}

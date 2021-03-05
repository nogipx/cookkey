import 'package:cookkey/app.dart';
import 'package:cookkey/injector.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DependencyInjector(
      child: CookkeyMobileApp(),
    ),
  );
}

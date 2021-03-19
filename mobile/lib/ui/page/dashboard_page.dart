import 'package:cookkey/bloc/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:navigation_manager/navigation_manager.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Dashboard page"),
          Container(color: Colors.blue),
        ],
      ),
    );
  }
}

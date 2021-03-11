import 'package:cookkey/cookkey_route.dart';
import 'package:cookkey/route/manager.dart';
import 'package:sdk/sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<RouteManager>().addRoute(CookkeyRoute.search);
        },
      ),
      body: Container(
        color: Colors.green,
        constraints: BoxConstraints.expand(),
        child: FutureBuilder<List<RecipeTag>>(
          future: context.watch<TagRepo>().getAllTags(),
          builder: (context, snapshot) {
            return Text(snapshot.data?.toString() ?? "No data");
          },
        ),
      ),
    );
  }
}

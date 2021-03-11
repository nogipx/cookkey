import 'package:cookkey/cookkey_route.dart';
import 'package:cookkey/route/manager.dart';
import 'package:sdk/sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestPage2 extends StatefulWidget {
  const TestPage2({Key key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<RouteManager>().addRoute(CookkeyRoute.search);
          context.read<TagRepo>().getAllTags();
        },
      ),
      body: Container(
        color: Colors.green,
        constraints: BoxConstraints.expand(),
        // child: FutureBuilder<List<RecipeTag>>(
        //   future: ,
        //   builder: (context, snapshot) {
        //     return Text(snapshot.data?.toString() ?? "No data");
        //   },
        // ),
      ),
    );
  }
}

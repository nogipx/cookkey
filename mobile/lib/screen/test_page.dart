import 'package:cookkey/repo/auth_repo.dart';
import 'package:sdk/sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

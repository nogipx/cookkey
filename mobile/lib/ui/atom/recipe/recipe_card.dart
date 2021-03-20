import 'package:flutter/material.dart';
import 'package:sdk/domain.dart';
import 'package:styled_widget/styled_widget.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(recipe.title ?? "Missing title")
              .textStyle(Theme.of(context).textTheme.subtitle1),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sdk/sdk.dart';

class TagsCategoryAtom extends StatelessWidget {
  final RecipeTagCategory category;
  final bool canEdit;
  final Function(RecipeTagCategory category) onTapEditCategory;

  const TagsCategoryAtom({
    Key key,
    @required this.category,
    this.canEdit = false,
    this.onTapEditCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(category?.translationKey ?? "Unknown category"),
        if (canEdit != null && canEdit && category != null)
          IconButton(
            iconSize: 20,
            splashRadius: 16,
            icon: Icon(Icons.edit_outlined),
            onPressed: () {},
          ),
      ],
    );
  }
}

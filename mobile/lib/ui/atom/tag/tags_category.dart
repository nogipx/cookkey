import 'package:cookkey/ui/export.dart';
import 'package:flutter/material.dart';
import 'package:sdk/sdk.dart';

class TagsCategoryAtom extends StatelessWidget {
  final RecipeTagCategory category;
  final List<RecipeTag> tags;
  final bool canEdit;
  final Function(RecipeTag tag) onTapTag;
  final Function(RecipeTagCategory category) onTapEditCategory;

  final Iterable<RecipeTag> activeTags;
  final Function(RecipeTag tag) onDeleteTag;

  const TagsCategoryAtom({
    Key key,
    @required this.tags,
    @required this.category,
    this.canEdit = false,
    this.onTapTag,
    this.onTapEditCategory,
    this.activeTags,
    this.onDeleteTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
        ),
        Wrap(
          children: tags.map((e) {
            final tag = e;
            final isActive = activeTags?.contains(tag) ?? false;
            return Container(
              // alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width / 2,
              child: TagEditMiddleware(
                hasEditPermission: canEdit,
                child: TagAtom(
                  tag: tag,
                  onPressed: onTapTag,
                  onDeleted: isActive ? onDeleteTag : null,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

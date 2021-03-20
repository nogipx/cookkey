import 'package:flutter/material.dart';
import 'package:sdk/sdk.dart';

class TagChipAtom extends StatelessWidget {
  final RecipeTag tag;
  final Function(RecipeTag tag) onDeleted;
  final Function(RecipeTag tag) onPressed;

  const TagChipAtom({
    Key key,
    @required this.tag,
    this.onDeleted,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(tag.translationKey ?? "MissTagTranslation"),
      onDeleted: onDeleted != null ? () => onDeleted?.call(tag) : null,
      onPressed: () => onPressed?.call(tag),
    );
  }
}

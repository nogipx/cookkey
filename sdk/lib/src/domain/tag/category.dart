import 'package:angel_validate/angel_validate.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'category.g.dart';

@CopyWith()
@JsonSerializable()
class RecipeTagCategory extends Equatable {
  final String id;

  /// Determines tag category translation.
  final String translationKey;

  /// Controls which single or multi select in category is available.
  final bool singleSelect;

  const RecipeTagCategory({
    @required this.id,
    @required this.translationKey,
    this.singleSelect = false,
  }) : assert(id != null && translationKey != null);

  @override
  List<Object> get props => [id, translationKey, singleSelect];

  @override
  String toString() => translationKey;

  factory RecipeTagCategory.fromJson(Map<String, dynamic> json) =>
      _$RecipeTagCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeTagCategoryToJson(this);

  static Validator get isValidCreate {
    return Validator(<String, dynamic>{
      "singleSelect": [isBool],
      "translationKey": [isNonEmptyString],
      "id!": <dynamic>[]
    });
  }
}

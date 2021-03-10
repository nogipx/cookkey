import 'package:angel_validate/angel_validate.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import 'export.dart';

part 'tag.g.dart';

/// Tags are received from backend.
/// It will be used for categorize and filter receipts.
@CopyWith()
@JsonSerializable(explicitToJson: true)
class RecipeTag extends Equatable {
  final String id;

  /// Determines which category this tag linked.
  final RecipeTagCategory category;

  /// Determines tag translation.
  final String translationKey;

  final bool isVisible;

  const RecipeTag({
    @required this.id,
    this.category,
    this.translationKey,
    this.isVisible = true,
  }) : assert(id != null);

  @override
  List<Object> get props => [id, category, translationKey, isVisible];

  @override
  String toString() => "Tag [$category : $translationKey]";

  factory RecipeTag.fromJson(Map<String, dynamic> json) => _$RecipeTagFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeTagToJson(this);

  static Validator get isValidUpdate {
    return Validator(<String, dynamic>{
      "id*, translationKey": [isNotNull, isNonEmptyString],
      "category": [isNotNull, isMap],
    });
  }

  static Validator get isValidCreate {
    return Validator(<String, dynamic>{
      "translationKey": [isNotNull, isNonEmptyString],
      "category": [isNotNull, isMap],
      "id!": <dynamic>[]
    }, defaultValues: <String, dynamic>{
      "isVisible": true
    });
  }
}

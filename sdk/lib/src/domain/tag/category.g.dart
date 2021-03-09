// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension RecipeTagCategoryCopyWith on RecipeTagCategory {
  RecipeTagCategory copyWith({
    String id,
    bool singleSelect,
    String translationKey,
  }) {
    return RecipeTagCategory(
      id: id ?? this.id,
      singleSelect: singleSelect ?? this.singleSelect,
      translationKey: translationKey ?? this.translationKey,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeTagCategory _$RecipeTagCategoryFromJson(Map<String, dynamic> json) {
  return RecipeTagCategory(
    id: json['id'] as String,
    translationKey: json['translationKey'] as String,
    singleSelect: json['singleSelect'] as bool,
  );
}

Map<String, dynamic> _$RecipeTagCategoryToJson(RecipeTagCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'translationKey': instance.translationKey,
      'singleSelect': instance.singleSelect,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension RecipeTagCopyWith on RecipeTag {
  RecipeTag copyWith({
    RecipeTagCategory category,
    String id,
    bool isVisible,
    String translationKey,
  }) {
    return RecipeTag(
      category: category ?? this.category,
      id: id ?? this.id,
      isVisible: isVisible ?? this.isVisible,
      translationKey: translationKey ?? this.translationKey,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeTag _$RecipeTagFromJson(Map<String, dynamic> json) {
  return RecipeTag(
    id: json['id'] as String,
    category: json['category'] == null
        ? null
        : RecipeTagCategory.fromJson(json['category'] as Map<String, dynamic>),
    translationKey: json['translationKey'] as String,
    isVisible: json['isVisible'] as bool,
  );
}

Map<String, dynamic> _$RecipeTagToJson(RecipeTag instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category?.toJson(),
      'translationKey': instance.translationKey,
      'isVisible': instance.isVisible,
    };

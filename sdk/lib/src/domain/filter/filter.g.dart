// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension FilterOptionCopyWith on FilterOption {
  FilterOption copyWith({
    Set<RecipeTag> tags,
    String text,
  }) {
    return FilterOption(
      tags: tags ?? this.tags,
      text: text ?? this.text,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterOption _$FilterOptionFromJson(Map<String, dynamic> json) {
  return FilterOption(
    text: json['text'] as String,
    tags: (json['tags'] as List)
        ?.map((e) =>
            e == null ? null : RecipeTag.fromJson(e as Map<String, dynamic>))
        ?.toSet(),
  );
}

Map<String, dynamic> _$FilterOptionToJson(FilterOption instance) =>
    <String, dynamic>{
      'text': instance.text,
      'tags': instance.tags?.toList(),
    };

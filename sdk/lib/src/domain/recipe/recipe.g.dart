// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension RecipeCopyWith on Recipe {
  Recipe copyWith({
    User author,
    int averageCookTime,
    String description,
    String id,
    List<Ingredient> ingredients,
    NutritionalValue nutritionalValue,
    int portions,
    bool publicVisible,
    List<RecipeTag> recipeTags,
    String title,
  }) {
    return Recipe(
      author: author ?? this.author,
      averageCookTime: averageCookTime ?? this.averageCookTime,
      description: description ?? this.description,
      id: id ?? this.id,
      ingredients: ingredients ?? this.ingredients,
      nutritionalValue: nutritionalValue ?? this.nutritionalValue,
      portions: portions ?? this.portions,
      publicVisible: publicVisible ?? this.publicVisible,
      recipeTags: recipeTags ?? this.recipeTags,
      title: title ?? this.title,
    );
  }
}

extension NutritionalValueCopyWith on NutritionalValue {
  NutritionalValue copyWith({
    int callories,
    double carbohydrates,
    double fats,
    double proteins,
  }) {
    return NutritionalValue(
      callories: callories ?? this.callories,
      carbohydrates: carbohydrates ?? this.carbohydrates,
      fats: fats ?? this.fats,
      proteins: proteins ?? this.proteins,
    );
  }
}

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

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return Recipe(
    id: json['id'] as String,
    recipeTags: (json['recipeTags'] as List)
        ?.map((e) =>
            e == null ? null : RecipeTag.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    title: json['title'] as String,
    description: json['description'] as String,
    averageCookTime: json['averageCookTime'] as int,
    portions: json['portions'] as int,
    ingredients: (json['ingredients'] as List)
        ?.map((e) =>
            e == null ? null : Ingredient.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    publicVisible: json['publicVisible'] as bool,
    author: json['author'] == null
        ? null
        : User.fromJson(json['author'] as Map<String, dynamic>),
    nutritionalValue: json['nutritionalValue'] == null
        ? null
        : NutritionalValue.fromJson(
            json['nutritionalValue'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'author': instance.author?.toJson(),
      'title': instance.title,
      'description': instance.description,
      'averageCookTime': instance.averageCookTime,
      'portions': instance.portions,
      'publicVisible': instance.publicVisible,
      'nutritionalValue': instance.nutritionalValue?.toJson(),
      'ingredients': instance.ingredients?.map((e) => e?.toJson())?.toList(),
      'recipeTags': instance.recipeTags?.map((e) => e?.toJson())?.toList(),
    };

NutritionalValue _$NutritionalValueFromJson(Map<String, dynamic> json) {
  return NutritionalValue(
    proteins: (json['proteins'] as num)?.toDouble(),
    fats: (json['fats'] as num)?.toDouble(),
    carbohydrates: (json['carbohydrates'] as num)?.toDouble(),
    callories: json['callories'] as int,
  );
}

Map<String, dynamic> _$NutritionalValueToJson(NutritionalValue instance) =>
    <String, dynamic>{
      'proteins': instance.proteins,
      'fats': instance.fats,
      'carbohydrates': instance.carbohydrates,
      'callories': instance.callories,
    };

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

RecipeTag _$RecipeTagFromJson(Map<String, dynamic> json) {
  return RecipeTag(
    id: json['id'] as String,
    category: json['category'] == null
        ? null
        : RecipeTagCategory.fromJson(json['category'] as Map<String, dynamic>),
    translationKey: json['translationKey'] as String,
  );
}

Map<String, dynamic> _$RecipeTagToJson(RecipeTag instance) => <String, dynamic>{
      'id': instance.id,
      'category': instance.category?.toJson(),
      'translationKey': instance.translationKey,
    };

Ingredient _$IngredientFromJson(Map<String, dynamic> json) {
  return Ingredient(
    id: json['id'] as String,
    type: json['type'] as String,
    title: json['title'] as String,
    measureValue: json['measureValue'] as int,
    measureType:
        _$enumDecodeNullable(_$IngredientMeasureEnumMap, json['measureType']),
  );
}

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'measureValue': instance.measureValue,
      'measureType': _$IngredientMeasureEnumMap[instance.measureType],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$IngredientMeasureEnumMap = {
  IngredientMeasure.Glass: 'Glass',
  IngredientMeasure.Tablespoon: 'Tablespoon',
  IngredientMeasure.TeaSpoon: 'TeaSpoon',
  IngredientMeasure.DessertSpoon: 'DessertSpoon',
  IngredientMeasure.Milliliter: 'Milliliter',
  IngredientMeasure.Kilogram: 'Kilogram',
  IngredientMeasure.Gram: 'Gram',
  IngredientMeasure.Liter: 'Liter',
};

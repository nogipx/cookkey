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
    List<String> recipeTags,
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

  Recipe copyWithNull({
    bool author = false,
    bool averageCookTime = false,
    bool description = false,
    bool id = false,
    bool ingredients = false,
    bool nutritionalValue = false,
    bool portions = false,
    bool publicVisible = false,
    bool recipeTags = false,
    bool title = false,
  }) {
    return Recipe(
      author: author == true ? null : this.author,
      averageCookTime: averageCookTime == true ? null : this.averageCookTime,
      description: description == true ? null : this.description,
      id: id == true ? null : this.id,
      ingredients: ingredients == true ? null : this.ingredients,
      nutritionalValue: nutritionalValue == true ? null : this.nutritionalValue,
      portions: portions == true ? null : this.portions,
      publicVisible: publicVisible == true ? null : this.publicVisible,
      recipeTags: recipeTags == true ? null : this.recipeTags,
      title: title == true ? null : this.title,
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return Recipe(
    id: json['id'] as String,
    recipeTags: (json['recipeTags'] as List)?.map((e) => e as String)?.toList(),
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
      'recipeTags': instance.recipeTags,
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

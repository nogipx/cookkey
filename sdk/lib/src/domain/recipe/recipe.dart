import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:sdk/domain.dart';

part 'recipe.g.dart';

@CopyWith()
@JsonSerializable(explicitToJson: true)
class Recipe {
  final String id;
  final User author;
  final String title;
  final String description;
  final int averageCookTime;
  final int portions;
  final bool publicVisible;
  final NutritionalValue nutritionalValue;
  final List<Ingredient> ingredients;
  final List<RecipeTag> recipeTags;
  // final List<FoodImage> images;

  const Recipe({
    this.id,
    this.recipeTags,
    this.title,
    this.description,
    this.averageCookTime,
    this.portions = 1,
    this.ingredients,
    // this.images,
    this.publicVisible = false,
    this.author,
    this.nutritionalValue,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}

@CopyWith()
@JsonSerializable()
class NutritionalValue {
  final double proteins;
  final double fats;
  final double carbohydrates;
  final int callories;

  const NutritionalValue({
    this.proteins = 0,
    this.fats = 0,
    this.carbohydrates = 0,
    this.callories = 0,
  });

  factory NutritionalValue.fromJson(Map<String, dynamic> json) =>
      _$NutritionalValueFromJson(json);
  Map<String, dynamic> toJson() => _$NutritionalValueToJson(this);
}

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
}

/// Tags are received from backend.
/// It will be used for categorize and filter receipts.
@JsonSerializable(explicitToJson: true)
class RecipeTag extends Equatable {
  final String id;

  /// Determines which category this tag linked.
  final RecipeTagCategory category;

  /// Determines tag translation.
  final String translationKey;

  const RecipeTag({
    @required this.id,
    @required this.category,
    @required this.translationKey,
  }) : assert(id != null && category != null && translationKey != null);

  @override
  List<Object> get props => [id, category, translationKey];

  @override
  String toString() => "Tag [$category : $translationKey]";

  factory RecipeTag.fromJson(Map<String, dynamic> json) => _$RecipeTagFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeTagToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Ingredient {
  final String id;
  final String type;
  final String title;
  final int measureValue;
  final IngredientMeasure measureType;

  Ingredient({
    @required this.id,
    @required this.type,
    @required this.title,
    this.measureValue,
    this.measureType,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => _$IngredientFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}

enum IngredientMeasure {
  Glass,
  Tablespoon,
  TeaSpoon,
  DessertSpoon,
  Milliliter,
  Kilogram,
  Gram,
  Liter,
}

class FoodImage {}

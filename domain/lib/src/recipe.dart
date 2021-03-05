import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Recipe {
  final User author;
  final String title;
  final String description;
  final int averageCookTime;
  final int portions;
  final bool publicVisible;
  final NutritionalValue nutritionalValue;
  final List<Ingredient> ingredients;
  final List<RecipeTag> recipeTags;
  final List<FoodImage> images;

  const Recipe({
    this.recipeTags,
    this.title,
    this.description,
    this.averageCookTime,
    this.portions,
    this.ingredients,
    this.images,
    this.publicVisible,
    this.author,
    this.nutritionalValue,
  });
}

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
}

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
}

/// Tags are received from backend.
/// It will be used for categorize and filter receipts.
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
}

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

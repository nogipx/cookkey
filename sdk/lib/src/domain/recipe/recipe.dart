import 'package:angel_validate/angel_validate.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sdk/domain.dart';

part 'recipe.g.dart';

@CopyWith(generateCopyWithNull: true)
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
  final List<String> recipeTags;
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

  static Validator get isValidCreate {
    return Validator(<String, dynamic>{
      "title*": [isNonEmptyString],
      "description": [isString],
      "nutritionalValue": [isMap],
      "averageCookTime, portions": [isNum, isNonNegative],
      "recipeTags!, publicVisible!, author!, id!": <dynamic>[]
    });
  }
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

class FoodImage {}

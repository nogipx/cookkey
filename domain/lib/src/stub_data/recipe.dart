import 'package:uuid/uuid.dart';
import 'package:domain/domain.dart';

String get randomId => Uuid().v4();

final Map<String, RecipeTag> testTags = {
  "complexityHard": RecipeTag(
    id: randomId,
    category: testTagCategories["complexity"],
    translationKey: "complexity.hard",
  ),
  "complexityEasy": RecipeTag(
    id: randomId,
    category: testTagCategories["complexity"],
    translationKey: "complexity.easy",
  ),
  "march8": RecipeTag(
    id: randomId,
    category: testTagCategories["event"],
    translationKey: "event.march8",
  ),
  "meat": RecipeTag(
    id: randomId,
    category: testTagCategories["foodType"],
    translationKey: "foodType.meat",
  ),
};

final Map<String, RecipeTagCategory> testTagCategories = {
  "complexity": RecipeTagCategory(
      id: randomId, translationKey: "tag.complexity", singleSelect: true),
  "foodType": RecipeTagCategory(
    id: randomId,
    translationKey: "tag.foodType",
  ),
  "event": RecipeTagCategory(
    id: randomId,
    translationKey: "tag.event",
  ),
  "firstDish": RecipeTagCategory(
    id: randomId,
    translationKey: "tag.firstDish",
  ),
  "secondDish": RecipeTagCategory(
    id: randomId,
    translationKey: "tag.secondDish",
  ),
  "dessert": RecipeTagCategory(
    id: randomId,
    translationKey: "tag.dessert",
  ),
};

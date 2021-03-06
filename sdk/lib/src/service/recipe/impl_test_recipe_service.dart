import 'dart:math';
import 'package:sdk/sdk.dart';
import 'package:sdk/test_data.dart';

class TestRecipeServiceImpl implements RecipeService {
  @override
  Future<List<Recipe>> getMyRecipes() async {
    return List.generate(30, (index) {
      return Recipe(
        title: "Test Recipe #$index",
        recipeTags: List.generate(
          Random().nextInt(testTags.length),
          (index) => testTags.values.elementAt(
            Random().nextInt(testTags.length),
          ),
        ).toSet().toList(),
      );
    });
  }

  @override
  Future<void> deleteRecipe(String recipeId) {
    // TODO: implement deleteRecipe
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTag(String tagId) {
    // TODO: implement deleteTag
    throw UnimplementedError();
  }
}

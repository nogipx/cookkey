import 'package:sdk/domain.dart';

abstract class RecipeRepo {
  Future<void> createRecipe(Recipe recipe);

  Future<void> updateRecipe(Recipe recipe);

  Future<void> deleteRecipeById(String id);

  Future<List<Recipe>> getRecipesByUserId(String id);

  Future<List<Recipe>> filterPublicRecipes();

  Future<Recipe> getRecipeById(String id);
}

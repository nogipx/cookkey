import 'package:sdk/domain.dart';

abstract class RecipeRepo {
  Future<void> createRecipe(Recipe recipe);

  Future<void> updateRecipe(Recipe recipe);

  Future<void> deleteRecipeById(String recipeId);

  Future filterPublicRecipes(
      {FilterOption filterOption, String userId, bool hasPermission});

  Future<List<Recipe>> getRecipesByUserId(String userId);

  Future<List<Recipe>> getRecipesByIds(List<String> recipeIds);

  Future<Recipe> getRecipeById(String recipeId);

  Future<Recipe> publishRecipe(String recipeId);

  Future<Recipe> unpublishRecipe(String recipeId);

  Future<Recipe> addTags(List<String> tags, String id);

  Future<Recipe> removeTags(List<String> tags, String recipeId);

  Future<List<RecipeTag>> getTagsByRecipeId(String recipeId);
}

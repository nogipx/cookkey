import 'package:sdk/domain.dart';

abstract class RecipeRepo {
  Future<void> createRecipe(Recipe recipe);

  Future<void> updateRecipe(Recipe recipe);

  Future<void> deleteRecipeById(String id);

  Future filterPublicRecipes(
      {FilterOption filterOption, String userId, bool hasPermission});

  Future<List<Recipe>> getRecipesByUserId(String id);

  Future<List<Recipe>> getRecipesByIds(List<String> ids);

  Future<Recipe> getRecipeById(String id);

  Future<Recipe> publishRecipe(String id);

  Future<Recipe> unpublishRecipe(String id);

  Future<Recipe> addTags(List<String> tags, String id);

  Future<Recipe> removeTags(List<String> tags, String id);

  Future<List<RecipeTag>> getTagsByRecipeId(String id);
}

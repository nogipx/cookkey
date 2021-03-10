import 'package:sdk/domain.dart';
import 'package:meta/meta.dart';

abstract class RecipeRepo {
  Future<Recipe> createRecipe(Recipe recipe);

  Future<Recipe> updateRecipe(Recipe recipe);

  Future<void> deleteRecipeById(String recipeId);

  Future<List<Recipe>> filterRecipes(
      {@required FilterOption filterOption, String userId, bool hasPermission});

  Future<List<Recipe>> getRecipesByUserId(String userId);

  Future<List<Recipe>> getRecipesByIds(List<String> recipeIds);

  Future<Recipe> getRecipeById(String recipeId);

  Future<Recipe> publishRecipe(String recipeId);

  Future<Recipe> unpublishRecipe(String recipeId);

  Future<Recipe> addTags(List<String> tagIds, String recipeId);

  Future<Recipe> removeTags(List<String> tagIds, String recipeId);

  Future<List<RecipeTag>> getTagsByRecipeId(String recipeId);
}

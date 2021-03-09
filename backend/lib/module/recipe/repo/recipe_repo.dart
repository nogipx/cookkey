import 'package:sdk/domain.dart';

abstract class RecipeRepo {
  Future<void> createRecipe(Recipe recipe);

  Future<void> updateRecipe(Recipe recipe);

  Future<void> deleteRecipeById(String id);

  Future<List<Recipe>> filterPublicRecipes();

  Future<List<Recipe>> getRecipesByUserId(String id);

  Future<List<Recipe>> getRecipesByIds(List<String> ids);

  Future<Recipe> getRecipeById(String id);

  Future<Recipe> publishRecipe(String id);

  Future<Recipe> unpublishRecipe(String id);

  Future<void> attachTag(RecipeTag tag, String id);

  Future<void> detachTag(RecipeTag tag, String id);

  Future<List<RecipeTag>> getTagsByRecipeId(String id);
}

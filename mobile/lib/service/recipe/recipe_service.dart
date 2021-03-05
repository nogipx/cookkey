import 'package:domain/domain.dart';

abstract class RecipeService {
  Future<List<Recipe>> getMyRecipes();

  Future<void> deleteRecipe(String recipeId);

  Future<void> deleteTag(String tagId);
}

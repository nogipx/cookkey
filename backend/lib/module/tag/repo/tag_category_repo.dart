import 'package:sdk/sdk.dart';

abstract class TagCategoryRepo {
  Future<RecipeTagCategory> createCategory(RecipeTagCategory tag);

  Future<RecipeTagCategory> updateCategory(RecipeTagCategory tag);

  Future<void> deleteCategoryById(String id);

  Future<RecipeTagCategory> getCategoryById(String id);

  Future<List<RecipeTagCategory>> getAllCategories();
}

import 'package:sdk/sdk.dart';

abstract class TagCategoryRepo {
  Future<RecipeTagCategory> createCategory(RecipeTagCategory tagCategory);

  Future<RecipeTagCategory> updateCategory(RecipeTagCategory tagCategory);

  Future<void> deleteCategoryById(String tagCategoryId);

  Future<RecipeTagCategory> getCategoryById(String tagCategoryId);

  Future<List<RecipeTagCategory>> getAllCategories();
}

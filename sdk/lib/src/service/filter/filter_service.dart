import 'package:sdk/domain.dart';

abstract class FilterService {
  Future<List<RecipeTag>> getAvailableTags();

  Future<List<RecipeTagCategory>> getAvailableTagsCategories();

  Future<void> deleteTagCategory(String tagCategoryId);

  Future<void> deleteTag(String tagId);
}

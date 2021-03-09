import 'package:sdk/domain.dart';

abstract class TagRepo {
  Future<RecipeTag> createTag(RecipeTag tag);

  Future<RecipeTag> updateTag(RecipeTag tag);

  Future<void> deleteTagById(String id);

  Future<List<RecipeTag>> getTagsByIds(List<String> ids);

  Future<RecipeTag> getTagById(String id);

  Future<List<RecipeTag>> getTagsByCategoryId(String categoryId);

  Future<List<RecipeTag>> getAllTags();

  Future<RecipeTag> changeCategory(RecipeTagCategory category, String tagId);
}

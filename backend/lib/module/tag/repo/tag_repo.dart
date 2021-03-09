import 'package:sdk/domain.dart';

abstract class TagControllers {
  Future<RecipeTag> createTag(RecipeTag tag);

  Future<RecipeTag> updateTag(RecipeTag tag);

  Future<void> deleteTagById(String id);

  Future<List<RecipeTag>> getTagsByIds(List<String> ids);

  Future<RecipeTag> getTagById(String id);

  Future<List<RecipeTag>> getTagsByCategoryId(String categoryId);

  Future<RecipeTag> changeCategory(RecipeTagCategory category, String tagId);
}

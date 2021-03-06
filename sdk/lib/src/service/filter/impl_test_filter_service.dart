import 'package:sdk/sdk.dart';
import 'package:sdk/test_data.dart';

class TestFilterServiceImpl implements FilterService {
  @override
  Future<List<RecipeTag>> getAvailableTags() async {
    return testTags.values.toList();
  }

  @override
  Future<List<RecipeTagCategory>> getAvailableTagsCategories() async {
    return testTagCategories.values.toList();
  }

  @override
  Future<void> deleteTag(String tagId) {
    // TODO: implement deleteTag
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTagCategory(String tagCategoryId) {
    // TODO: implement deleteTagCategory
    throw UnimplementedError();
  }
}

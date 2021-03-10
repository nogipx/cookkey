import 'package:mongo_dart/mongo_dart.dart';
import 'package:meta/meta.dart';
import 'package:backend/util/export.dart';
import 'package:sdk/domain.dart';
import 'package:sdk/sdk.dart';

class TagCategoryRepoMongoImpl implements TagCategoryRepo {
  final Db mongo;
  final String tagCategoryCollection;

  const TagCategoryRepoMongoImpl({
    @required this.mongo,
    @required this.tagCategoryCollection,
  });

  @override
  Future<RecipeTagCategory> createCategory(RecipeTagCategory tag) async {
    await mongo.collection(tagCategoryCollection).insert(tag.toJson());
    return tag;
  }

  @override
  Future<RecipeTagCategory> updateCategory(RecipeTagCategory tag) async {
    await mongo
        .collection(tagCategoryCollection)
        .update(where.eq("id", tag.id), tag.toJson());
    return tag;
  }

  @override
  Future<void> deleteCategoryById(String id) async {
    await mongo.collection(tagCategoryCollection).remove(where.eq("id", id));
  }

  @override
  Future<List<RecipeTagCategory>> getAllCategories() async {
    final json = mongo.collection(tagCategoryCollection).find();
    return await json
        .deserialize<RecipeTagCategory>((json) => RecipeTagCategory.fromJson(json))
        .toList();
  }

  @override
  Future<RecipeTagCategory> getCategoryById(String id) async {
    final json =
        await mongo.collection(tagCategoryCollection).findOne(where.eq("id", id));
    return json
        .deserialize<RecipeTagCategory>((json) => RecipeTagCategory.fromJson(json));
  }
}

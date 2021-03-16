import 'package:mongo_dart/mongo_dart.dart';
import 'package:meta/meta.dart';
import 'package:sdk/domain.dart';
import 'package:backend/util/export.dart';
import 'package:sdk/sdk.dart';

class TagRepoMongoImpl implements TagRepo {
  final Db mongo;
  final String tagCollection;

  const TagRepoMongoImpl({
    @required this.mongo,
    @required this.tagCollection,
  });

  @override
  Future<RecipeTag> createTag(RecipeTag tag) async {
    await mongo.collection(tagCollection).insert(tag.toJson());
    return tag;
  }

  @override
  Future<RecipeTag> updateTag(RecipeTag tag) async {
    await mongo.collection(tagCollection).update(where.eq("id", tag.id), tag.toJson());
    return tag;
  }

  @override
  Future<void> deleteTagById(String id) async {
    await mongo.collection(tagCollection).remove(where.eq("id", id));
  }

  @override
  Future<RecipeTag> getTagById(String id) async {
    final json = await mongo.collection(tagCollection).findOne(where.eq("id", id));
    return json.deserialize<RecipeTag>((json) => RecipeTag.fromJson(json));
  }

  @override
  Future<RecipeTag> changeCategory(RecipeTagCategory category, String tagId) async {
    final tag = (await getTagById(tagId)).copyWith(category: category);
    return await updateTag(tag);
  }

  @override
  Future<List<RecipeTag>> getTagsByCategoryId(String categoryId) async {
    final json =
        mongo.collection(tagCollection).find(where.eq("category.id", categoryId));
    return await json.deserialize((json) => RecipeTag.fromJson(json)).toList();
  }

  @override
  Future<List<RecipeTag>> getTagsByIds(List<String> ids) async {
    final json = mongo.collection(tagCollection).find(where.oneFrom("id", ids));
    return await json.deserialize((json) => RecipeTag.fromJson(json)).toList();
  }

  @override
  Future<List<RecipeTag>> getAllTags() async {
    final json = mongo.collection(tagCollection).find();
    return await json.deserialize((json) => RecipeTag.fromJson(json)).toList();
  }
}

import 'package:cookkey/util/response_processing.dart';
import 'package:sdk/sdk.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

class TagRepoImpl with EasyRequest implements TagRepo {
  final Dio dio;

  const TagRepoImpl({@required this.dio});

  @override
  Future<RecipeTag> createTag(RecipeTag tag) {
    return request<RecipeTag, Map>(
      onResult: (json) => RecipeTag.fromJson(json as Map<String, dynamic>),
      requestProvider: () => dio.post<Map>("/tag/create", data: tag.toJson()),
    );
  }

  @override
  Future<RecipeTag> updateTag(RecipeTag tag) {
    return request<RecipeTag, Map>(
      onResult: (json) => RecipeTag.fromJson(json as Map<String, dynamic>),
      requestProvider: () => dio.put<Map>("/tag/update", data: tag.toJson()),
    );
  }

  @override
  Future<void> deleteTagById(String tagId) {
    return request<RecipeTag, Map>(
      onResult: (json) => RecipeTag.fromJson(json as Map<String, dynamic>),
      requestProvider: () => dio.delete<Map>("/tag/delete", data: {
        "tagId": tagId,
      }),
    );
  }

  @override
  Future<List<RecipeTag>> getAllTags() {
    return request<List<RecipeTag>, List>(
      onResult: (json) =>
          json.map((dynamic e) => RecipeTag.fromJson(e as Map<String, dynamic>)).toList(),
      requestProvider: () => dio.get<List>("/tag/all"),
    );
  }

  @override
  Future<RecipeTag> getTagById(String tagId) {
    return request<RecipeTag, Map>(
      onResult: (json) => RecipeTag.fromJson(json as Map<String, dynamic>),
      requestProvider: () => dio.get<Map>("/tag/get/$tagId"),
    );
  }

  @override
  Future<RecipeTag> changeCategory(RecipeTagCategory category, String tagId) {
    return request<RecipeTag, Map>(
      onResult: (json) => RecipeTag.fromJson(json as Map<String, dynamic>),
      requestProvider: () => dio.get<Map>("/tag/$tagId/changeCategory/${category.id}"),
    );
  }

  @override
  Future<List<RecipeTag>> getTagsByCategoryId(String categoryId) {
    throw UnimplementedError();
  }

  @override
  Future<List<RecipeTag>> getTagsByIds(List<String> tagIds) {
    throw UnimplementedError();
  }
}

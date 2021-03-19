import 'dart:convert';

import 'package:cookkey/repo/export.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:sdk/sdk.dart';

@sealed
class RecipeRepoImpl with EasyRequest implements RecipeRepo {
  final Dio dio;

  const RecipeRepoImpl({
    @required this.dio,
  });

  @override
  Future<Recipe> createRecipe(Recipe recipe) {
    return request<Recipe, Map>(
      onResult: (json) => Recipe.fromJson(json as Map<String, dynamic>),
      requestProvider: () => dio.post<Map>(
        "/recipe/create",
        data: jsonEncode(recipe.toJson()),
      ),
    );
  }

  @override
  Future<Recipe> updateRecipe(Recipe recipe) {
    return request<Recipe, Map>(
      onResult: (json) => Recipe.fromJson(json as Map<String, dynamic>),
      requestProvider: () =>
          dio.put<List>("/recipe/update/${recipe.id}", data: jsonEncode(recipe.toJson())),
    );
  }

  @override
  Future<void> deleteRecipeById(String recipeId) {
    return request<void, void>(
      requestProvider: () => dio.delete<void>(
        "/recipe/create",
        data: jsonEncode(<String, dynamic>{"recipeId": recipeId}),
      ),
    );
  }

  @override
  @protected
  Future<List<Recipe>> filterRecipes(
      {@required FilterOption filterOption, String userId, bool hasPermission}) {
    return request<List<Recipe>, List>(
      onResult: (json) =>
          json.map((dynamic e) => Recipe.fromJson(e as Map<String, dynamic>)).toList(),
      requestProvider: () => dio.get<List>(
        "/recipe/filter/${filterOption.toQuery()}",
      ),
    );
  }

  @override
  Future<Recipe> getRecipeById(String recipeId) {
    return request<Recipe, Map>(
      onResult: (json) => Recipe.fromJson(json as Map<String, dynamic>),
      requestProvider: () => dio.get<List>(
        "/recipe/get/$recipeId",
      ),
    );
  }

  @override
  Future<List<Recipe>> getRecipesByIds(List<String> recipeIds) {
    return request<List<Recipe>, List>(
      onResult: (json) =>
          json.map((dynamic e) => Recipe.fromJson(e as Map<String, dynamic>)).toList(),
      requestProvider: () => dio.get<List>(
        "/recipe/get/many/${recipeIds.join(',')}",
      ),
    );
  }

  @override
  Future<List<Recipe>> getRecipesByUserId(String userId) {
    // TODO: implement getRecipesByUserId
    throw UnimplementedError();
  }

  @override
  Future<List<RecipeTag>> getTagsByRecipeId(String recipeId) {
    // TODO: implement getTagsByRecipeId
    throw UnimplementedError();
  }

  @override
  Future<Recipe> addTags(List<String> tagIds, String recipeId) async {
    return request<Recipe, Map>(
      onResult: (json) => Recipe.fromJson(json as Map<String, dynamic>),
      requestProvider: () => dio.get<Map>("/recipe/$recipeId/addTag/${tagIds.join(',')}"),
    );
  }

  @override
  Future<Recipe> removeTags(List<String> tagIds, String recipeId) {
    return request<Recipe, Map>(
      onResult: (json) => Recipe.fromJson(json as Map<String, dynamic>),
      requestProvider: () => dio.put<List>(
        "/recipe/$recipeId/removeTags/${tagIds.join(',')}",
      ),
    );
  }

  @override
  Future<Recipe> publishRecipe(String recipeId) {
    return request<Recipe, Map>(
      onResult: (json) => Recipe.fromJson(json as Map<String, dynamic>),
      requestProvider: () => dio.put<List>(
        "/recipe/publish/$recipeId",
      ),
    );
  }

  @override
  @protected
  Future<Recipe> unpublishRecipe(String recipeId) {
    return request<Recipe, Map>(
      onResult: (json) => Recipe.fromJson(json as Map<String, dynamic>),
      requestProvider: () => dio.put<List>(
        "/recipe/unpublish/$recipeId",
      ),
    );
  }
}

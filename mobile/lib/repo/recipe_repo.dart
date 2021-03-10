import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:sdk/sdk.dart';

import 'base_repo.dart';

class RecipeRepoImpl with EasyRequest implements RecipeRepo {
  final Dio dio;

  const RecipeRepoImpl({
    @required this.dio,
  });

  @override
  Future<Recipe> addTags(List<String> tagIds, String recipeId) async {
    return request(
      onResult: (dynamic json) => Recipe.fromJson(json as Map<String, dynamic>),
      requestProvider: () => dio.get<Map>("/recipe/$recipeId/addTag/${tagIds.join(',')}"),
    );
  }

  @override
  Future<Recipe> createRecipe(Recipe recipe) {
    return request(
      onResult: (dynamic json) => Recipe.fromJson(json as Map<String, dynamic>),
      requestProvider: () => dio.post<Map>(
        "/recipe/create",
        data: jsonEncode(recipe.toJson()),
      ),
    );
  }

  @override
  Future<void> deleteRecipeById(String recipeId) {
    return request(
      requestProvider: () => dio.delete<void>(
        "/recipe/create",
        data: jsonEncode(<String, dynamic>{"recipeId": recipeId}),
      ),
    );
  }

  @override
  Future<List<Recipe>> filterPublicRecipes(
      {FilterOption filterOption, String userId, bool hasPermission}) {
    return request<List<Recipe>>(
      onResult: (dynamic json) => (json as List)
          .map((dynamic e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList(),
      requestProvider: () => dio.get<dynamic>(
        "/recipe/filter/${filterOption.toQuery()}",
      ),
    );
  }

  @override
  Future<Recipe> getRecipeById(String recipeId) {
    // TODO: implement getRecipeById
    throw UnimplementedError();
  }

  @override
  Future<List<Recipe>> getRecipesByIds(List<String> recipeIds) {
    // TODO: implement getRecipesByIds
    throw UnimplementedError();
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
  Future<Recipe> publishRecipe(String recipeId) {
    // TODO: implement publishRecipe
    throw UnimplementedError();
  }

  @override
  Future<Recipe> removeTags(List<String> tagIds, String recipeId) {
    // TODO: implement removeTags
    throw UnimplementedError();
  }

  @override
  Future<Recipe> unpublishRecipe(String recipeId) {
    // TODO: implement unpublishRecipe
    throw UnimplementedError();
  }

  @override
  Future<Recipe> updateRecipe(Recipe recipe) {
    // TODO: implement updateRecipe
    throw UnimplementedError();
  }
}

import 'package:backend/module/recipe/repo/recipe_repo.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:sdk/domain.dart';
import 'package:meta/meta.dart';
import 'package:backend/util/export.dart';

class ImplMongoRecipeRepo implements RecipeRepo {
  final Db mongo;

  const ImplMongoRecipeRepo({
    @required this.mongo,
  }) : assert(mongo != null);

  static const recipeCollection = "recipe";

  @override
  Future<void> createRecipe(Recipe recipe) async {
    await mongo.collection(recipeCollection).insert(recipe.toJson());
  }

  @override
  Future<void> deleteRecipeById(String id) async {
    await mongo.collection(recipeCollection).remove(where.eq("id", id));
  }

  @override
  Future<void> updateRecipe(Recipe recipe) async {
    await mongo
        .collection(recipeCollection)
        .update(where.eq("id", recipe.id), recipe.toJson());
  }

  @override
  Future<List<Recipe>> getRecipesByUserId(String id) async {
    final json = mongo.collection(recipeCollection).find(where.eq("author.id", id));
    return await json.deserialize<Recipe>((json) => Recipe.fromJson(json)).toList();
  }

  @override
  Future<Recipe> getRecipeById(String id) async {
    final json = await mongo.collection(recipeCollection).findOne(where.eq("id", id));
    return json.deserialize<Recipe>((json) => Recipe.fromJson(json));
  }

  @override
  Future<List<Recipe>> getRecipesByIds(List<String> ids) async {
    final json = mongo.collection(recipeCollection).find(where.oneFrom("id", ids));
    return await json.deserialize<Recipe>((json) => Recipe.fromJson(json)).toList();
  }

  @override
  Future<List<Recipe>> filterPublicRecipes() {
    throw UnimplementedError();
  }

  @override
  Future<void> attachTag(RecipeTag tag, String id) async {
    final recipe = await getRecipeById(id);
    recipe.recipeTags.add(tag);
    return await updateRecipe(recipe);
  }

  @override
  Future<void> detachTag(RecipeTag tag, String id) async {
    final recipe = await getRecipeById(id);
    recipe.recipeTags.removeWhere((e) => e.id == tag.id);
    return await updateRecipe(recipe);
  }

  @override
  Future<Recipe> publishRecipe(String id) async {
    final recipe = (await getRecipeById(id)).copyWith(publicVisible: true);
    await mongo.collection(recipeCollection).update(where.eq("id", id), recipe.toJson());
    return recipe;
  }

  @override
  Future<Recipe> unpublishRecipe(String id) async {
    final recipe = (await getRecipeById(id)).copyWith(publicVisible: false);
    await mongo.collection(recipeCollection).update(where.eq("id", id), recipe.toJson());
    return recipe;
  }

  @override
  Future<List<RecipeTag>> getTagsByRecipeId(String id) async {
    final recipe = await getRecipeById(id);
    return recipe.recipeTags;
  }
}

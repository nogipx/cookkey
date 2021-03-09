import 'package:backend/module/recipe/repo/recipe_repo.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:sdk/domain.dart';
import 'package:meta/meta.dart';
import 'package:backend/util/export.dart';
import 'package:dartx/dartx.dart';

class RecipeRepoMongoImpl implements RecipeRepo {
  final Db mongo;

  const RecipeRepoMongoImpl({
    @required this.mongo,
  }) : assert(mongo != null);

  static const recipeCollection = "recipe";

  @override
  Future<void> createRecipe(Recipe recipe) async {
    await mongo.collection(recipeCollection).insert(recipe.toJsonSimplifyTags());
  }

  @override
  Future<void> deleteRecipeById(String id) async {
    await mongo.collection(recipeCollection).remove(where.eq("id", id));
  }

  @override
  Future<void> updateRecipe(Recipe recipe) async {
    await mongo
        .collection(recipeCollection)
        .update(where.eq("id", recipe.id), recipe.toJsonSimplifyTags());
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
  Future<Recipe> addTags(List<RecipeTag> tags, String id) async {
    Recipe recipe = await getRecipeById(id);
    if (recipe.recipeTags == null) {
      recipe = recipe.copyWith(recipeTags: tags);
    } else {
      recipe = recipe.copyWith(
        recipeTags: recipe.recipeTags.append(tags).distinctBy((e) => e.id).toList(),
      );
    }
    await updateRecipe(recipe);
    return recipe;
  }

  @override
  Future<Recipe> removeTags(List<RecipeTag> tags, String id) async {
    final recipe = await getRecipeById(id);
    if (recipe.recipeTags == null || recipe.recipeTags.isEmpty) {
      throw ApiError.conflict(message: "Recipe has no tag.");
    }
    final _tagsIds = tags.map((e) => e.id);
    recipe.recipeTags.removeWhere((e) => _tagsIds.contains(e.id));
    await updateRecipe(recipe);
    return recipe;
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

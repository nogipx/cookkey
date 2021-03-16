import 'package:mongo_dart/mongo_dart.dart';
import 'package:sdk/domain.dart';
import 'package:meta/meta.dart';
import 'package:backend/util/export.dart';
import 'package:dartx/dartx.dart';
import 'package:sdk/sdk.dart';

class RecipeRepoMongoImpl implements RecipeRepo {
  final Db mongo;
  final String recipeCollection;
  final TagRepo tagRepo;

  const RecipeRepoMongoImpl({
    @required this.mongo,
    @required this.recipeCollection,
    @required this.tagRepo,
  }) : assert(mongo != null && recipeCollection != null);

  @override
  Future<Recipe> createRecipe(Recipe recipe) async {
    await mongo.collection(recipeCollection).insert(recipe.toJson());
    return recipe;
  }

  @override
  Future<void> deleteRecipeById(String id) async {
    await mongo.collection(recipeCollection).remove(where.eq("id", id));
  }

  @override
  Future<Recipe> updateRecipe(Recipe recipe) async {
    await mongo
        .collection(recipeCollection)
        .update(where.eq("id", recipe.id), recipe.toJson());
    return recipe;
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
  Future<List<Recipe>> filterRecipes(
      {@required FilterOption filterOption, String userId, bool hasPermission}) async {
    var _pipeline = AggregationPipelineBuilder();

    if (filterOption.text != null) {
      _pipeline = _pipeline.addStage(Match(Expr(Or(<dynamic>[
        RegexFind(
          input: ToLower(Field("title")),
          regex: filterOption.text.toLowerCase(),
        ),
        RegexFind(
          input: ToLower(Field("description")),
          regex: filterOption.text.toLowerCase(),
        )
      ]))));
    }

    if (filterOption.tags != null && filterOption.tags.isNotEmpty) {
      final ids = filterOption.tags?.map((e) => e.id)?.toList();
      _pipeline = _pipeline.addStage(Match(where.all("recipeTags", ids).map['\$query']));
    }

    if (!hasPermission) {
      _pipeline = _pipeline.addStage(Match(Expr(Or(<dynamic>[
        if (userId != null) Eq(Field("author.id"), userId),
        Eq(Field("publicVisible"), true),
      ]))));
    }

    final json = mongo.collection(recipeCollection).aggregateToStream(_pipeline.build());
    return json.deserialize((json) => Recipe.fromJson(json)).toList();
  }

  @override
  Future<Recipe> addTags(List<String> tags, String id) async {
    Recipe recipe = await getRecipeById(id);
    if (recipe.recipeTags == null) {
      recipe = recipe.copyWith(recipeTags: tags);
    } else {
      recipe = recipe.copyWith(
        recipeTags: recipe.recipeTags.prepend(tags).distinct().toList(),
      );
    }
    await updateRecipe(recipe);
    return recipe;
  }

  @override
  Future<Recipe> removeTags(List<String> tags, String id) async {
    final recipe = await getRecipeById(id);
    if (recipe.recipeTags == null || recipe.recipeTags.isEmpty) {
      throw ApiError.conflict(message: "Recipe has no tag.");
    }
    recipe.recipeTags.removeWhere((e) => tags.contains(e));
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
    return await tagRepo.getTagsByIds(recipe.recipeTags);
  }
}

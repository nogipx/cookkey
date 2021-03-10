import 'package:angel_auth/angel_auth.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:backend/config.dart';
import 'package:backend/util/export.dart';
import 'package:sdk/domain.dart';
import 'package:sdk/sdk.dart';
import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart';
import 'package:angel_validate/angel_validate.dart';

@Expose("/recipe")
class RecipeController extends Controller with AppPermission {
  final RecipeRepo recipeRepo;
  final TagRepo tagRepo;

  RecipeController({
    @required this.recipeRepo,
    @required this.tagRepo,
  });

  @Expose("/create", method: "POST")
  Future createRecipe(RequestContext req, ResponseContext res) async {
    await requireAuthentication<User>().call(req, res);
    await req.parseBody();

    final result = Recipe.isValidCreate.check(req.bodyAsMap);

    if (result.errors.isEmpty) {
      final recipe = Recipe.fromJson(result.data).copyWith(
        id: Uuid().v4(),
        author: req.user,
        publicVisible: false,
      );
      await recipeRepo.createRecipe(recipe);
      return recipe;
    } else {
      throw ApiError.notProcessable(
        message: "Invalid input data",
        details: result.errors,
      );
    }
  }

  @Expose("/update/:id", method: "PUT")
  Future<Recipe> updateRecipe(RequestContext req, ResponseContext res, String id) async {
    final originRecipe = await getRecipeById(req, res, id);

    await req.parseBody();
    final result = Recipe.isValidCreate.extend(<String, dynamic>{
      "title?": [isNonEmptyString]
    }).check(req.bodyAsMap);

    if (result.errors.isEmpty) {
      final mergedRecipe = originRecipe.toJson()..addAll(result.data);

      final recipe = Recipe.fromJson(mergedRecipe).copyWith(
        id: originRecipe.id,
        author: originRecipe.author,
        publicVisible: originRecipe.publicVisible,
      );
      await recipeRepo.updateRecipe(recipe);
      return recipe;
    } else {
      throw ApiError.notProcessable(
        message: "Invalid update data",
        details: result.errors,
      );
    }
  }

  // TODO(nogipx): Tests required
  @Expose("/delete", method: "DELETE")
  Future deleteRecipe(RequestContext req, ResponseContext res) async {
    await requireAuthentication<User>().call(req, res);
    await req.parseBody();
    final targetDeleteRecipeId = req.bodyAsMap["recipeId"] as String;
    final recipe = await getRecipeById(req, res, targetDeleteRecipeId);
    return recipeRepo.deleteRecipeById(recipe.id);
  }

  @Expose("/get/:id", method: "GET", middleware: [])
  Future<Recipe> getRecipeById(RequestContext req, ResponseContext res, String id) async {
    await requireAuthentication<User>().call(req, res);

    final recipe = await recipeRepo.getRecipeById(id);
    final hasPermission = await requirePermission(req, res,
        throwError: false, permission: AppPermission.editOtherUserRecipePermission);

    if (hasPermission || recipe.publicVisible || recipe.author.id == req.user.id) {
      return recipe;
    } else {
      throw ApiError.forbidden(message: "No access to recipe.");
    }
  }

  @Expose("/get/many/:ids", method: "GET")
  Future<List<Recipe>> getRecipesByIds(
      RequestContext req, ResponseContext res, String ids) async {
    await requireAuthentication<User>().call(req, res);
    final _user = req.user;
    final _ids = ids.split(",").map((e) => e.trim()).toList();

    final hasPermission = await requirePermission(req, res,
        throwError: false, permission: AppPermission.editOtherUserRecipePermission);

    final recipes = hasPermission
        ? await recipeRepo.getRecipesByIds(_ids)
        : (await recipeRepo.getRecipesByIds(_ids))
            .where((e) => e.publicVisible || e.author.id == _user.id)
            .toList();

    if (recipes == null || recipes.isEmpty) {
      throw ApiError.notFound(message: "No recipes found.");
    }
    return recipes;
  }

  /// Returns only authorized user's recipes.
  @Expose("/my", method: "GET")
  Future<List<Recipe>> myRecipes(RequestContext req, ResponseContext res) async {
    await requireAuthentication<User>().call(req, res);
    return recipeRepo.getRecipesByUserId(req.user.id);
  }

  /// Only users with permission can publish recipe.
  @Expose("/publish/:id", method: "PUT")
  Future<Recipe> publishRecipe(RequestContext req, ResponseContext res, String id) async {
    await requirePermission(req, res,
        permission: AppPermission.editOtherUserRecipePermission);
    return await recipeRepo.publishRecipe(id);
  }

  /// Only users with permission can unpublish recipe.
  @Expose("/unpublish/:id", method: "PUT")
  Future<Recipe> unpublishRecipe(
      RequestContext req, ResponseContext res, String id) async {
    await requirePermission(req, res,
        permission: AppPermission.editOtherUserRecipePermission);
    return await recipeRepo.unpublishRecipe(id);
  }

  /// Tags can be added to recipe by author or by moderator.
  @Expose("/:recipeId/addTag/:tagsId", method: "PUT")
  Future addTagsToRecipe(
      RequestContext req, ResponseContext res, String recipeId, String tagsId) async {
    final recipe = await recipeRepo.getRecipeById(recipeId);
    final hasPermission = await requirePermission(req, res,
        throwError: false, permission: AppPermission.editOtherUserRecipePermission);

    if (hasPermission || recipe.id == req.user.id) {
      return await recipeRepo.addTags(tagsId.split(","), recipe.id);
    } else {
      throw ApiError.forbidden(message: "No access to recipe.");
    }
  }

  /// Tags can be removed from recipe by author or by moderator.
  @Expose("/:recipeId/removeTag/:tagsId", method: "PUT")
  Future removeTagsFromRecipe(
      RequestContext req, ResponseContext res, String recipeId, String tagsId) async {
    final recipe = await recipeRepo.getRecipeById(recipeId);
    final hasPermission = await requirePermission(req, res,
        throwError: false, permission: AppPermission.editOtherUserRecipePermission);

    if (hasPermission || recipe.id == req.user.id) {
      return await recipeRepo.removeTags(tagsId.split(","), recipe.id);
    } else {
      throw ApiError.forbidden(message: "No access to recipe.");
    }
  }

  /// Filter is available for all users.
  /// Users with permission will see all recipes by filter.
  /// Users without permission will see only public and their recipes.
  @Expose("/filter/:query", method: "GET")
  Future<List<Recipe>> filter(
      RequestContext req, ResponseContext res, String query) async {
    final filterOption = FilterOption.parse(query);
    final hasPermission = await requirePermission(req, res,
        permission: AppPermission.editOtherUserRecipePermission, throwError: false);
    return await recipeRepo.filterPublicRecipes(
      filterOption: filterOption,
      hasPermission: hasPermission,
      userId: req.user.id,
    );
  }
}

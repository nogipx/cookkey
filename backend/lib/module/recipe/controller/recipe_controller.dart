import 'package:angel_auth/angel_auth.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:backend/module/recipe/export.dart';
import 'package:backend/module/user/repo/export.dart';
import 'package:backend/util/export.dart';
import 'package:sdk/domain.dart';
import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart';
import 'package:angel_validate/angel_validate.dart';

@Expose("/recipe")
class RecipeController extends Controller {
  final UserRepo userRepo;
  final RecipeRepo recipeRepo;

  RecipeController({
    @required this.recipeRepo,
    @required this.userRepo,
  });

  @Expose("/create", method: "POST")
  Future createRecipe(
    RequestContext req,
    ResponseContext res,
  ) async {
    await requireAuthentication<User>().call(req, res);
    await req.parseBody();

    final result = Recipe.isValidInput.check(req.bodyAsMap);

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

  @Expose("/get/:id")
  Future<Recipe> getRecipeById(
    RequestContext req,
    ResponseContext res,
    String id,
  ) async {
    await requireAuthentication<User>().call(req, res);

    final recipe = await recipeRepo.getRecipeById(id);
    if (recipe == null) {
      throw ApiError.notFound(message: "No recipe found.");
    }

    final hasPermission = await requirePermission(req, res,
        throwError: false, permission: UserPermission.moderator());

    if (hasPermission || recipe.publicVisible || recipe.author.id == req.user.id) {
      return recipe;
    } else {
      throw ApiError.forbidden(message: "No access to recipe.");
    }
  }

  @Expose("/get/many/:ids")
  Future<List<Recipe>> getRecipesByIds(
    RequestContext req,
    ResponseContext res,
    String ids,
  ) async {
    await requireAuthentication<User>().call(req, res);
    final _user = req.user;
    final _ids = ids.split(",").map((e) => e.trim()).toList();

    final hasPermission = await requirePermission(req, res,
        throwError: false, permission: UserPermission.moderator());

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

  @Expose("/update/:id", method: "PUT")
  Future<Recipe> updateRecipe(
    RequestContext req,
    ResponseContext res,
    String id,
  ) async {
    final originRecipe = await getRecipeById(req, res, id);

    await req.parseBody();
    final result = Recipe.isValidInput.extend(<String, dynamic>{
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
  Future deleteRecipe(
    RequestContext req,
    ResponseContext res,
  ) async {
    await requireAuthentication<User>().call(req, res);
    await req.parseBody();
    final targetDeleteRecipeId = req.bodyAsMap["recipeId"] as String;
    final recipe = await getRecipeById(req, res, targetDeleteRecipeId);
    return recipeRepo.deleteRecipeById(recipe.id);
  }

  @Expose("/my")
  Future<List<Recipe>> myRecipes(
    RequestContext req,
    ResponseContext res,
  ) async {
    await requireAuthentication<User>().call(req, res);
    return recipeRepo.getRecipesByUserId(req.user.id);
  }

  @Expose("/publish/:id", method: "PUT")
  Future<Recipe> publishRecipe(
    RequestContext req,
    ResponseContext res,
    String id,
  ) async {
    await requirePermission(req, res, permission: UserPermission.moderator());
    return await recipeRepo.publishRecipe(id);
  }

  @Expose("/unpublish/:id", method: "PUT")
  Future<Recipe> unpublishRecipe(
    RequestContext req,
    ResponseContext res,
    String id,
  ) async {
    await requirePermission(req, res, permission: UserPermission.moderator());
    return await recipeRepo.unpublishRecipe(id);
  }

  Future attachTagToRecipe() {}
}

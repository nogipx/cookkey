import 'package:angel_auth/angel_auth.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:backend/module/recipe/controller/validator.dart';
import 'package:backend/module/recipe/export.dart';
import 'package:backend/module/user/repo/user_repo.dart';
import 'package:backend/util/export.dart';
import 'package:sdk/domain.dart';
import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart';

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

    final result = ValidRecipe.isValidInput.check(req.bodyAsMap);

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
      throw ApiError.notFound(message: "Recipe not found.");
    }

    final hasPermission = await requirePermission(req, res,
        throwError: false, permission: UserPermission.moderator());

    if (hasPermission || recipe.publicVisible || recipe.author.id == req.user.id) {
      return recipe;
    } else {
      throw ApiError.forbidden(message: "Cannot access recipe.");
    }
  }

  @Expose("/get/all/:ids")
  Future<List<Recipe>> getRecipeSByIdS(
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
      throw ApiError.notFound(message: "Recipes not found.");
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
    final result = ValidRecipe.isValidInput.check(req.bodyAsMap);

    if (result.errors.isEmpty) {
      final recipe = Recipe.fromJson(result.data).copyWith(
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

  Future attachTagToRecipe() {}
}

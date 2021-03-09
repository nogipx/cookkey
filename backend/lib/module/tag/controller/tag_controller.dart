import 'package:angel_framework/angel_framework.dart';
import 'package:backend/module/recipe/controller/recipe_controller.dart';
import 'package:backend/module/tag/export.dart';
import 'package:meta/meta.dart';
import 'package:backend/module/recipe/export.dart';
import 'package:sdk/sdk.dart';

@Expose("/tag")
class TagController extends Controller {
  final TagControllers tagRepo;
  final RecipeRepo recipeRepo;

  TagController({
    @required this.tagRepo,
    @required this.recipeRepo,
  });

  @Expose("/create", method: "POST")
  Future<RecipeTag> createTag(
    RequestContext req,
    ResponseContext res,
  ) async {
    throw UnimplementedError();
  }

  @Expose("/delete", method: "DELETE")
  Future<RecipeTag> deleteTag(RequestContext req, ResponseContext res) async {
    throw UnimplementedError();
  }

  @Expose("/update/:tagId", method: "PUT")
  Future<RecipeTag> updateTag(
      RequestContext req, ResponseContext res, String tagId) async {
    throw UnimplementedError();
  }

  @Expose("/:id", method: "GET")
  Future<RecipeTag> getTagById(
      RequestContext req, ResponseContext res, String tagId) async {
    throw UnimplementedError();
  }
}

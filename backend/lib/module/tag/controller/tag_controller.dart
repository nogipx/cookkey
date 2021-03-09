import 'package:angel_framework/angel_framework.dart';
import 'package:backend/module/tag/export.dart';
import 'package:backend/util/export.dart';
import 'package:meta/meta.dart';
import 'package:backend/module/recipe/export.dart';
import 'package:sdk/sdk.dart';
import 'package:uuid/uuid.dart';

@Expose("/tag")
class TagController extends Controller {
  final TagRepo tagRepo;
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
    await requirePermission(req, res, permission: UserPermission.admin());
    await req.parseBody();

    final result = RecipeTag.isValidCreate.check(req.bodyAsMap);
    if (result.errors.isEmpty) {
      final tag = RecipeTag.fromJson(<String, dynamic>{
        ...result.data,
        "id": Uuid().v4(),
      });
      return await tagRepo.createTag(tag);
    } else {
      throw ApiError.notProcessable(
        message: "Invalid tag input data.",
        details: result.errors,
      );
    }
  }

  @Expose("/delete", method: "DELETE")
  Future<RecipeTag> deleteTag(RequestContext req, ResponseContext res) async {
    await requirePermission(req, res, permission: UserPermission.admin());
    await req.parseBody();
    final tagId = req.bodyAsMap["tagId"] as String;
    final tag = await getTagById(req, res, tagId);
    await tagRepo.deleteTagById(tag.id);
    return tag;
  }

  @Expose("/update/:tagId", method: "PUT")
  Future<RecipeTag> updateTag(
      RequestContext req, ResponseContext res, String tagId) async {
    await requirePermission(req, res, permission: UserPermission.admin());
    await req.parseBody();

    final result = RecipeTag.isValidCreate.check(req.bodyAsMap);
    if (result.errors.isEmpty) {
      final originTag = await getTagById(req, res, tagId);
      final tag = RecipeTag.fromJson(<String, dynamic>{
        ...result.data,
        "id": originTag.id,
        "isVisible": originTag.isVisible
      });
      return await tagRepo.updateTag(tag);
    } else {
      throw ApiError.notProcessable(
        message: "Invalid tag input data.",
        details: result.errors,
      );
    }
  }

  @Expose("/get/:tagId", method: "GET")
  Future<RecipeTag> getTagById(
      RequestContext req, ResponseContext res, String tagId) async {
    return await tagRepo.getTagById(tagId);
  }

  @Expose("/all", method: "GET")
  Future<List<RecipeTag>> getAllTags(RequestContext req, ResponseContext res) async {
    return await tagRepo.getAllTags();
  }
}

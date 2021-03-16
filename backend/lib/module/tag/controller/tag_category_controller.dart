import 'package:angel_framework/angel_framework.dart';
import 'package:backend/util/log.dart';
import 'package:backend/util/permission.dart';
import 'package:meta/meta.dart';
import 'package:sdk/sdk.dart';
import 'package:uuid/uuid.dart';

@Expose("/tag/category")
class TagCategoryController extends Controller {
  final TagCategoryRepo tagCategoryRepo;
  final TagRepo tagRepo;

  TagCategoryController({
    @required this.tagCategoryRepo,
    @required this.tagRepo,
  });

  @Expose("/create", method: "POST")
  Future<RecipeTagCategory> createTagCategory(
      RequestContext req, ResponseContext res) async {
    await requirePermission(req, res, permission: UserPermission.admin());
    await req.parseBody();

    final result = RecipeTagCategory.isValidCreate.check(req.bodyAsMap);
    if (result.errors.isEmpty) {
      final category = RecipeTagCategory.fromJson(<String, dynamic>{
        ...result.data,
        "id": Uuid().v4(),
      });
      return await tagCategoryRepo.createCategory(category);
    } else {
      throw ApiError.notProcessable(
        message: "Invalid tag input data.",
        details: result.errors,
      );
    }
  }

  @Expose("/update/:id", method: "PUT")
  Future<RecipeTagCategory> updateTagCategory(
      RequestContext req, ResponseContext res, String id) async {
    await requirePermission(req, res, permission: UserPermission.admin());
    await req.parseBody();

    final result = RecipeTagCategory.isValidCreate.check(req.bodyAsMap);
    if (result.errors.isEmpty) {
      final originCategory = await tagCategoryRepo.getCategoryById(id);
      final category = RecipeTagCategory.fromJson(<String, dynamic>{
        ...result.data,
        "id": originCategory.id,
      });
      final linkedTags = await tagRepo.getTagsByCategoryId(category.id);
      final updatedTags = linkedTags.map((e) => e.copyWith(category: category));
      await tagCategoryRepo.updateCategory(category);
      await Future.forEach<RecipeTag>(updatedTags, (tag) async {
        await tagRepo.updateTag(tag);
      }).onError((dynamic error, stackTrace) {
        logError("Error while updating "
            "category(${category.id}, ${category.translationKey})"
            ": $error");
      });
    } else {
      throw ApiError.notProcessable(
        message: "Invalid tag input data.",
        details: result.errors,
      );
    }
  }

  @Expose("/delete", method: "DELETE")
  Future<RecipeTagCategory> deleteTagCategory(
      RequestContext req, ResponseContext res) async {
    await requirePermission(req, res, permission: UserPermission.admin());
    await req.parseBody();
    final categoryId = req.bodyAsMap["categoryId"] as String;
    final category = await tagCategoryRepo.getCategoryById(categoryId);
    final linkedTags = await tagRepo.getTagsByCategoryId(category.id);
    final updatedTags = linkedTags.map((e) => e.copyWithNull(category: true));
    await tagCategoryRepo.deleteCategoryById(category.id);
    await Future.forEach<RecipeTag>(updatedTags, (tag) async {
      await tagRepo.updateTag(tag);
    }).onError((dynamic error, stackTrace) {
      logError("Error while deleting "
          "category(${category.id}, ${category.translationKey})"
          ": $error");
    });
    return category;
  }

  @Expose("/all", method: "GET")
  Future<List<RecipeTagCategory>> getAllCategories(
      RequestContext req, ResponseContext res) async {
    return await tagCategoryRepo.getAllCategories();
  }
}

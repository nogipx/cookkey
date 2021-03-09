import 'package:angel_framework/angel_framework.dart';
import 'package:backend/module/recipe/controller/recipe_controller.dart';
import 'package:backend/module/tag/export.dart';
import 'package:meta/meta.dart';

class TagController extends Controller {
  final TagRepo tagRepo;
  final RecipeController recipeController;

  TagController({
    @required this.tagRepo,
    @required this.recipeController,
  });
}

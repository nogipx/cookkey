import 'package:sdk/domain.dart';

abstract class DiagnosticRepo {
  Future<void> fixTagAtAllRecipes(RecipeTag tag);
}

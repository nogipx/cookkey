import 'package:sdk/domain.dart';
import 'package:angel_validate/angel_validate.dart';

extension ValidRecipe on Recipe {
  static Validator get isValidInput {
    return Validator(<String, dynamic>{
      "title*": [isNonEmptyString],
      "description": [isNonEmptyString],
      "nutritionalValue": [isNotNull, isMap],
      "averageCookTime, portions": [isNotNull, isNum, isNonNegative],
      "publicVisible!, author!, id!": <dynamic>[]
    });
  }
}

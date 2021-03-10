import 'package:sdk/sdk.dart';

const jwtKey = 'tairdtorhtoir';

const userCollection = "user";
const adminCollection = "admins";
const passwordHashCollection = "hash";
const recipeCollection = "recipe";
const tagCollection = "tag";
const tagCategoryCollection = "tag_category";

mixin AppPermission {
  static final editOtherUserRecipePermission = UserPermission.moderator();
}

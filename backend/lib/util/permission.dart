import 'package:angel_auth/angel_auth.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:sdk/domain.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<bool> requirePermission(
  RequestContext req,
  ResponseContext res, {
  UserPermission permission,
  bool throwError = true,
}) async {
  assert(req != null && res != null);
  await requireAuthentication<User>().call(req, res);
  final mongo = req.container.make<Db>();
  if (mongo == null) {
    throw "Database required for cheking permissions";
  }
  final user = req.container.make<User>();
  final userAdminJson =
      await mongo.collection("admins").findOne(where.eq("userId", user.id));

  bool _error([String message]) {
    if (throwError) {
      throw ApiError.forbidden(message: message);
    } else {
      return false;
    }
  }

  if (userAdminJson != null) {
    final permissionJson = await mongo
        .collection("permissions")
        .findOne(where.eq("id", userAdminJson["permissionId"]));
    final userPermission = UserPermission.fromJson(permissionJson);

    if (permission == null || userPermission.canAccess(permission)) {
      return true;
    } else {
      return _error("This action requires higher permission level.");
    }
  } else {
    return _error("This action requires admin permission.");
  }
}

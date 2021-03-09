import 'package:angel_auth/angel_auth.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_validate/angel_validate.dart';
import 'package:backend/module/user/export.dart';
import 'package:backend/util/permission.dart';
import 'package:meta/meta.dart';
import 'package:sdk/domain.dart';

@Expose("/user")
class UserController extends Controller {
  final UserRepo userRepo;

  UserController({
    @required this.userRepo,
  });

  @Expose("/me", method: "GET")
  Future me(RequestContext req, ResponseContext res) async {
    await requireAuthentication<User>().call(req, res);
    final user = req.container.make<User>();
    return await userRepo.getUserById(user.id);
  }

  @Expose("/public/:id", method: "GET")
  Future getPublicUser(RequestContext req, ResponseContext res, String id) async {
    await requirePermission(req, res, permission: UserPermission.blogger());
    final result = Validator(<String, dynamic>{
      "id": isNonEmptyString,
    }).check(req.params);

    return await userRepo.getUserById(result.data['id'] as String) ??
        AngelHttpException.notFound();
  }
}

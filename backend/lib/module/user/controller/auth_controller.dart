import 'dart:convert';

import 'package:angel_auth/angel_auth.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:sdk/domain.dart';
import 'package:meta/meta.dart';

@Expose("/auth")
class AuthController extends Controller {
  final AngelAuth auth;

  AuthController({@required this.auth});

  @Expose("/local", method: "POST")
  Function loginLocal(RequestContext req, ResponseContext res) {
    res.serializer = (dynamic value) {
      final data = value as Map<String, dynamic>;
      return jsonEncode(Auth(
        user: data["data"] as User,
        token: data["token"] as String,
      ).toJson());
    };
    return auth.authenticate("local");
  }

  @Expose("/logout", method: "POST")
  Future logout(RequestContext req, ResponseContext res) async {
    await requireAuthentication<User>().call(req, res);
    auth.logout();
  }
}

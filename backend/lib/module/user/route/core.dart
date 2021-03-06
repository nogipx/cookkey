import 'dart:developer';

import 'package:angel_auth/angel_auth.dart';
import 'package:angel_framework/angel_framework.dart';
import 'package:angel_validate/angel_validate.dart';
import 'package:backend/module/user/repo/export.dart';
import 'package:sdk/domain.dart';
import 'package:meta/meta.dart';

Future<void> configureUserModule({
  @required Angel app,
  @required UserRepo userService,
}) async {
  app.get("user/:id", (req, res) async {
    await requireAuthentication<User>().call(req, res);
    final user = req.container.make<User>();
    log(user.id);
    final result = Validator(<String, dynamic>{
      "id": isNonEmptyString,
    }).check(<String, dynamic>{
      "id": req.params['id'],
    });

    return await userService.getUser(result.data['id'] as String);
  });
}

import 'package:angel_framework/angel_framework.dart';
import 'package:sdk/sdk.dart';

extension ExtRequestContext on RequestContext {
  Future<Map<String, dynamic>> requireBody() async {
    if (contentType == null) {
      throw ApiError.badRequest(message: "Missing content-type header.");
    }
    await parseBody();
    return bodyAsMap;
  }

  User get user {
    try {
      return container.make<User>();
    } catch (e) {
      return null;
    }
  }
}

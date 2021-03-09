import 'package:backend/module/user/repo/export.dart';
import 'package:sdk/domain.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:meta/meta.dart';
import 'package:backend/util/export.dart';

class ImplMongoUserRepo implements UserRepo {
  final Db mongo;

  const ImplMongoUserRepo({@required this.mongo});

  static const userCollection = "user";

  @override
  Future<User> getUserById(String id) async {
    final json = await mongo.collection(userCollection).findOne(where.eq("id", id));
    return json.deserialize<User>((json) => User.fromJson(json));
  }

  @override
  Future<User> getUserByUsername(String username) async {
    final json =
        await mongo.collection(userCollection).findOne(where.eq("username", username));
    return json.deserialize((json) => User.fromJson(json));
  }

  @override
  Future<User> findUserByCredentials({
    String username,
    String password,
  }) async {
    final creds = AuthCredentials(username, password);

    final json = await mongo.collection("hash").findOne(where.eq("username", username));
    if (json == null) {
      throw ApiError.notFound(
        message: "Credentials not found",
      );
    }

    if (creds.passwordHash == json["passwordHash"]) {
      return await getUserByUsername(username);
    } else {
      throw ApiError.forbidden(
        message: "Incorrect credentials",
      );
    }
  }

  @override
  Future<UserPermission> getPermission({
    @required String userId,
  }) async {
    final userAdminJson =
        await mongo.collection("admins").findOne(where.eq("userId", userId));

    if (userAdminJson != null) {
      return UserPermission.fromJson(userAdminJson);
    } else {
      return UserPermission.regular();
    }
  }
}

import 'package:backend/module/user/repo/export.dart';
import 'package:sdk/domain.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:meta/meta.dart';

class ImplMongoUserRepo implements UserRepo {
  final Db mongo;

  ImplMongoUserRepo({@required this.mongo});

  static const userCollection = "user";

  @override
  Future<User> getUserById(String id) async {
    final json = await mongo.collection(userCollection).findOne(where.eq("id", id));
    if (json != null) {
      return User.fromJson(json);
    } else {
      throw ApiError.notFound(
        message: "User not found.",
      );
    }
  }

  @override
  Future<User> getUserByUsername(String username) async {
    final json =
        await mongo.collection(userCollection).findOne(where.eq("username", username));
    if (json != null) {
      return User.fromJson(json);
    } else {
      throw ApiError.notFound(
        message: "User '$username' not found.",
      );
    }
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
}

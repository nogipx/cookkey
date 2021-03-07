import 'package:backend/module/user/repo/export.dart';
import 'package:sdk/domain.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:meta/meta.dart';

class ImplMongoUserRepo implements UserRepo {
  final Db mongo;

  ImplMongoUserRepo({@required this.mongo});

  static const collection = "user";

  @override
  Future<User> getUserById(String id) async {
    final json = await mongo.collection(collection).findOne(where.eq("id", id));
    final user = User.fromJson(json);
    return user;
  }

  @override
  Future<User> findUserByCredentials({
    String username,
    String hashPassword,
  }) async {
    final userJson =
        await mongo.collection("hash").findOne(where.eq("username", username));
  }
}

import 'package:sdk/domain.dart';
import 'package:sdk/sdk.dart';

class ImplTestUserRepo implements UserRepo {
  @override
  Future<User> getUserById(String id) async {
    final users = [
      User(id: "qwfpgj", name: "test1"),
      User(id: "arstdh", name: "test2"),
      User(id: "zxcvbk", name: "test3"),
    ];
    return users.singleWhere(
      (e) => e.id == id,
      orElse: () => null,
    );
  }

  @override
  Future<User> findUserByCredentials({
    String username,
    String password,
  }) async {
    if (username == "test1" && password == "1111") {
      return User(id: "qwfpgj", name: "test1");
    } else if (username == "test2" && password == "2222") {
      return User(id: "arstdh", name: "test2");
    } else {
      return null;
    }
  }

  @override
  Future<User> getUserByUsername(String username) {
    // TODO: implement getUserByUsername
    throw UnimplementedError();
  }

  @override
  Future<UserPermission> getPermission(String userId) {
    // TODO: implement getPermission
    throw UnimplementedError();
  }
}

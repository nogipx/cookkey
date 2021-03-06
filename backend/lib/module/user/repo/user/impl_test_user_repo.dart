import 'package:backend/module/user/repo/export.dart';
import 'package:sdk/domain.dart';

class ImplTestUserRepo implements UserRepo {
  @override
  Future<User> getUser(String id) async {
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
    String hashPassword,
  }) async {
    if (username == "test1" && hashPassword == "1111") {
      return User(id: "qwfpgj", name: "test1");
    } else if (username == "test2" && hashPassword == "2222") {
      return User(id: "arstdh", name: "test2");
    } else {
      return null;
    }
  }
}

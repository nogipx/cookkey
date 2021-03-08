import 'package:sdk/domain.dart';
import 'package:meta/meta.dart';

abstract class UserRepo {
  Future<User> getUserById(String id);

  Future<User> getUserByUsername(String username);

  Future<User> findUserByCredentials({
    String username,
    String password,
  });

  Future<UserPermission> getPermission({@required String userId});
}

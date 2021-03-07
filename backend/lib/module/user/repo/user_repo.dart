import 'package:sdk/domain.dart';

abstract class UserRepo {
  Future<User> getUserById(String id);

  Future<User> getUserByUsername(String username);

  Future<User> findUserByCredentials({
    String username,
    String password,
  });
}

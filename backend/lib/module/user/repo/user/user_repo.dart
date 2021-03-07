import 'package:sdk/domain.dart';

abstract class UserRepo {
  Future<User> getUserById(String id);

  Future<User> findUserByCredentials({
    String username,
    String hashPassword,
  });
}

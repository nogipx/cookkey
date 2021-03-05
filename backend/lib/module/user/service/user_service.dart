import 'package:domain/domain.dart';

abstract class UserService {
  Future<User> getUser(String id);

  Future<User> findUserByCredentials({
    String username,
    String hashPassword,
  });
}

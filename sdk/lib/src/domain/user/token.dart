abstract class TokenProvider {
  Future<String> get token;

  void setToken(String token);
}

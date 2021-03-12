import 'package:cookkey/util/response_processing.dart';
import 'package:dio/dio.dart';
import 'package:sdk/sdk.dart';
import 'package:meta/meta.dart';

class AuthRepo with EasyRequest {
  final Dio dio;

  const AuthRepo({@required this.dio});

  Future<Auth> login(AuthCredentials credentials) {
    return request<Auth, Map>(
      onResult: (json) => Auth.fromJson(json as Map<String, dynamic>),
      requestProvider: () => dio.post<Map>("/auth/local", data: credentials.toJson()),
    );
  }

  Future<void> logout() {
    return request<void, void>(
      requestProvider: () => dio.post<void>("/auth/logout"),
    );
  }
}

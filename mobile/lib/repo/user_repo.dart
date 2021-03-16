import 'package:cookkey/util/response_processing.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sdk/domain.dart';
import 'package:sdk/repo.dart';

class UserRepoImpl with EasyRequest implements UserRepo {
  final Dio dio;

  const UserRepoImpl({@required this.dio});

  @override
  @protected
  Future<User> findUserByCredentials({String username, String password}) {
    throw UnimplementedError();
  }

  @override
  Future<UserPermission> getPermission(String userId) {
    return request<UserPermission, Map>(
      onResult: (json) => UserPermission.fromJson(json as Map<String, dynamic>),
      requestProvider: () => dio.get<Map>("/user/me/permission"),
    );
  }

  @override
  Future<User> getUserById(String id) {
    return request<User, Map>(
      onResult: (json) => User.fromJson(json as Map<String, dynamic>),
      requestProvider: () => dio.get<Map>("/user/public/$id"),
    );
  }

  Future<User> getMe() {
    return request<User, Map>(
      onResult: (json) => User.fromJson(json as Map<String, dynamic>),
      requestProvider: () => dio.get<Map>("/user/me"),
    );
  }

  @override
  @protected
  Future<User> getUserByUsername(String username) {
    throw UnimplementedError();
  }
}

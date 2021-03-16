// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) {
  return Auth(
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };

AuthCredentials _$AuthCredentialsFromJson(Map<String, dynamic> json) {
  return AuthCredentials(
    json['username'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$AuthCredentialsToJson(AuthCredentials instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    username: json['username'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
    };

UserPermission _$UserPermissionFromJson(Map<String, dynamic> json) {
  return UserPermission(
    id: json['id'] as String,
    level: json['level'] as int,
    description: json['description'] as String,
    translationKey: json['translationKey'] as String,
  );
}

Map<String, dynamic> _$UserPermissionToJson(UserPermission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'description': instance.description,
      'translationKey': instance.translationKey,
    };

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String name;
  final String username;
  final String email;

  const User({
    this.id,
    this.username,
    this.name,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserPermission extends Equatable {
  final String id;
  final int level;
  final String description;
  final String translationKey;

  const UserPermission({
    this.id,
    this.level = 0,
    this.description,
    this.translationKey,
  });

  @override
  List<Object> get props => [level];

  factory UserPermission.fromJson(Map<String, dynamic> json) =>
      _$UserPermissionFromJson(json);
  Map<String, dynamic> toJson() => _$UserPermissionToJson(this);

  factory UserPermission.level1() => UserPermission(level: 1);

  bool canAccess(UserPermission other) => level >= other.level;
}

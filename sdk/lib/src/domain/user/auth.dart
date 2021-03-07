import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sdk/src/domain/user/export.dart';
import 'package:crypto/crypto.dart';

part 'auth.g.dart';

@JsonSerializable()
class Auth {
  final User user;
  final String token;

  const Auth({this.user, this.token});

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
  Map<String, dynamic> toJson() => _$AuthToJson(this);
}

@JsonSerializable()
// ignore: must_be_immutable
class AuthCredentials extends Equatable {
  final String username;
  final String password;
  String _hash;
  String get passwordHash => _hash;

  AuthCredentials(this.username, this.password) {
    _hash = md5.convert([password.hashCode, username.hashCode]).toString();
  }

  factory AuthCredentials.fromJson(Map<String, dynamic> json) =>
      _$AuthCredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$AuthCredentialsToJson(this);

  @override
  List<Object> get props => [username, password, passwordHash];
}

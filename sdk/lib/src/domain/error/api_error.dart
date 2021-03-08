import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'api_error.g.dart';

@JsonSerializable()
class ApiError extends Equatable {
  final int statusCode;
  final String message;
  final String translationKey;
  final List<String> details;

  const ApiError({
    @required this.statusCode,
    @required this.message,
    this.translationKey,
    this.details,
  });

  @override
  List<Object> get props => [statusCode, message, translationKey];

  factory ApiError.fromJson(Map<String, dynamic> json) => _$ApiErrorFromJson(json);
  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);

  factory ApiError.badRequest({
    String message = '400 Bad Request',
    String translationKey,
    List<String> details,
  }) =>
      ApiError(
        message: message,
        statusCode: 400,
        translationKey: translationKey,
        details: details,
      );

  /// Throws a 401 Not Authenticated error.
  factory ApiError.notAuthenticated({
    String message = '401 Not Authenticated',
    String translationKey,
    List<String> details,
  }) =>
      ApiError(
        message: message,
        statusCode: 401,
        translationKey: translationKey,
        details: details,
      );

  /// Throws a 402 Payment Required error.
  factory ApiError.paymentRequired({
    String message = '402 Payment Required',
    String translationKey,
    List<String> details,
  }) =>
      ApiError(
        message: message,
        statusCode: 402,
        translationKey: translationKey,
        details: details,
      );

  /// Throws a 403 Forbidden error.
  factory ApiError.forbidden({
    String message = '403 Forbidden',
    String translationKey,
    List<String> details,
  }) =>
      ApiError(
        message: message,
        statusCode: 403,
        translationKey: translationKey,
        details: details,
      );

  /// Throws a 404 Not Found error.
  factory ApiError.notFound({
    String message = '404 Not Found',
    String translationKey,
    List<String> details,
  }) =>
      ApiError(
        message: message,
        statusCode: 404,
        translationKey: translationKey,
        details: details,
      );

  /// Throws a 405 Method Not Allowed error.
  factory ApiError.methodNotAllowed({
    String message = '405 Method Not Allowed',
    String translationKey,
    List<String> details,
  }) =>
      ApiError(
        message: message,
        statusCode: 405,
        translationKey: translationKey,
        details: details,
      );

  /// Throws a 406 Not Acceptable error.
  factory ApiError.notAcceptable({
    String message = '406 Not Acceptable',
    String translationKey,
    List<String> details,
  }) =>
      ApiError(
        message: message,
        statusCode: 406,
        translationKey: translationKey,
        details: details,
      );

  /// Throws a 408 Timeout error.
  factory ApiError.methodTimeout({
    String message = '408 Timeout',
    String translationKey,
    List<String> details,
  }) =>
      ApiError(
        message: message,
        statusCode: 408,
        translationKey: translationKey,
        details: details,
      );

  /// Throws a 409 Conflict error.
  factory ApiError.conflict({
    String message = '409 Conflict',
    String translationKey,
    List<String> details,
  }) =>
      ApiError(
        message: message,
        statusCode: 409,
        translationKey: translationKey,
        details: details,
      );

  /// Throws a 422 Not Processable error.
  factory ApiError.notProcessable({
    String message = '422 Not Processable',
    String translationKey,
    List<String> details,
  }) =>
      ApiError(
        message: message,
        statusCode: 422,
        translationKey: translationKey,
        details: details,
      );

  /// Throws a 501 Not Implemented error.
  factory ApiError.notImplemented({
    String message = '501 Not Implemented',
    String translationKey,
    List<String> details,
  }) =>
      ApiError(
        message: message,
        statusCode: 501,
        translationKey: translationKey,
        details: details,
      );

  /// Throws a 503 Unavailable error.
  factory ApiError.unavailable({
    String message = '503 Unavailable',
    String translationKey,
    List<String> details,
  }) =>
      ApiError(
        message: message,
        statusCode: 503,
        translationKey: translationKey,
        details: details,
      );
}

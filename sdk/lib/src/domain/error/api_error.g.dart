// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) {
  return ApiError(
    statusCode: json['statusCode'] as int,
    message: json['message'] as String,
    translationKey: json['translationKey'] as String,
  );
}

Map<String, dynamic> _$ApiErrorToJson(ApiError instance) => <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'translationKey': instance.translationKey,
    };

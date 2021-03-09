import 'package:sdk/domain.dart';

extension DeserializeMap on Map<String, dynamic> {
  T deserialize<T>(
    T Function(Map<String, dynamic> json) deserializer, {
    String errorMessage,
  }) {
    if (this != null) {
      return deserializer(this);
    } else {
      throw ApiError.notFound(
        message: errorMessage ?? "No $T found",
      );
    }
  }
}

extension DeserializeList on Stream<Map<String, dynamic>> {
  Stream<T> deserialize<T>(
    T Function(Map<String, dynamic> json) deserializer, {
    String errorMessage,
  }) {
    if (this != null) {
      return map((e) => deserializer(e));
    } else {
      throw ApiError.notFound(
        message: errorMessage ?? "No $T collection found.",
      );
    }
  }
}
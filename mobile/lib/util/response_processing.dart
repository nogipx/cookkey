import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sdk/sdk.dart';
import 'package:meta/meta.dart';
import 'package:retry/retry.dart';

mixin EasyRequest {
  /// [T] - Data return type.
  /// [JT] - Json expected type, Map or List.
  Future<T> request<T, JT>({
    @required final Future<Response> Function() requestProvider,
    final T Function(JT json) onResult,
    final T Function(Response response) onRawResult,
    final T Function() onEmptyBody,
    final T Function() onCachedResponse,
    final bool isRetryAllowed = true,
    final Function() onRetry,
    Duration timeout,
  }) async {
    assert(requestProvider != null);
    timeout = timeout ?? Duration(seconds: 5000);

    final response = await retry<Response>(
      () => requestProvider().timeout(timeout),
      maxAttempts: 2,
      retryIf: (e) => isRetryAllowed && e is SocketException || e is TimeoutException,
      onRetry: (Exception e) => onRetry?.call(),
    );

    return response.process<T, JT>(
      isRetryAllowed: isRetryAllowed,
      onResult: onResult,
      onRawResult: onRawResult,
      onEmptyBody: onEmptyBody,
      onCachedResponse: onCachedResponse,
    );
  }
}

extension ResponseExt on Response {
  Future<T> process<T, JT>({
    bool isRetryAllowed = true,
    T Function(JT json) onResult,
    T Function(Response response) onRawResult,
    T Function() onEmptyBody,
    T Function() onCachedResponse,
  }) async {
    assert(
      onRawResult == null ||
          (onRawResult != null &&
              onResult == null &&
              onCachedResponse == null &&
              onEmptyBody == null),
      'onRawResult should be single result processor',
    );

    if (data is ApiError) {
      throw data;
    } else {
      T result;

      if (onRawResult != null) {
        result = onRawResult?.call(this);
      } else if (data == null) {
        result = onEmptyBody?.call();
      } else {
        if (data is! JT) {
          throw ApiError.internalError(
            message: "Received json type '${data.runtimeType}' is not expected '$JT'"
                "\nRequest: ${request.path} \nResponse: $data\n",
          );
        }
        result = onResult?.call(data as JT);
      }

      if (result is Future) {
        throw 'WARNING: Handle response callback is async but has to be sync';
      }

      if (result != null && result is! T) {
        throw 'WARNING: Handle response callback should return $T '
            'but returns ${result.runtimeType}';
      }

      return result;
    }
  }
}

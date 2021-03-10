import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sdk/sdk.dart';
import 'package:meta/meta.dart';
import 'package:retry/retry.dart';

mixin EasyRequest {
  Future<T> request<T>({
    @required final Future<Response> Function() requestProvider,
    final T Function(dynamic json) onResult,
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

    return response.process<T>(
      isRetryAllowed: isRetryAllowed,
      onResult: onResult,
      onRawResult: onRawResult,
      onEmptyBody: onEmptyBody,
      onCachedResponse: onCachedResponse,
    );
  }
}

extension ResponseExt on Response {
  Future<T> process<T>({
    bool isRetryAllowed = true,
    T Function(dynamic json) onResult,
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
        result = onRawResult.call(this);
      } else {
        result = data != null ? onResult?.call(data) : onEmptyBody?.call();
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

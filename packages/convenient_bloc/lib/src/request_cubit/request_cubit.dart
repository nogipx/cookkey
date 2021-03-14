import 'dart:async';
import 'dart:developer' as dev show log;

import 'package:bloc/bloc.dart';

import 'export.dart';

class RequestCubit<Value, Error> extends Cubit<RequestState<Value>> {
  final Future<Value> Function() request;
  void Function(Error error) onRequestError;

  RequestCubit(
    this.request, {
    Value initial,
    this.onRequestError,
  }) : super(RequestInitial(initial));

  RequestState<Value> get result => state;

  Future<Value> call() async {
    try {
      emit(RequestInProgress<Value>());
      final Value _result = await request();
      emit(RequestSuccess(_result));
      return _result;
    } catch (e, stackTrace) {
      onError(e, stackTrace);
      return null;
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    dynamic _error = error;
    if (_error is Error) {
      emit(RequestFailure<Value, Error>(_error, stackTrace: stackTrace));
      onRequestError(_error);
    }
    if (onRequestError == null) {
      dev.log(
        _error.toString(),
        name: runtimeType.toString(),
        stackTrace: stackTrace,
      );
    }
    super.onError(error, stackTrace);
  }
}

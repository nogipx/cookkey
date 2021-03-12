import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:convenient_bloc/convenient_bloc.dart';
import 'package:dio/dio.dart';
import 'package:sdk/domain.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State>
    with BlocMapping<Event, State> {
  BaseBloc(State initialState) : super(initialState) {
    mapEvents();
  }

  State mapError(ApiError error, Event event);

  @override
  State mapErrorToState(dynamic error, StackTrace stackTrace, Event event) {
    final _error = (error as DioError).error as ApiError;
    logError(_error, stackTrace: stackTrace);
    return mapError?.call(_error, event);
  }
}

void logError(
  dynamic error, {
  StackTrace stackTrace,
  String name = '',
  String message,
  bool sendSentry = false,
  String errorType = 'uncategorized',
}) {
  dev.log(
    error.toString().color([ansiRedBg, ansiWhite]),
    stackTrace: stackTrace,
    name: name != null && name.isNotEmpty ? name : "ERROR: ${error.runtimeType}",
  );
}

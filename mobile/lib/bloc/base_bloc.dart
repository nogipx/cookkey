import 'package:convenient_bloc/convenient_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:sdk/domain.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State>
    with BlocMapping<Event, State> {
  BaseBloc(State initialState) : super(initialState) {
    mapEvents();
  }

  State mapError(ApiError error, Event event);

  @override
  State mapErrorToState(dynamic error, StackTrace stackTrace, Event event) {
    return mapError?.call(error as ApiError, event);
  }
}

import 'dart:async';
import 'package:bloc/bloc.dart';
import '../convenient_bloc.dart';

mixin BlocMapping<Event, State> implements Bloc<Event, State> {
  Map<Type, Function> _mappers;

  /// Maps event type to handler function.
  /// Should be called when bloc is creating.
  void mapEvents();

  /// Maps error happened in bloc to state.
  State mapErrorToState(dynamic error, StackTrace stackTrace, Event event);

  void mapEvent<T extends Event>(Function mapper) {
    _mappers ??= {};
    _mappers[T] = mapper;
  }

  @override
  Stream<State> mapEventToState(Event event) async* {
    if (_mappers == null || _mappers.isEmpty) {
      throw Exception("[$runtimeType] Event mapping is empty. May be mapEvent() was not called.");
    }

    dynamic state;
    if (_mappers.containsKey(event.runtimeType)) {
      if (_mappers[event.runtimeType] == null) {
        throw Exception("Mapper for $event can not be null.");
      }

      state = _mappers[event.runtimeType].call(event);

      if (state == null) {
        throw Exception("Mapper for $event did not produce any state.");
      }

      if (state is Stream<State>) {
        yield* state?.transformErrorToState((error, stackTrace) {
          return mapErrorToState?.call(error, stackTrace, event);
        });
      } else if (state is State) {
        yield state;
      }
    } else {
      final ex = Exception("Mapper for $event did not found.");
      yield mapErrorToState?.call(ex, null, event);
      throw ex;
    }
  }
}

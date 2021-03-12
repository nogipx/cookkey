import 'package:bloc/bloc.dart';
import 'package:convenient_bloc/convenient_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState>
    with BlocMapping<FeedbackEvent, FeedbackState> {
  FeedbackBloc() : super(null) {
    mapEvents();
  }

  @override
  FeedbackState mapErrorToState(
      dynamic error, StackTrace stackTrace, FeedbackEvent event) {
    return FeedbackState(error.toString());
  }

  @override
  void mapEvents() {
    mapEvent<FeedbackEvent>(_mapFeedback);
  }

  void push<T>([String message = 'Error happened']) {
    add(FeedbackEvent(message, T.toString()));
  }

  @override
  Stream<Transition<FeedbackEvent, FeedbackState>> transformEvents(
      Stream<FeedbackEvent> events, transitionFn) {
    return events.debounceTime(const Duration(milliseconds: 200)).switchMap(transitionFn);
  }

  Stream<FeedbackState> _mapFeedback(FeedbackEvent event) async* {
    yield FeedbackState(event.message);
  }
}

class FeedbackEvent extends Equatable {
  final String message;
  final String key;

  const FeedbackEvent(this.message, this.key);

  @override
  List<Object> get props => [key, message];
}

class FeedbackState {
  final String message;

  FeedbackState(this.message);
}

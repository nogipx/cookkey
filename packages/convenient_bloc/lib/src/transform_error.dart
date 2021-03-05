import 'dart:async';

extension ErrorToEventStream on Stream {
  Stream<T> transformErrorToState<T>(T Function(Object error, StackTrace stackTrace) handleError) {
    if (this == null) {
      throw handleError(
        "Error: The stream for " +
            T.toString() +
            " state has been asked to process error. Please confirm the event has been processed in the bloc.",
        null,
      );
    } else {
      return transform(
        StreamTransformer<T, T>.fromHandlers(
          handleData: (data, sink) => sink.add(data),
          handleDone: (sink) => sink.close(),
          handleError: (error, stackTrace, sink) => sink.add(handleError(error, stackTrace)),
        ),
      );
    }
  }
}

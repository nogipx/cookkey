abstract class RequestState<T> {
  const RequestState();
}

class RequestInProgress<T> extends RequestState<T> {}

class RequestSuccess<T> extends RequestState<T> {
  final T result;
  const RequestSuccess(this.result);
}

class RequestFailure<T, E> extends RequestState<T> {
  final E error;
  final StackTrace stackTrace;
  const RequestFailure(this.error, {this.stackTrace});
}

class RequestInitial<T> extends RequestState<T> {
  final T value;
  const RequestInitial(this.value);
}

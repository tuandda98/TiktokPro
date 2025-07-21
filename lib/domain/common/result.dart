sealed class Result<T, E> {
  const Result();
}

class Success<T, E> extends Result<T, E> {
  final T data;
  const Success(this.data);
}

class Error<T, E> extends Result<T, E> {
  final E error;
  const Error(this.error);
}
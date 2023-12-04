/// Base Result class
/// [S] represents the type of the success value
/// [E] should be [Exception] or a subclass of it
abstract class Result<S, E extends Exception> {
  const Result();
}

class Success<S, E extends Exception> extends Result<S, E> {
  const Success(this.data);
  final S data;
}

class Failure<S, E extends Exception> extends Result<S, E> {
  const Failure(this.exception);
  final E exception;
}

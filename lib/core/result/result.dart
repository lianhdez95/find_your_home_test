/// Resultado genérico al estilo Either para modelar éxito/fracaso.
///
/// Ok(value) representa éxito con valor de tipo T.
/// Err(error) representa fallo con error de tipo E.
abstract class Result<T, E> {
  const Result();

  R fold<R>({required R Function(E e) onErr, required R Function(T v) onOk});

  Result<U, E> map<U>(U Function(T v) f) =>
      fold(onErr: (e) => Err<U, E>(e), onOk: (v) => Ok<U, E>(f(v)));

  Result<T, F> mapErr<F>(F Function(E e) f) =>
      fold(onErr: (e) => Err<T, F>(f(e)), onOk: (v) => Ok<T, F>(v));

  Result<U, E> andThen<U>(Result<U, E> Function(T v) f) =>
      fold(onErr: (e) => Err<U, E>(e), onOk: (v) => f(v));
}

class Ok<T, E> extends Result<T, E> {
  final T value;
  const Ok(this.value);

  @override
  R fold<R>({required R Function(E e) onErr, required R Function(T v) onOk}) => onOk(value);
}

class Err<T, E> extends Result<T, E> {
  final E error;
  const Err(this.error);

  @override
  R fold<R>({required R Function(E e) onErr, required R Function(T v) onOk}) => onErr(error);
}

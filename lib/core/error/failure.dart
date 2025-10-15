abstract class Failure {
  final String code;
  final String? message;
  final int? statusCode;
  const Failure(this.code, {this.message, this.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure({String? message}) : super('network', message: message);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({String? message}) : super('timeout', message: message);
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({String? message, int? statusCode}) : super('bad_request', message: message, statusCode: statusCode);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({String? message, int? statusCode}) : super('unauthorized', message: message, statusCode: statusCode);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({String? message, int? statusCode}) : super('not_found', message: message, statusCode: statusCode);
}

class ServerFailure extends Failure {
  const ServerFailure({String? message, int? statusCode}) : super('server_error', message: message, statusCode: statusCode);
}

class UnknownFailure extends Failure {
  const UnknownFailure({String? message, int? statusCode}) : super('unknown', message: message, statusCode: statusCode);
}

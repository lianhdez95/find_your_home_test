import 'package:dio/dio.dart';
import 'package:find_your_home_test/core/error/failure.dart';

Failure mapDioToFailure(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      return const TimeoutFailure(message: 'Request timeout');
    case DioExceptionType.badResponse:
      final status = e.response?.statusCode;
      final msg = e.response?.statusMessage ?? e.message;
      if (status == 400) return BadRequestFailure(message: msg, statusCode: status);
      if (status == 401 || status == 403) return UnauthorizedFailure(message: msg, statusCode: status);
      if (status == 404) return NotFoundFailure(message: msg, statusCode: status);
      if (status != null && status >= 500) return ServerFailure(message: msg, statusCode: status);
      return UnknownFailure(message: msg, statusCode: status);
    case DioExceptionType.connectionError:
      return const NetworkFailure(message: 'Network error');
    case DioExceptionType.cancel:
    case DioExceptionType.unknown:
    default:
      return UnknownFailure(message: e.message);
  }
}

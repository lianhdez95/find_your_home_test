import 'dart:async';

import 'package:dio/dio.dart';
import 'package:find_your_home_test/core/env/strings.dart';

/// Provee tokens (p.ej. bearer) si aplica. Puedes implementar y registrar uno real en DI.
abstract class TokenProvider {
	FutureOr<String?> getAccessToken();
}

class DioClient {
	final Dio _dio;
	final TokenProvider? _tokenProvider;

	DioClient({Dio? dio, TokenProvider? tokenProvider})
			: _dio = dio ?? Dio(),
				_tokenProvider = tokenProvider {
		_setupBaseOptions();
		_setupInterceptors();
	}

	Dio get raw => _dio;

	void _setupBaseOptions() {
		final apiUrl = baseUrl ?? '';
		_dio.options = BaseOptions(
			baseUrl: apiUrl,
			connectTimeout: const Duration(seconds: 15),
			receiveTimeout: const Duration(seconds: 20),
			sendTimeout: const Duration(seconds: 20),
			headers: {
				'Content-Type': 'application/json',
				'Accept': 'application/json',
			},
		);
	}

	void _setupInterceptors() {
		_dio.interceptors.add(InterceptorsWrapper(
			onRequest: (options, handler) async {
				// Adjuntamos token si existe
				final token = await _tokenProvider?.getAccessToken();
				if (token != null && token.isNotEmpty) {
					options.headers['Authorization'] = 'Bearer $token';
				}
				handler.next(options);
			},
			onError: (e, handler) {
				// Normaliza errores
				handler.next(_mapError(e));
			},
		));
	}

	DioException _mapError(DioException e) {
		if (e.type == DioExceptionType.connectionTimeout ||
				e.type == DioExceptionType.sendTimeout ||
				e.type == DioExceptionType.receiveTimeout) {
			return DioException(requestOptions: e.requestOptions, error: 'timeout', type: DioExceptionType.connectionTimeout);
		}
		if (e.type == DioExceptionType.badResponse) {
			// Puedes mapear códigos específicos si lo deseas
			return DioException(requestOptions: e.requestOptions, response: e.response, type: DioExceptionType.badResponse);
		}
		return e; // Por defecto, propagamos el original
	}

	// Helpers HTTP genéricos
	Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParams, Options? options, CancelToken? cancelToken}) {
		return _dio.get<T>(path, queryParameters: queryParams, options: options, cancelToken: cancelToken);
	}

	Future<Response<T>> post<T>(String path, {Object? data, Map<String, dynamic>? queryParams, Options? options, CancelToken? cancelToken}) {
		return _dio.post<T>(path, data: data, queryParameters: queryParams, options: options, cancelToken: cancelToken);
	}

	Future<Response<T>> put<T>(String path, {Object? data, Map<String, dynamic>? queryParams, Options? options, CancelToken? cancelToken}) {
		return _dio.put<T>(path, data: data, queryParameters: queryParams, options: options, cancelToken: cancelToken);
	}

	Future<Response<T>> patch<T>(String path, {Object? data, Map<String, dynamic>? queryParams, Options? options, CancelToken? cancelToken}) {
		return _dio.patch<T>(path, data: data, queryParameters: queryParams, options: options, cancelToken: cancelToken);
	}

	Future<Response<T>> delete<T>(String path, {Object? data, Map<String, dynamic>? queryParams, Options? options, CancelToken? cancelToken}) {
		return _dio.delete<T>(path, data: data, queryParameters: queryParams, options: options, cancelToken: cancelToken);
	}
}

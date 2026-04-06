import 'package:dio/dio.dart';
import 'api_endpoints.dart';

class DioClient {
  DioClient._();

  static Dio? _instance;

  static Dio get instance {
    _instance ??= _createDio();
    return _instance!;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      _LogInterceptor(),
      _ErrorInterceptor(),
    ]);

    return dio;
  }
}

class _LogInterceptor extends Interceptor {}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final appException = _mapDioException(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: appException,
        type: err.type,
        response: err.response,
      ),
    );
  }

  AppException _mapDioException(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const AppException.timeout();
      case DioExceptionType.connectionError:
        return const AppException.noInternet();
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode ?? 0;
        if (statusCode >= 500) {
          return AppException.server(statusCode);
        }
        return AppException.api(statusCode, err.response?.statusMessage ?? '');
      default:
        return const AppException.unknown();
    }
  }
}

sealed class AppException {
  const AppException();

  const factory AppException.timeout() = _TimeoutException;
  const factory AppException.noInternet() = _NoInternetException;
  const factory AppException.server(int statusCode) = _ServerException;
  const factory AppException.api(int statusCode, String message) =
      _ApiException;
  const factory AppException.unknown() = _UnknownException;

  String get message;
}

final class _TimeoutException extends AppException {
  const _TimeoutException();

  @override
  String get message => 'Connection timed out. Please try again.';
}

final class _NoInternetException extends AppException {
  const _NoInternetException();

  @override
  String get message => 'No internet connection.';
}

final class _ServerException extends AppException {
  final int statusCode;
  const _ServerException(this.statusCode);

  @override
  String get message => 'Server error ($statusCode). Please try again later.';
}

final class _ApiException extends AppException {
  final int statusCode;
  final String _msg;
  const _ApiException(this.statusCode, this._msg);

  @override
  String get message => _msg.isNotEmpty ? _msg : 'An error occurred.';
}

final class _UnknownException extends AppException {
  const _UnknownException();

  @override
  String get message => 'An unexpected error occurred.';
}

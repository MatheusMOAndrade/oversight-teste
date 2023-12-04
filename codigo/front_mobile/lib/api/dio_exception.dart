import 'dart:io' show SocketException;
import '../utils/error_string.dart';
import 'package:dio/dio.dart' show DioException, DioExceptionType;

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        message = ErrorString.cancelRequest;
        break;
      case DioExceptionType.connectionTimeout:
        message = ErrorString.connectionTimeOut;
        break;
      case DioExceptionType.receiveTimeout:
        message = ErrorString.receiveTimeOut;
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioException.response?.statusCode,
          dioException.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = ErrorString.sendTimeOut;
        break;
      case DioExceptionType.unknown:
        if (dioException.error is SocketException) {
          message = ErrorString.socketException;
          break;
        }
        message = ErrorString.unexpectedError;
        break;
      default:
        message = ErrorString.unknownError;
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return ErrorString.badRequest;
      case 401:
        return ErrorString.unauthorized;
      case 403:
        return ErrorString.forbidden;
      case 404:
        return ErrorString.notFound;
      case 422:
        return ErrorString.duplicateEmail;
      case 500:
        return ErrorString.internalServerError;
      case 502:
        return ErrorString.badGateway;
      default:
        return ErrorString.unknownError;
    }
  }

  @override
  String toString() => message;
}

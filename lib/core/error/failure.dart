import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);
}

class CacheFailure extends Failure {
  CacheFailure(super.errorMessage);
}

String handleError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return "Connection timeout with API server";
    case DioExceptionType.sendTimeout:
      return "Send timeout in connection with API server";
    case DioExceptionType.receiveTimeout:
      return "Receive timeout in connection with API server";
    case DioExceptionType.badResponse:
      return e.response?.data['message'] ?? "Something went wrong";
    case DioExceptionType.cancel:
      return "Request to API server was cancelled";
    case DioExceptionType.connectionError:
      return "No Internet Connection";
    default:
      return "Unexpected error occurred";
  }
}

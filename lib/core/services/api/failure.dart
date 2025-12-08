import 'package:bookia/core/services/api/base_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);
}

class CacheFailure extends Failure {
  CacheFailure(super.errorMessage);
}

Left<Failure, T> handleError<T>(DioException e, BaseResponse baseResponse) {
  var serverError = ServerFailure(
    baseResponse.message ?? "something error please try again",
  );
  switch (e.type) {
    case DioExceptionType.badResponse:
      return Left(serverError);

    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
    case DioExceptionType.sendTimeout:
    default:
      return Left(serverError);
  }
}

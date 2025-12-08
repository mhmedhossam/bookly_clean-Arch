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
  switch (e.type) {
    case DioExceptionType.badResponse:
      return Left(ServerFailure(baseResponse.message ?? ""));

    case DioExceptionType.connectionTimeout:
      return Left(ServerFailure(e.message ?? ""));

    case DioExceptionType.receiveTimeout:
      return Left(ServerFailure(e.message ?? ""));

    default:
      return Left(ServerFailure(e.message ?? ""));
  }
}

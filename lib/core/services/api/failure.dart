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

Left<Failure, T> handleError<T>(DioException e) {
  switch (e.type) {
    case DioExceptionType.badResponse:
      return Left(ServerFailure(e.response?.statusMessage ?? ""));

    case DioExceptionType.connectionTimeout:
      return Left(ServerFailure(e.message ?? ""));

    case DioExceptionType.receiveTimeout:
      return Left(ServerFailure(e.message ?? ""));

    default:
      return Left(ServerFailure(e.message ?? ""));
  }
}

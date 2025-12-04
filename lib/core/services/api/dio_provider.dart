import 'dart:developer';

import 'package:bookia/core/services/api/base_response.dart';
import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/core/services/api/main_endpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

extension EitherX<L, R> on Either<L, R> {
  R getRight() => fold((l) => throw Exception('No Right'), (r) => r);
  L getLeft() => fold((l) => l, (r) => throw Exception('No Left'));
}

class DioProvider {
  static late Dio dio;
  init() {
    dio = Dio(BaseOptions(baseUrl: MainEndpoints.baseUrl));
  }

  static Future<Either<Failure, T>> post<T>(
    endpoint, {
    required Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    required T Function(dynamic) json,
  }) async {
    try {
      Response response = await dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      var res = BaseResponse.fromJson(response.data);

      if (res.status != 200 && res.status != 201) {
        return Left(ServerFailure(res.message ?? ""));
      }

      return Right(json(res.data));
    } on DioException catch (e) {
      return handleError(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  static Future<Either<Failure, T>> get<T>(
    endpoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      Response response = await dio.get(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      var res = BaseResponse.fromJson(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (res.data is Map<String, dynamic> || res.data is List<dynamic>) {
          return Right(fromJson!(res.data));
        }
      }

      return Right(fromJson!({}));
    } on DioException catch (e) {
      return handleError(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  static Future<Map<String, dynamic>> patch(
    endpoint, {
    required Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response response = await dio.patch(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null && e.response?.data is Map<String, dynamic>) {
        return e.response!.data;
      }
      return {
        "status": e.response?.statusCode ?? 500,
        "message": "Network error, please try again later",
        "data": [],
        "error": [],
      };
    }
  }

  static Future<Map<String, dynamic>> delete(
    endpoint, {
    required Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response response = await dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null && e.response?.data is Map<String, dynamic>) {
        return e.response!.data;
      }
      return {
        "status": e.response?.statusCode ?? 500,
        "message": "Network error, please try again later",
        "data": [],
        "error": [],
      };
    }
  }
}

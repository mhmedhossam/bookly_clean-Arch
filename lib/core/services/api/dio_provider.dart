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

  static DioProvider get instance => DioProvider();

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
      if (response.data is Map<String, dynamic>) {
        var res = BaseResponse.fromJson(response.data);
        return Right(json(res.data));
      } else {
        return Left(ServerFailure("error the json data return [] not map"));
      }
    } on DioException catch (e) {
      var res = e.response?.data;
      BaseResponse badRes;
      if (res is Map<String, dynamic>) {
        badRes = BaseResponse.fromJson(res);
      } else {
        badRes = BaseResponse(message: e.message);
      }
      return Left(ServerFailure(handleError(e, badRes)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  static Future<Either<Failure, T>> get<T>(
    endpoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      Response response = await dio.get(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      if (response.data is Map<String, dynamic>) {
        var res = BaseResponse.fromJson(response.data);

        return Right(fromJson(res.data));
      } else {
        return Left(ServerFailure("error the json data return [] not map"));
      }
    } on DioException catch (e) {
      var res = e.response?.data;
      BaseResponse badRes;
      if (res is Map<String, dynamic>) {
        badRes = BaseResponse.fromJson(res);
      } else {
        badRes = BaseResponse(message: e.message);
      }

      return Left(ServerFailure(handleError(e, badRes)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  static Future<Either<Failure, T>> patch<T>(
    endpoint, {
    required Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    required T Function(dynamic) json,
  }) async {
    try {
      Response response = await dio.patch(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return Right(json(response.data));
    } on DioException catch (e) {
      var res = e.response?.data;
      BaseResponse badRes;
      if (res is Map<String, dynamic>) {
        badRes = BaseResponse.fromJson(res);
      } else {
        badRes = BaseResponse(message: e.message);
      }

      return Left(ServerFailure(handleError(e, badRes)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  static Future<Either<Failure, T>> delete<T>(
    endpoint, {
    required Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    required T Function(dynamic) json,
  }) async {
    try {
      Response response = await dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return Right(json(response.data));
    } on DioException catch (e) {
      var res = e.response?.data;
      BaseResponse badRes;
      if (res is Map<String, dynamic>) {
        badRes = BaseResponse.fromJson(res);
      } else {
        badRes = BaseResponse(message: e.message);
      }

      return Left(ServerFailure(handleError(e, badRes)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

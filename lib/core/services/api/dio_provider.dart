import 'package:bookia/core/helper/checkInternet.dart';
import 'package:bookia/core/services/api/base_response.dart';
import 'package:bookia/core/error/failure.dart';
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
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          bool isConnected = await isConnection();
          if (!isConnected) {
            return handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.connectionError,
                error: "No Internet Connection",
              ),
            );
          }
          return handler.next(options);
        },
      ),
    );
  }

  static DioProvider get instance => DioProvider();

  static Future<Response<dynamic>> post(
    endpoint, {
    required Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.post(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  static Future<Response<dynamic>> get(
    endpoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.get(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  static Future<Response<dynamic>> patch(
    endpoint, {
    required Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.patch(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  static Future<Response<dynamic>> delete(
    endpoint, {
    required Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.delete(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }
}

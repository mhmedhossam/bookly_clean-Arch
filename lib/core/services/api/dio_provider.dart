import 'package:bookia/core/services/api/main_endpoints.dart';
import 'package:dio/dio.dart';

class DioProvider {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(baseUrl: MainEndpoints.baseUrl));
  }

  static Future<Map<String, dynamic>> post(
    endpoint, {
    required Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response response = await dio.post(
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

  static Future<Map<String, dynamic>> get(
    endpoint, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response response = await dio.get(
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

  static Future<Map<String, dynamic>> put(
    endpoint, {
    required Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      Response response = await dio.put(
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

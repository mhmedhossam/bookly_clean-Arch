import 'package:bookia/core/error/exception.dart';
import 'package:bookia/core/services/api/base_response.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/error/failure.dart';
import 'package:bookia/features/auth/data/data_source/auth_datasource.dart';
import 'package:bookia/features/auth/domain/entities/request/auth_data.dart';
import 'package:bookia/features/auth/data/repo/auth_endpoints.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/data.dart';
import 'package:dio/dio.dart';

class AuthRemoteDatasourceImpl extends AuthDatasource {
  @override
  Future<AuthResponse> register(AuthDataRequest authDataRequest) async {
    try {
      var response = await DioProvider.post(
        AuthEndpoints.register,
        data: authDataRequest.toJson(),
      );
      var baseModel = BaseResponse.fromJson(response.data);
      if (baseModel.data is Map<String, dynamic>) {
        return AuthResponse.fromJson(baseModel.data);
      } else {
        throw ServerException(message: "error please try again");
      }
    } on DioException catch (e) {
      throw ServerException(message: handleError(e));
    } catch (e) {
      throw ServerException(message: "error please try again");
    }
  }

  @override
  Future<AuthResponse> login(AuthDataRequest authDataRequest) async {
    try {
      var response = await DioProvider.post(
        AuthEndpoints.login,
        data: authDataRequest.toJson(),
      );
      var baseModel = BaseResponse.fromJson(response.data);
      if (baseModel.data is Map<String, dynamic>) {
        return AuthResponse.fromJson(baseModel.data);
      } else {
        throw ServerException(message: "error please try again");
      }
    } on DioException catch (e) {
      throw ServerException(message: handleError(e));
    } catch (e) {
      throw ServerException(message: "error please try again");
    }
  }

  @override
  Future<AuthResponse> forgetPassword(AuthDataRequest authDataRequest) async {
    try {
      var response = await DioProvider.post(
        AuthEndpoints.forgetPassword,
        data: authDataRequest.toJson(),
      );
      var baseModel = BaseResponse.fromJson(response.data);
      if (baseModel.data is Map<String, dynamic>) {
        return AuthResponse.fromJson(baseModel.data);
      } else {
        throw ServerException(message: "error please try again");
      }
    } on DioException catch (e) {
      throw ServerException(message: handleError(e));
    } catch (e) {
      throw ServerException(message: "error please try again");
    }
  }

  @override
  Future<AuthResponse> otpVerify(AuthDataRequest authDataRequest) async {
    try {
      var response = await DioProvider.post(
        AuthEndpoints.otpVerify,
        data: authDataRequest.toJson(),
      );
      var baseModel = BaseResponse.fromJson(response.data);
      if (baseModel.data is Map<String, dynamic>) {
        return AuthResponse.fromJson(baseModel.data);
      } else {
        throw ServerException(message: "error please try again");
      }
    } on DioException catch (e) {
      throw ServerException(message: handleError(e));
    } catch (e) {
      throw ServerException(message: "error please try again");
    }
  }

  @override
  Future<AuthResponse> setNewPassword(AuthDataRequest authDataRequest) async {
    try {
      var response = await DioProvider.post(
        AuthEndpoints.setNewPassword,
        data: authDataRequest.toJson(),
      );
      var baseModel = BaseResponse.fromJson(response.data);
      if (baseModel.data is Map<String, dynamic>) {
        return AuthResponse.fromJson(baseModel.data);
      } else {
        throw ServerException(message: "error please try again");
      }
    } on DioException catch (e) {
      throw ServerException(message: handleError(e));
    } catch (e) {
      throw ServerException(message: "error please try again");
    }
  }
}

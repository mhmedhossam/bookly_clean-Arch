import 'package:bookia/core/services/api/base_response.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/auth/data/data_source/auth_datasource.dart';
import 'package:bookia/features/auth/domain/entities/request/auth_data.dart';
import 'package:bookia/features/auth/data/repo/auth_endpoints.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/data.dart';
import 'package:dartz/dartz.dart';

class AuthRemoteDatasourceImpl extends AuthDatasource {
  @override
  Future<Either<Failure, AuthResponse>> register(
    AuthDataRequest authDataRequest,
  ) async {
    try {
      var data = await DioProvider.post<AuthResponse>(
        AuthEndpoints.register,
        data: authDataRequest.toJson(),
        json: (json) => AuthResponse.fromJson(json),
      );
      return data;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> login(
    AuthDataRequest authDataRequest,
  ) async {
    try {
      var data = await DioProvider.post<AuthResponse>(
        AuthEndpoints.login,
        data: authDataRequest.toJson(),
        json: (json) => AuthResponse.fromJson(json),
      );

      return data;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> forgetPassword(
    AuthDataRequest authDataRequest,
  ) async {
    try {
      var data = await DioProvider.post<AuthResponse>(
        AuthEndpoints.forgetPassword,
        data: authDataRequest.toJson(),
        json: (json) => AuthResponse.fromJson(json),
      );
      return data;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> otpVerifyy(
    AuthDataRequest authDataRequest,
  ) async {
    try {
      var data = await DioProvider.post<AuthResponse>(
        AuthEndpoints.otpVerify,
        data: authDataRequest.toJson(),
        json: (json) => AuthResponse.fromJson(json),
      );
      return data;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> setNewPassword(
    AuthDataRequest authDataRequest,
  ) async {
    try {
      var data = await DioProvider.post<AuthResponse>(
        AuthEndpoints.setNewPassword,
        data: authDataRequest.toJson(),
        json: (json) => AuthResponse.fromJson(json),
      );
      return data;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

import 'package:bookia/core/helper/checkInternet.dart';
import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/auth/data/data_source/auth_datasource.dart';
import 'package:bookia/features/auth/domain/entities/request/auth_data.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/data.dart';
import 'package:bookia/features/auth/domain/repo/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthDatasource authDatasource;
  AuthRepositoryImpl({required this.authDatasource});

  @override
  Future<Either<Failure, AuthResponse>> login(
    AuthDataRequest authDataRequest,
  ) async {
    return await isConnection<AuthResponse>(
      authDatasource.login(authDataRequest),
    );
  }

  @override
  Future<Either<Failure, AuthResponse>> register(
    AuthDataRequest authDataRequest,
  ) async {
    return await isConnection<AuthResponse>(
      authDatasource.register(authDataRequest),
    );
  }

  @override
  Future<Either<Failure, AuthResponse>> forgetPassword(
    AuthDataRequest authDataRequest,
  ) async {
    return await isConnection<AuthResponse>(
      authDatasource.forgetPassword(authDataRequest),
    );
  }

  @override
  Future<Either<Failure, AuthResponse>> otpVerifyy(
    AuthDataRequest authDataRequest,
  ) async {
    return await isConnection(authDatasource.otpVerifyy(authDataRequest));
  }

  @override
  Future<Either<Failure, AuthResponse>> setNewPassword(
    AuthDataRequest authDataRequest,
  ) async {
    return await isConnection(authDatasource.setNewPassword(authDataRequest));
  }
}

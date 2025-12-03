import 'package:bookia/core/helper/checkInternet.dart';
import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/auth/data/data_source/auth_datasource.dart';
import 'package:bookia/features/auth/domain/entities/request/auth_data.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/data.dart';
import 'package:bookia/features/auth/domain/repo/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthDatasource authDatasource;
  // late bool isConnected;
  AuthRepositoryImpl({required this.authDatasource});

  @override
  Future<Either<Failure, AuthResponse>> login(
    AuthDataRequest authDataRequesr,
  ) async {
    return await isConnection<AuthResponse>(
      authDatasource.login(authDataRequesr),
    );
  }

  @override
  Future<Either<Failure, AuthResponse>> register(
    AuthDataRequest authDataRequesr,
  ) async {
    return await isConnection<AuthResponse>(
      authDatasource.register(authDataRequesr),
    );
  }

  @override
  Future<Either<Failure, AuthResponse>> forgetPassword(
    AuthDataRequest authDataRequesr,
  ) async {
    return await isConnection<AuthResponse>(
      authDatasource.forgetPassword(authDataRequesr),
    );
  }

  @override
  Future<Either<Failure, AuthResponse>> otpVerifyy(
    AuthDataRequest authDataRequesr,
  ) async {
    return await isConnection(authDatasource.otpVerifyy(authDataRequesr));
  }

  @override
  Future<Either<Failure, AuthResponse>> setNewPassword(
    AuthDataRequest authDataRequesr,
  ) async {
    return await isConnection(authDatasource.setNewPassword(authDataRequesr));
  }
}

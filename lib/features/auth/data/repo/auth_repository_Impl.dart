import 'package:bookia/core/error/exception.dart';
import 'package:bookia/core/helper/checkInternet.dart';
import 'package:bookia/core/error/failure.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
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
    try {
      return Right(await authDatasource.login(authDataRequest));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> register(
    AuthDataRequest authDataRequest,
  ) async {
    try {
      return Right(await authDatasource.register(authDataRequest));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> forgetPassword(
    AuthDataRequest authDataRequest,
  ) async {
    try {
      return Right(await authDatasource.forgetPassword(authDataRequest));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> otpVerifyy(
    AuthDataRequest authDataRequest,
  ) async {
    try {
      return Right(await authDatasource.otpVerify(authDataRequest));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> setNewPassword(
    AuthDataRequest authDataRequest,
  ) async {
    try {
      return Right(await authDatasource.setNewPassword(authDataRequest));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}

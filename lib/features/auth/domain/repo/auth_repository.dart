import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/auth/domain/entities/request/auth_data.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/data.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> register(
    AuthDataRequest authDataRequesr,
  );
  Future<Either<Failure, AuthResponse>> login(AuthDataRequest authDataRequesr);

  Future<Either<Failure, AuthResponse>> otpVerifyy(
    AuthDataRequest authDataRequesr,
  );
  Future<Either<Failure, AuthResponse>> setNewPassword(
    AuthDataRequest authDataRequesr,
  );
  Future<Either<Failure, AuthResponse>> forgetPassword(
    AuthDataRequest authDataRequesr,
  );
}

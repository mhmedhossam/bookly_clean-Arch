import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/auth/domain/entities/request/auth_data.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/auth_response.dart';
import 'package:dartz/dartz.dart';

abstract class AuthDatasource {
  Future<Either<Failure, AuthResponse>> login(AuthDataRequesr authDataRequesr);

  Future<Either<Failure, AuthResponse>> register(
    AuthDataRequesr authDataRequesr,
  );
}

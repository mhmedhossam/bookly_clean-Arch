import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/auth/domain/entities/request/auth_data.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/data.dart';
import 'package:bookia/features/auth/domain/repo/auth_repository.dart';
import 'package:bookia/features/auth/domain/usecases/%D9%90auth_usecase.dart';
import 'package:dartz/dartz.dart';

class SetNPassUseCase extends AuthUseCase {
  SetNPassUseCase({required super.authRepository});

  Future<Either<Failure, AuthResponse>> call(AuthDataRequest authDataRequesr) {
    return authRepository.setNewPassword(authDataRequesr);
  }
}

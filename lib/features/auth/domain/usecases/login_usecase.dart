import 'package:bookia/core/services/api/failure.dart';
import 'package:bookia/features/auth/domain/entities/request/auth_data.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/auth_response.dart';
import 'package:bookia/features/auth/domain/repo/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final AuthRepository authRepository;
  LoginUseCase({required this.authRepository});
  Future<Either<Failure, AuthResponse>> call(AuthDataRequesr authDataRequesr) {
    return authRepository.login(authDataRequesr);
  }
}

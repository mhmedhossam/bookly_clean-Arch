import 'package:bookia/features/auth/domain/repo/auth_repository.dart';

abstract class AuthUseCase {
  AuthRepository authRepository;

  AuthUseCase({required this.authRepository});
}

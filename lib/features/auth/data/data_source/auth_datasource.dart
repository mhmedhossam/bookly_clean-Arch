import 'package:bookia/features/auth/domain/entities/request/auth_data.dart';
import 'package:bookia/features/auth/domain/entities/response/auth_response/data.dart';

abstract class AuthDatasource {
  Future<AuthResponse> login(AuthDataRequest authDataRequest);

  Future<AuthResponse> register(AuthDataRequest authDataRequest);
  Future<AuthResponse> forgetPassword(AuthDataRequest authDataRequest);
  Future<AuthResponse> otpVerify(AuthDataRequest authDataRequest);
  Future<AuthResponse> setNewPassword(AuthDataRequest authDataRequest);
}

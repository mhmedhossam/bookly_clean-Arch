import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/models/request/auth_data.dart';
import 'package:bookia/features/auth/data/models/response/auth_response/auth_response.dart';
import 'package:bookia/features/auth/data/models/response/forget_password/forget_password.dart';
import 'package:bookia/features/auth/data/repo/auth_endpoints.dart';

class AuthRepo {
  static Future<AuthResponse> register(AuthDataRequesr authDataRequesr) async {
    var data = await DioProvider.post(
      AuthEndpoints.register,
      data: authDataRequesr.toJson(),
    );
    return AuthResponse.fromjson(data);
  }

  static Future<AuthResponse> login(AuthDataRequesr authDataRequesr) async {
    var data = await DioProvider.post(
      AuthEndpoints.login,
      data: authDataRequesr.toJson(),
    );

    var succedData = AuthResponse.fromjson(data);
    SharedPref.setToken(succedData.data?.token);
    SharedPref.setusercache(succedData.data?.user);
    return succedData;
  }

  static Future<ForgetPassword> forgetPassword(
    AuthDataRequesr authDataRequesr,
  ) async {
    var data = await DioProvider.post(
      AuthEndpoints.forgetPassword,
      data: authDataRequesr.toJson(),
    );

    return ForgetPassword.fromJson(data);
  }

  static Future<ForgetPassword> otpVerifyy(
    AuthDataRequesr authDataRequesr,
  ) async {
    var data = await DioProvider.post(
      AuthEndpoints.otpVerify,
      data: authDataRequesr.toJson(),
    );

    return ForgetPassword.fromJson(data);
  }

  static Future<AuthResponse> setNewPassword(
    AuthDataRequesr authDataRequesr,
  ) async {
    var data = await DioProvider.post(
      AuthEndpoints.setNewPassword,
      data: authDataRequesr.toJson(),
    );

    return AuthResponse.fromjson(data);
  }
}

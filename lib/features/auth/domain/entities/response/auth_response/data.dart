import 'package:bookia/features/auth/domain/entities/response/auth_response/user.dart';

class AuthResponse {
  AuthUSer? user;
  String? token;

  AuthResponse({this.token, this.user});

  factory AuthResponse.fromJson(json) {
    return AuthResponse(
      token: json?["token"] as String?,
      user: AuthUSer.fromJson(json?["user"]),
    );
  }
}

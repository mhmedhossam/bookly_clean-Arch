import 'package:bookia/features/auth/data/models/response/auth_response/user.dart';

class Data {
  AuthUSer? user;
  String? token;

  Data({this.token, this.user});

  factory Data.fromjson(json) {
    return Data(
      token: json?["token"] as String?,
      user: AuthUSer.fromJson(json?["user"]),
    );
  }
}

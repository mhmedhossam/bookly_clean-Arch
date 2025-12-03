class AuthDataRequest {
  String? name;
  String? email;
  String? password;
  String? newPassword;
  String? otp;
  String? confirmPass;
  String? newConfirmPass;

  AuthDataRequest({
    this.confirmPass,
    this.email,
    this.name,
    this.password,
    this.otp,
    this.newConfirmPass,
    this.newPassword,
  });

  factory AuthDataRequest.fromjson(Map<String, dynamic> json) {
    return AuthDataRequest(
      name: json["name"],
      confirmPass: json["password_confirmation"],
      email: json["email"],
      password: json["password"],
      otp: json["verify_code"],
      newConfirmPass: json["new_password_confirmation"],
      newPassword: json["new_password"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": confirmPass,
      "verify_code": otp,
      "new_password": newPassword,
      "new_password_confirmation": newConfirmPass,
    };
  }
}

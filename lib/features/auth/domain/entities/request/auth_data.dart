class AuthDataRequesr {
  String? name;
  String? email;
  String? password;
  String? newpassword;
  String? otp;
  String? confirmPass;
  String? newconfirmPass;

  AuthDataRequesr({
    this.confirmPass,
    this.email,
    this.name,
    this.password,
    this.otp,
    this.newconfirmPass,
    this.newpassword,
  });

  factory AuthDataRequesr.fromjson(Map<String, dynamic> json) {
    return AuthDataRequesr(
      name: json["name"],
      confirmPass: json["password_confirmation"],
      email: json["email"],
      password: json["password"],
      otp: json["verify_code"],
      newconfirmPass: json["new_password_confirmation"],
      newpassword: json["new_password"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": confirmPass,
      "verify_code": otp,
      "new_password": newpassword,
      "new_password_confirmation": newconfirmPass,
    };
  }
}

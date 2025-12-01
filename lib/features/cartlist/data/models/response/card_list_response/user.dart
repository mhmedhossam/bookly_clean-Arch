class User {
  int? userId;
  int? governorateId;
  String? userName;
  String? userEmail;
  String? address;
  dynamic phone;

  User({
    this.userId,
    this.userName,
    this.userEmail,
    this.address,
    this.phone,
    this.governorateId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json['user_id'] as int?,
    userName: json['user_name'] as String?,
    userEmail: json['user_email'] as String?,
    address: json['address'] as String?,
    phone: json['phone'] as dynamic,
    governorateId: json['governorate_id'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'name': userName,
    'email': userEmail,
    'address': address,
    'phone': phone,
    'governorate_id': governorateId,
  };
}

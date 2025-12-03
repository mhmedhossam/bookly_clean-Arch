class AuthUSer {
  int? id;
  String? name;
  String? email;
  String? address;
  String? city;
  String? phone;
  bool? emailVerified;
  String? image;

  AuthUSer({
    this.address,
    this.city,
    this.email,
    this.emailVerified,
    this.id,
    this.image,
    this.name,
    this.phone,
  });

  factory AuthUSer.fromJson(json) {
    return AuthUSer(
      address: json?["address"] as String?,
      city: json?["city"] as String?,
      email: json?["email"] as String?,
      emailVerified: json?["email_verified"] as bool?,
      id: json?["id"] as int?,
      image: json?["image"] as String?,
      name: json?["name"] as String?,
      phone: json?["phone"] as String?,
    );
  }
  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'address': address,
    'phone': phone,
    'city': city,
    'id': id,
    'image': image,
    'emailVerified': emailVerified,
  };
}

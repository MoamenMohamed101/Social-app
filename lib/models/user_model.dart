class UserModel {
  String? email, password, phone, name;
  bool? isEmailVerified = false;

  UserModel({this.email, this.password, this.phone, this.name , this.isEmailVerified});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      password: json["password"],
      phone: json["phone"],
      name: json["name"],
      isEmailVerified: json["isEmailVerified"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "phone": phone,
      "name": name,
      "isEmailVerified": isEmailVerified,
    };
  }
}
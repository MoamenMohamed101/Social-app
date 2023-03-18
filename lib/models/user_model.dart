class UserModel {
  String? email, password, phone, name, uId;
  bool? isEmailVerified = false;

  UserModel(
      {this.email,
      this.password,
      this.phone,
      this.name,
      this.isEmailVerified,
      this.uId});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      password: json["password"],
      phone: json["phone"],
      name: json["name"],
      isEmailVerified: json["isEmailVerified"],
      uId: json["uId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "phone": phone,
      "name": name,
      "isEmailVerified": isEmailVerified,
      "uId": uId,
    };
  }
}

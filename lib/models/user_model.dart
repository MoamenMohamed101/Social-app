class UserModel {
  String? email, password, phone, name;

  UserModel({this.email, this.password, this.phone, this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      password: json["password"],
      phone: json["phone"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "phone": phone,
      "name": name,
    };
  }
}

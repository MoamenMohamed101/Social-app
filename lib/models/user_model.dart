class UserModel {
  String? email, password, phone, name, uId, bio , image , cover;
  bool? isEmailVerified = false;

  UserModel({
    this.email,
    this.password,
    this.phone,
    this.name,
    this.isEmailVerified,
    this.uId,
    required this.image,
    this.bio,
    required this.cover,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      password: json["password"],
      phone: json["phone"],
      name: json["name"],
      isEmailVerified: json["isEmailVerified"],
      uId: json["uId"],
      image: json["image"],
      bio: json["bio"],
      cover: json["cover"],
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
      "image": image,
      "bio": bio,
      "cover": cover,
    };
  }
}

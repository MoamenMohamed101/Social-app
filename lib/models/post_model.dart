class PostModel {
  String?  name, uId, image , dataTime , text , postImage , password , phone , email , bio , cover;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dataTime,
    this.text,
    this.postImage,
    this.phone,
    this.email,
    this.bio,
    this.password,
    this.cover,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      name: json["name"],
      uId: json["uId"],
      image: json["image"],
      dataTime: json["dataTime"],
      text: json["text"],
      postImage: json["postImage"],
      phone: json["phone"],
      email: json["email"],
      bio: json["bio"],
      password: json["password"],
      cover: json["cover"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "uId": uId,
      "image": image,
      "dataTime": dataTime,
      "text": text,
      "postImage": postImage,
      "phone": phone,
      "email": email,
      "bio": bio,
      "password": password,
      "cover": cover,
    };
  }
}

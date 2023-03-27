class PostModel {
  String?  name, uId, image , dataTime , text , postImage;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dataTime,
    this.text,
    this.postImage,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      name: json["name"],
      uId: json["uId"],
      image: json["image"],
      dataTime: json["dataTime"],
      text: json["text"],
      postImage: json["postImage"],
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
    };
  }
}

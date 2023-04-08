class MessageModel {
  String? senderId, receiverId, dataTime, text;

  MessageModel({
    this.text,
    this.senderId,
    this.receiverId,
    this.dataTime,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json["text"],
      senderId: json["senderId"],
      receiverId: json["receiverId"],
      dataTime: json["dataTime"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": text,
      "password": senderId,
      "phone": receiverId,
      "dataTime": dataTime,
    };
  }
}

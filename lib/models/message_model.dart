class MessageModel {
  String? text, senderId, receiverId, dateTime;

  MessageModel({
    this.text,
    this.senderId,
    this.receiverId,
    this.dateTime,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json["text"],
      senderId: json["senderId"],
      receiverId: json["receiverId"],
      dateTime: json["dateTime"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "senderId": senderId,
      "receiverId": receiverId,
      "dateTime": dateTime,
    };
  }
}

class MessageModel {
  final String text;
  final String userId;

  MessageModel({
    required this.text,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': this.text,
      'userId': this.userId,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      text: map['text'] as String,
      userId: map['userId'] as String,
    );
  }
}

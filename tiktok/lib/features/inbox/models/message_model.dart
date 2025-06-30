class MessageModel {
  final String text;
  final String userId;
  final int createdAt;

  MessageModel({
    required this.text,
    required this.userId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': this.text,
      'userId': this.userId,
      'createdAt': this.createdAt,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      text: map['text'] as String,
      userId: map['userId'] as String,
      createdAt: map['createdAt'] as int,
    );
  }
}

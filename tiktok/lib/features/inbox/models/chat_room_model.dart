class ChatRoomModel {
  // 본인
  final String personA;

  // 다른 유저
  final String personB;

  ChatRoomModel({
    required this.personA,
    required this.personB,
  });

  Map<String, dynamic> toMap() {
    return {
      'personA': this.personA,
      'personB': this.personB,
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      personA: map['personA'] as String,
      personB: map['personB'] as String,
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  final String id;

  // 본인
  final String personA;

  // 다른 유저
  final String personB;

  final DateTime? regDt;

  ChatRoomModel({
    required this.id,
    required this.personA,
    required this.personB,
    DateTime? regDt,
  }) : regDt = regDt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'personA': this.personA,
      'personB': this.personB,
      'regDt': this.regDt,
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      id: map['id'] as String,
      personA: map['personA'] as String,
      personB: map['personB'] as String,
      regDt: (map['regDt'] as Timestamp).toDate(),
    );
  }
}

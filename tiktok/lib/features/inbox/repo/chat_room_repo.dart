import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/inbox/models/chat_room_model.dart';

class ChatRoomRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> createChatRoom(String personA, String personB) async {
    final chatRoom = ChatRoomModel(personA: personA, personB: personB);
    final doc = await _db.collection("chat_rooms").add(chatRoom.toMap());
    return doc.id;
  }

  Future<ChatRoomModel> findChatRoom(String roomId) async {
    final doc = await _db.collection("chat_rooms").doc(roomId).get();
    return ChatRoomModel.fromMap(doc.data()!);
  }
}

final chatRoomRepo = Provider((ref) => ChatRoomRepo());

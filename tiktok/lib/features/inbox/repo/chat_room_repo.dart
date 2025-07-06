import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/inbox/models/chat_room_model.dart';

class ChatRoomRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> createChatRoom(String personA, String personB) async {
    final docRef = await _db.collection("chat_rooms").doc();
    final chatRoom = ChatRoomModel(
      id: docRef.id,
      personA: personA,
      personB: personB,
    );
    await docRef.set(chatRoom.toMap());
    return docRef.id;
  }

  Future<ChatRoomModel> findChatRoom(String roomId) async {
    final doc = await _db.collection("chat_rooms").doc(roomId).get();
    return ChatRoomModel.fromMap(doc.data()!);
  }

  Future<void> deleteChatRoom(String roomId) async {
    await _db.collection("chat_rooms").doc(roomId).delete();
  }

  Future<List<ChatRoomModel>> findMyChatRoom(String userId) async {
    final doc = await _db.collection("chat_rooms");
    var personAChatRooms = doc.where("personA", isEqualTo: userId).get();
    var personBChatRooms = doc.where("personB", isEqualTo: userId).get();
    final result = await Future.wait([personAChatRooms, personBChatRooms]);
    final docs = [...result[0].docs, ...result[1].docs];
    return docs.map((e) => ChatRoomModel.fromMap(e.data())).toList();
  }
}

final chatRoomRepo = Provider((ref) => ChatRoomRepo());

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/users/models/user_profile_model.dart';
import 'package:uuid/uuid.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection("users").doc(profile.uid).set(profile.toMap());
  }

  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  Future<String?> uploadAvatar(String uid, File file) async {
    // UUID로 유니크한 파일 경로 생성
    final reference = _storage.ref("avatars").child(uid).child(Uuid().v4());
    final bytes = await file.readAsBytes();
    final metadata = SettableMetadata(contentType: 'image/png');
    // 파일 업로드
    var taskSnapshot = await reference.putData(bytes, metadata);
    // 업로드 완료 후 다운로드 URL 가져오기
    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<void> updateProfile(String uid, Map<String, dynamic> data) async {
    await _db.collection("users").doc(uid).update(data);
  }
}

final userRepository = Provider(
  (ref) => UserRepository(),
);

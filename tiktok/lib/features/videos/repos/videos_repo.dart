import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/videos/models/video_model.dart';
import 'package:uuid/uuid.dart';

class VideosRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UploadTask uploadVideoFile({
    required String uid,
    required File video,
  }) {
    final videoRef = _storage.ref("videos").child(uid).child(Uuid().v4());
    final bytes = video.readAsBytesSync();
    final metadata = SettableMetadata(contentType: 'video/mp4');
    return videoRef.putData(bytes, metadata);
  }

  Future<void> saveVideo(VideoModel videoModel) async {
    await _db.collection("videos").add(videoModel.toMap());
  }

  Future<List<VideoModel>> fetchVideos() async {
    var querySnapShot = await _db
        .collection("videos")
        .orderBy("createdAt", descending: true)
        .get();

    return querySnapShot.docs
        .map((json) => VideoModel.fromMap(
              json.data(),
            ))
        .toList();
  }
}

final videoRepository = Provider(
  (ref) => VideosRepository(),
);

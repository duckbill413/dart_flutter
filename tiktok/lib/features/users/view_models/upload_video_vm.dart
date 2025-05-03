import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok/features/users/view_models/users_vm.dart';
import 'package:tiktok/features/videos/models/video_model.dart';
import 'package:tiktok/features/videos/repos/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _videosRepository;

  @override
  FutureOr<void> build() {
    _videosRepository = ref.read(videoRepository);
  }

  Future<void> uploadVideo(File video, BuildContext context) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(usersProvider).value;
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      try {
        final taskSnapshot = await _videosRepository.uploadVideoFile(
          uid: user!.uid,
          video: video,
        );
        if (taskSnapshot.metadata != null) {
          await _videosRepository.saveVideo(
            VideoModel(
              id: taskSnapshot.metadata!.name,
              title: taskSnapshot.metadata!.name,
              description: taskSnapshot.metadata!.name,
              contentPath: await taskSnapshot.ref.getDownloadURL(),
              thumbnailPath: '',
              likes: 0,
              comments: 0,
              creatorUid: user.uid,
              creator: userProfile!.username,
              createdAt: DateTime.now().microsecondsSinceEpoch,
            ),
          );
          if (!context.mounted) return;
          context.pushReplacement("/home");
        }
      } catch (e) {
        print(e);
      }
    });
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);

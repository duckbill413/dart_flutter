import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok/features/users/view_models/users_vm.dart';
import 'package:tiktok/features/videos/models/video_model.dart';
import 'package:tiktok/features/videos/repos/videos_repo.dart';
import 'package:tiktok/features/videos/views/upload_video_detail_screen.dart';

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
          if (!context.mounted) return;

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadVideoDetailScreen(
                creatorUid: user.uid,
                creator: userProfile!.username,
                snapshot: taskSnapshot,
              ),
            ),
          );
        }
      } catch (e) {
        print(e);
      }
    });
  }

  Future<void> saveVideoDescription({
    required BuildContext context,
    required VideoModel videoModel,
  }) async {
    await _videosRepository.saveVideo(videoModel);
    if (!context.mounted) return;
    context.pushReplacement("/home");
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);

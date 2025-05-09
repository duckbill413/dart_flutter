import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok/features/videos/repos/videos_repo.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideosRepository _videosRepository;
  late final String _videoId;

  @override
  FutureOr<void> build(String videoId) {
    _videoId = videoId;
    _videosRepository = ref.read(videoRepository);
  }

  Future<void> likeVideo() async {
    final user = ref.read(authRepo).user;
    await _videosRepository.likeVideo(user!.uid, _videoId);
  }

  Future<bool> isLikedVideo() async {
    final user = ref.read(authRepo).user;
    return await _videosRepository.isLikedVideo(user!.uid, _videoId);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);

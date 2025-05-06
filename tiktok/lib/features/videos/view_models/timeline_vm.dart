import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/videos/models/video_model.dart';
import 'package:tiktok/features/videos/repos/videos_repo.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideosRepository _videosRepository;
  List<VideoModel> _list = [];

  @override
  FutureOr<List<VideoModel>> build() async {
    _videosRepository = ref.read(videoRepository);
    _list = await _fetchVideos();
    return _list;
  }

  Future<List<VideoModel>> _fetchVideos({DateTime? lastItemCreatedAt}) async {
    return await _videosRepository.fetchVideos(
      lastItemCreatedAt: lastItemCreatedAt,
    );
  }

  Future<void> fetchNextVideos() async {
    final nextVideos = await _fetchVideos(
      lastItemCreatedAt: _list.last.createdAt,
    );
    state = AsyncValue.data([..._list, ...nextVideos]);
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);

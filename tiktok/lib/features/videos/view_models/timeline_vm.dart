import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/videos/models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [
    VideoModel(
      title: "뮤직비디오1",
      contentPath: "assets/videos/video1.MP4",
    ),
    VideoModel(
      title: "뮤직비디오2",
      contentPath: "assets/videos/video2.MP4",
    ),
    VideoModel(
      title: "뮤직비디오3",
      contentPath: "assets/videos/video3.MP4",
    ),
    VideoModel(
      title: "뮤직비디오4",
      contentPath: "assets/videos/video4.MP4",
    ),
    VideoModel(
      title: "뮤직비디오5",
      contentPath: "assets/videos/video5.MP4",
    ),
    VideoModel(
      title: "뮤직비디오6",
      contentPath: "assets/videos/video6.MP4",
    ),
  ];

  void uploadVideo() async {
    state = AsyncValue.loading();
    await Future.delayed(Duration(seconds: 2));
    final newVideo = VideoModel(title: "${DateTime.now()}", contentPath: "");
    _list = [..._list, newVideo];
    state = AsyncValue.data(_list);
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(Duration(seconds: 5));
    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);

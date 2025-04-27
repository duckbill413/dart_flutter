import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/videos/view_models/timeline_vm.dart';
import 'package:tiktok/features/videos/views/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  int _itemCount = 4;
  final PageController _pageController = PageController();
  final _scrollDuration = Duration(milliseconds: 250);
  final _scrollCurve = Curves.linear;

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
    if (page == _itemCount - 1) {
      _itemCount += 4;
      setState(() {});
    }
  }

  void _onVideoFinished() {
    return;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return Future.delayed(Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          data: (videos) => RefreshIndicator(
            onRefresh: _onRefresh,
            displacement: 50,
            edgeOffset: 10,
            color: Theme.of(context).primaryColor,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: videos.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) => VideoPost(
                video: videos[index],
                onVideoFinished: _onVideoFinished,
              ),
            ),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              "Could not load videos: $error",
              style: TextStyle(color: Colors.white),
            ),
          ),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}

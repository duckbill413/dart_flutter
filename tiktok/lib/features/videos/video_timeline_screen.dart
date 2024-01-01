import 'package:flutter/material.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  final PageController _pageController = PageController();
  final Duration _scrollDuration = const Duration(milliseconds: 250);
  final Curve _scrollCurve = Curves.linear;
  late int _itemCount = 4;

  void _onPageChanged(int page) {
    // MEMO: Page가 넘어가는 속도 및 애니메이션 조절
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
    return; // tiktok은 반복 재생
    _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return Future.delayed(
      const Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      displacement: Sizes.size52,
      edgeOffset: Sizes.size20,
      child: PageView.builder(
        controller: _pageController,
        // MEMO: builder을 사용하면 필요할 때 화면을 렌더링하게 된다. (성능up)
        pageSnapping: true,
        scrollDirection: Axis.vertical,
        itemCount: _itemCount,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) => VideoPost(
          index: index,
          onVideoFinished: _onVideoFinished,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tiktok/constants/sizes.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  List<Color> colors = [Colors.blue, Colors.red, Colors.yellow, Colors.teal];
  late int _itemCount = 4;

  void _onPageChanged(int page) {
    if (page == _itemCount - 1) {
      _itemCount += 4;
      colors.addAll([Colors.blue, Colors.red, Colors.yellow, Colors.teal]);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      // MEMO: builder을 사용하면 필요할 때 화면을 렌더링하게 된다. (성능up)
      pageSnapping: true,
      scrollDirection: Axis.vertical,
      itemCount: _itemCount,
      onPageChanged: _onPageChanged,
      itemBuilder: (context, index) => Container(
        color: colors[index],
        child: Center(
          child: Text(
            'Screen $index',
            style: const TextStyle(
              fontSize: Sizes.size64,
            ),
          ),
        ),
      ),
    );
  }
}

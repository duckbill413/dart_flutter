import 'package:flutter/material.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

class VideoTags extends StatefulWidget {
  const VideoTags({
    super.key,
    required List<String> tags,
  }) : _tags = tags;
  final List<String> _tags;

  @override
  State<VideoTags> createState() => _VideoTagsState();
}

class _VideoTagsState extends State<VideoTags> {
  bool _seeMoreCheck = false;
  final maximumTagsLength = 20;

  void _onSeeMoreTap() {
    setState(() {
      _seeMoreCheck = !_seeMoreCheck;
    });
  }

  int _defaultSeeCount() {
    int count = 0;
    int length = 0;
    for (var tag in widget._tags) {
      length += tag.length;
      if (length > maximumTagsLength) break;
      count += 1;
    }
    return count;
  }

  _onVideoTagTap(String tag) {
    // TODO: tag를 누르면 해당 태그를 검색하는 화면으로 이동 및 검색
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('$tag 태그검색페이지'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.8,
      child: Wrap(
        spacing: Sizes.size3,
        runSpacing: Sizes.size1,
        children: [
          for (int i = 0; i < (_seeMoreCheck ? widget._tags.length : _defaultSeeCount()); i++)
            GestureDetector(
              onTap: () => _onVideoTagTap(widget._tags[i]),
              child: Text(
                '#${widget._tags[i]}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.size16,
                ),
              ),
            ),
          Gaps.h6,
          GestureDetector(
            onTap: _onSeeMoreTap,
            child: Text(
              _seeMoreCheck ? '... Close' : '... See more',
              style: const TextStyle(
                fontSize: Sizes.size16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

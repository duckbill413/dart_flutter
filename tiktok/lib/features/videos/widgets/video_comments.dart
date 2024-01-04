import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

class VideoComment extends StatefulWidget {
  const VideoComment({super.key});

  @override
  State<VideoComment> createState() => _VideoCommentState();
}

class _VideoCommentState extends State<VideoComment> {
  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text('22796 comments'),
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size10,
            horizontal: Sizes.size16,
          ),
          itemCount: 10,
          itemBuilder: (context, index) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey.shade500,
                foregroundColor: Colors.white,
                foregroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/86183856?v=4'),
                child: Text('오리너굴'),
              ),
              Gaps.h10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'duckbill',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Sizes.size14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Gaps.v3,
                    const Text(
                      "That's not it I've seen the same thing but also in a cave",
                    ),
                  ],
                ),
              ),
              Gaps.h10,
              Column(
                children: [
                  FaIcon(
                    FontAwesomeIcons.heart,
                    color: Colors.grey.shade500,
                    size: Sizes.size20,
                  ),
                  Gaps.v2,
                  Text(
                    '52.2K',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          separatorBuilder: (context, index) => Gaps.v12,
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey.shade500,
                foregroundColor: Colors.white,
                foregroundImage: const NetworkImage(
                    'https://avatars.githubusercontent.com/u/86183856?v=4'),
                child: const Text('오리너굴'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

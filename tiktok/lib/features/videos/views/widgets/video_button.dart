import 'package:flutter/material.dart';
import 'package:tiktok/constants/gaps.dart';

class VideoButton extends StatelessWidget {
  final Icon icon;
  final String text;

  const VideoButton({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        Gaps.v5,
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

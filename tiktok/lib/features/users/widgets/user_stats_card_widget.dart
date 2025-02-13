import 'package:flutter/material.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

class UserStatsCardWidget extends StatelessWidget {
  final int number;
  final String text;

  const UserStatsCardWidget({
    super.key,
    required this.number,
    required this.text,
  });

  String _showNumber() {
    if (number >= 1_000_000) {
      return "${(number / 1_000_000).toStringAsFixed(1)}M";
    }

    if (number >= 1_000) {
      return "${(number / 1_000).toStringAsFixed(1)}K";
    }

    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _showNumber(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size20,
          ),
        ),
        Gaps.v3,
        Text(
          text,
          style: TextStyle(
            fontSize: Sizes.size14,
            color: Colors.grey.shade500,
          ),
        )
      ],
    );
  }
}

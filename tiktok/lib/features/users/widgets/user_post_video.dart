import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

class UserPostVideo extends StatelessWidget {
  const UserPostVideo({
    super.key,
    required this.isPinned,
    required this.playedCnt,
  });

  final bool isPinned;
  final int playedCnt;

  String _showNumber(int number) {
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
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 9 / 12,
              child: FadeInImage.assetNetwork(
                placeholder: "assets/images/picture1.jpg",
                image:
                    "https://images.unsplash.com/photo-1737143765999-bd3be790ab4f?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwyfHx8ZW58MHx8fHx8",
                fit: BoxFit.cover,
                placeholderFit: BoxFit.cover,
              ),
            ),
            if (isPinned)
              Positioned(
                left: Sizes.size4,
                top: Sizes.size4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Sizes.size2),
                    color: Theme.of(context).primaryColor,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: Sizes.size2,
                    horizontal: Sizes.size4,
                  ),
                  child: Text(
                    "Pinned",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.size12,
                    ),
                  ),
                ),
              ),
            Positioned(
              left: 4,
              bottom: 4,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.play,
                    color: Colors.white,
                    size: Sizes.size16,
                  ),
                  Gaps.h2,
                  Text(
                    _showNumber(playedCnt),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.size11,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

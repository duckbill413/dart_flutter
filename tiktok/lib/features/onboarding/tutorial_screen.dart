import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/common/theme_config/theme_config.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showingPage = Page.first;

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      setState(() {
        _direction = Direction.right;
      });
    } else {
      setState(() {
        _direction = Direction.left;
      });
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_direction == Direction.left) {
      setState(() {
        _showingPage = Page.second;
      });
    } else {
      setState(() {
        _showingPage = Page.first;
      });
    }
  }

  void _onEnterAppTap() {
    context.go("/home");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // click 후 drag 할 때 발생
      onPanUpdate: _onPanUpdate,
      // drag 가 종료될 때 발생
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.size24,
            ),
            child: AnimatedCrossFade(
              firstChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v80,
                  Text(
                    "Enjoy the ride!",
                    style: TextStyle(
                      fontSize: Sizes.size36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    "Videos are personalized for you based on what you watch, like, and share.",
                    style: TextStyle(
                      fontSize: Sizes.size20,
                    ),
                  ),
                ],
              ),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v80,
                  Text(
                    "Follow the rules!",
                    style: TextStyle(
                      fontSize: Sizes.size36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    "Take care of one another! Plis!",
                    style: TextStyle(
                      fontSize: Sizes.size20,
                    ),
                  ),
                ],
              ),
              crossFadeState: _showingPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 300),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: !themeConfig.value ? Colors.black : Colors.white,
          child: Padding(
            padding: EdgeInsets.only(
              top: Sizes.size40,
              bottom: Sizes.size64,
              left: Sizes.size24,
              right: Sizes.size24,
            ),
            child: AnimatedOpacity(
              opacity: _showingPage == Page.first ? 0 : 1,
              duration: Duration(milliseconds: 300),
              child: CupertinoButton(
                color: Theme.of(context).primaryColor,
                onPressed: _onEnterAppTap,
                child: Text(
                  "Enter the app!",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

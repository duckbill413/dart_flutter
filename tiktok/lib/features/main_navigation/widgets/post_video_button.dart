import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/sizes.dart';

class PostVideoButton extends StatefulWidget {
  final Function onTap;

  const PostVideoButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<PostVideoButton> createState() => _PostVideoButtonState();
}

class _PostVideoButtonState extends State<PostVideoButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.2,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
    widget.onTap();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 + _animationController.value;
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Transform.scale(
        scale: _scale,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: 20,
              child: Container(
                height: 30,
                width: 25,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff61D4F0),
                  borderRadius: BorderRadius.circular(Sizes.size8),
                ),
              ),
            ),
            Positioned(
              left: 20,
              child: Container(
                height: 30,
                width: 25,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size8,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(Sizes.size8),
                ),
              ),
            ),
            Container(
              height: 30,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Sizes.size6,
                ),
                color: Colors.white,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  size: 18,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashModeButton extends StatelessWidget {
  final Function onPressed;
  final FlashMode flashMode;
  final FlashMode setFlashMode;
  final IconData icon;

  const FlashModeButton({
    super.key,
    required this.onPressed,
    required this.flashMode,
    required this.setFlashMode,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPressed(setFlashMode),
      color: flashMode == setFlashMode ? Colors.amber : Colors.white,
      icon: Icon(icon),
    );
  }
}

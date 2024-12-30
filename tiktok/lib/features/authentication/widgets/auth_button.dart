import 'package:flutter/material.dart';
import 'package:tiktok/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;

  const AuthButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1, // 상대적 크기를 이용하여 할당 (0~1)
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.size14,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: Sizes.size1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

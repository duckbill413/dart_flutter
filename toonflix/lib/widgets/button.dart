import 'package:flutter/cupertino.dart';

class Button extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const Button(
      {super.key,
      required this.text,
      required this.backgroundColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(45),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 50,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: textColor,
        ),
      ),
    );
  }
}

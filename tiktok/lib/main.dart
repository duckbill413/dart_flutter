import 'package:flutter/material.dart';
import 'package:tiktok/features/authentication/sign_up_screen.dart';

void main() {
  runApp(const TiktokApp());
}

class TiktokApp extends StatelessWidget {
  const TiktokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiktok Clone',
      theme: ThemeData(primaryColor: const Color(0xFFE9435A)),
      home: SignUpScreen(),
    );
  }
}

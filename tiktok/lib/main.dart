import 'package:flutter/material.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/sign_up_screen.dart';

void main() {
  runApp(const TiktokApp());
}

class TiktokApp extends StatelessWidget {
  const TiktokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiktok',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
      ),
      home: const SignUpScreen(),
    );
  }
}

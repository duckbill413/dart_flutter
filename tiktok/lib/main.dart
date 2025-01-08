import 'package:flutter/cupertino.dart';
import 'package:tiktok/features/main_navigation/main_navigation_screen.dart';

void main() {
  runApp(const TiktokApp());
}

class TiktokApp extends StatelessWidget {
  const TiktokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Tiktok Clone',
      home: MainNavigationScreen(),
    );
  }
}

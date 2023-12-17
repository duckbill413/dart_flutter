import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webtoon/screens/home_screen.dart';

import 'config/my_http_overrides.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

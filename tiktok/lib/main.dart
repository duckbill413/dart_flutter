import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/sign_up_screen.dart';

void main() async {
  // This is the glue that binds the framework to the Flutter engine.
  WidgetsFlutterBinding.ensureInitialized();
  // 디바이스 방향을 한 방향으로 고정
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  // 상단 UI 의 다크/라이트 모드를 설정 (앱 화면별로 설정 가능)
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );
  runApp(const TiktokApp());
}

class TiktokApp extends StatelessWidget {
  const TiktokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // 우측 상단의 디버그 태그 삭제
      title: 'Tiktok Clone',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Sizes.size16 + Sizes.size2,
            color: Colors.black,
          ),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade50,
        ),
        splashColor: Colors.transparent,
        // highlightColor: Colors.transparent,
        primaryColor: const Color(0xFFE9435A),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Theme.of(context).primaryColor,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFE9435A),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900,
        ),
      ),
      home: SignUpScreen(),
    );
  }
}

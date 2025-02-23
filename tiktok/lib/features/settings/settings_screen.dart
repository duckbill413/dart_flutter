import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 닫기 버튼을 쉽게 만들 수 있는 위젯
// CloseButton(),

// apple, android 로딩 상태바
// CupertinoActivityIndicator()
// CircularProgressIndicator()
// OS 에 따라서 다른 로딩 상태바 제공
// CircularProgressIndicator.adaptive()

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          CupertinoActivityIndicator(),
          CircularProgressIndicator(),
          CircularProgressIndicator.adaptive()
        ],
      ),
    );
  }
}

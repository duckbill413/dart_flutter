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
      body: ListView(
        children: [
          ListTile(
            // 앱 배포시 필요한 오픈소스 라이선스 고지를 쉽게할 수 있음
            onTap: () => showAboutDialog(
              context: context,
              applicationVersion: "1.0",
              applicationLegalese: "All rights reserved. please don't copy me",
            ),
            title: Text(
              "About",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text("About this app...."),
          ),
          AboutListTile()
        ],
      ),
    );
  }
}

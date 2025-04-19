import 'package:flutter/cupertino.dart';

class VideoConfig extends ChangeNotifier {
  bool autoMute = true;

  void toggleAutoMute() {
    autoMute = !autoMute;
    notifyListeners(); // 데이터 변경 알림
  }
}

final videoConfig = VideoConfig();

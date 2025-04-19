import 'package:flutter/cupertino.dart';

final videoValueConfig = ValueNotifier(false);

class VideoClassConfig extends ChangeNotifier {
  bool autoMute = true;

  void toggleAutoMute() {
    autoMute = !autoMute;
    notifyListeners(); // 데이터 변경 알림
  }
}

final videoClassConfig = VideoClassConfig();

import 'package:flutter/cupertino.dart';

class ThemeConfig extends ChangeNotifier {
  bool isDarkMode = false;

  void toggleThemeMode() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

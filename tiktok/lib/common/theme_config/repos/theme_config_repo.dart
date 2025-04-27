import 'package:shared_preferences/shared_preferences.dart';

class ThemeConfigRepository {
  static const String _theme = "theme";
  SharedPreferences _preferences;

  ThemeConfigRepository(this._preferences);

  Future<void> setTheme(bool value) async {
    _preferences.setBool(_theme, value);
  }

  bool isDark() {
    return _preferences.getBool(_theme) ?? false;
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/common/theme_config/model/ThemeConfigModel.dart';
import 'package:tiktok/common/theme_config/repos/theme_config_repo.dart';

class ThemeConfigViewModel extends Notifier<ThemeConfigModel> {
  final ThemeConfigRepository _repository;

  ThemeConfigViewModel(this._repository);

  void setTheme(bool isDark) {
    _repository.setTheme(isDark);
    state = ThemeConfigModel(
      isDark: isDark,
    );
  }

  void toggleTheme() {
    _repository.setTheme(!state.isDark);
    state = ThemeConfigModel(
      isDark: !state.isDark,
    );
  }

  @override
  ThemeConfigModel build() {
    return ThemeConfigModel(
      isDark: _repository.isDark(),
    );
  }
}

final themeConfigProvider =
    NotifierProvider<ThemeConfigViewModel, ThemeConfigModel>(
  () => throw UnimplementedError(),
);

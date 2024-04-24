
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:s9_widgetapp/config/theme/app_theme.dart';

final colorListProvider = Provider((ref) => colorList);

final themeNotProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier()
);

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme());

  void toogleDark() {
    state = state.copyWith(isDark: !state.isDark);
  }

  void chnagecolor(int color) {
    state = state.copyWith(selected: color);
  }

}
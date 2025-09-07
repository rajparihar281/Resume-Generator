import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/settings_model.dart';

final settingsProvider = StateNotifierProvider<SettingsNotifier, UserSettings>((
  ref,
) {
  return SettingsNotifier();
});

class SettingsNotifier extends StateNotifier<UserSettings> {
  SettingsNotifier() : super(UserSettings()) {
    loadSettings();
  }

  final Box<UserSettings> _settingsBox = Hive.box<UserSettings>('settings');

  void loadSettings() {
    final settings = _settingsBox.get('user_settings');
    if (settings != null) {
      state = settings;
    }
  }

  void updateFontSize(double fontSize) {
    final newSettings = UserSettings(
      fontSize: fontSize,
      fontColor: state.fontColor,
      backgroundColor: state.backgroundColor,
    );
    state = newSettings;
    _settingsBox.put('user_settings', newSettings);
  }

  void updateFontColor(int color) {
    final newSettings = UserSettings(
      fontSize: state.fontSize,
      fontColor: color,
      backgroundColor: state.backgroundColor,
    );
    state = newSettings;
    _settingsBox.put('user_settings', newSettings);
  }

  void updateBackgroundColor(int color) {
    final newSettings = UserSettings(
      fontSize: state.fontSize,
      fontColor: state.fontColor,
      backgroundColor: color,
    );
    state = newSettings;
    _settingsBox.put('user_settings', newSettings);
  }
}

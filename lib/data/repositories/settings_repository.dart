import 'package:shared_preferences/shared_preferences.dart';

import '../database/database_helper.dart';

// Stores lightweight key/value preferences.
class SettingsRepository {
  static const themeModeKey = 'theme_mode';
  static const localeKey = 'locale';

  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<String?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(themeModeKey);
    if (stored != null) return stored;
    return _databaseHelper.getSetting(themeModeKey);
  }

  Future<void> setThemeMode(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(themeModeKey, value);
    await _databaseHelper.upsertSetting(key: themeModeKey, value: value);
  }

  Future<String?> getLocaleCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(localeKey);
  }

  Future<void> setLocaleCode(String? value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      await prefs.remove(localeKey);
    } else {
      await prefs.setString(localeKey, value);
    }
  }
}

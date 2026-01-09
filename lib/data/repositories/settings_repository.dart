import '../database/database_helper.dart';

// Stores lightweight key/value preferences.
class SettingsRepository {
  static const themeModeKey = 'theme_mode';

  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<String?> getThemeMode() async {
    return _databaseHelper.getSetting(themeModeKey);
  }

  Future<void> setThemeMode(String value) async {
    await _databaseHelper.upsertSetting(key: themeModeKey, value: value);
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesPlugin {
  static Future<SharedPreferences> _getPrefs() async {
    return SharedPreferences.getInstance();
  }

  static Future<void> setBool(String k, bool v) async {
    final prefs = await _getPrefs();
    await prefs.setBool(k, v);
  }

  static Future<bool?> getBool(String k) async {
    final prefs = await _getPrefs();
    return prefs.getBool(k);
  }
}

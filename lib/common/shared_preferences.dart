import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static final String _userIdPrefs = 'USER_ID';

  static Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_userIdPrefs) ?? null;
  }

  static void remove() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}

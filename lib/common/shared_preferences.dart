import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunday_note/entity/memo_entity.dart';

class SharedPreference {
  static final String _userEmailPrefs = 'USER_EMAIL';
  static final String _userNamePrefs = 'USER_NAME';

  /// userEmail 가져오기
  static Future<String> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_userEmailPrefs) ?? null;
  }

  /// userEmail 저장하기
  static Future<bool> setUserEmail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_userEmailPrefs, value);
  }

  static void remove() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}

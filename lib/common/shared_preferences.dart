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

  /// folder 이름 추가하기
  static Future<bool> addFolder(String folderName, List<String> folder) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print('*** clicked addFolder ***');
    print('folderName : $folderName');
    print('folder : $folder');
    return await prefs.setStringList(folderName, folder);
  }

  /// folder 이름 가져오기
  static Future<List<String>> getFolderName(String folderName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print('*** clicked getFolderName ***');
    print('getFolderName : $folderName');
    print('getFolderNamdFunc : ${prefs.getStringList(folderName)}');
    return prefs.getStringList(folderName);
  }

  /// folder 삭제
  static Future<List<String>> removeFolder(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> folderList = prefs.getStringList('folder');
    print('before delete : $folderList');
    folderList.removeAt(index);
    print('after delete ;$folderList');
    return folderList;
  }

  /// memo 추가하기
  static Future<bool> addMemo(String folderName, List<String> memoList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print('***clicked addMemo***');
    print('folderName: $folderName');
    print('memoList : $memoList');

    return await prefs.setStringList(folderName, memoList);
  }

  /// memo 불러오기
  static Future<List<String>> getMemoList(String folderName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(folderName);
  }
}

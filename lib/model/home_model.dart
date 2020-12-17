import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunday_note/common/shared_preferences.dart';

class HomeModel extends ChangeNotifier {
  List<String> _folderName = [];

  int _memoListCnt = 0;

  List<String> get folderList => _folderName;

  int get folderListCnt => _folderName.length ?? 0;

  SharedPreferences prefs;

  void changeMemoCnt(int value) {
    _memoListCnt = value;
    notifyListeners();
  }

  void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    loadFolder();
  }

  void addFolder(String value) {
    _folderName.add(value);
    prefs.setStringList('folder', _folderName);
    notifyListeners();
  }

  void loadFolder() {
    print('HomeModel : Load Folder');
    // prefs.setStringList('folder', _folderName);
    List<String> spFolderList = prefs.getStringList('folder') ?? [];
    _folderName = spFolderList;
    notifyListeners();
  }

  void removeFolderName(int value) {
    _folderName.removeAt(value);
    prefs.setStringList('folder', _folderName);
    notifyListeners();
  }

// ///삭제
// void addFolderName(String value) {
//   _folderName.add(value);
//   print('####addFolderName####');
//   // SharedPreference.addFolder('folder', _folderName);
//   // print(SharedPreference.getFolderName('folder'));
//   notifyListeners();
// }
//
// void addMemoCnt(int value) {
//   _memoListCnt = value;
//   notifyListeners();
// }
//
// void changeFolderList(List<String> value) {
//   _folderName = value;
//   notifyListeners();
// }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunday_note/common/shared_preferences.dart';

class HomeModel extends ChangeNotifier {
  List<String> _folderName = [];

  int _memoListCnt = 0;

  bool _folderDuplicate = false;

  List<String> get folderList => _folderName;

  int get folderListCnt => _folderName.length ?? 0;

  bool get checkDuplicateFolderName => _folderDuplicate;

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
    List<String> spFolderList = prefs.getStringList('folder') ?? [];
    _folderName = spFolderList;
    notifyListeners();
  }

  void removeFolderName(int value) {
    _folderName.removeAt(value);
    prefs.setStringList('folder', _folderName);
    notifyListeners();
  }

  void checkDuplicateFN(String value) {
    _folderDuplicate = false;
    for (int i = 0; i < _folderName.length; i++) {
      if (value == _folderName[i]) {
        _folderDuplicate = true;
        break;
      }
    }
    notifyListeners();
  }

  int memoListCnt(String value) {
    var memoCnt = prefs.getStringList(value)?.length ?? 0;
    return memoCnt;
  }
}

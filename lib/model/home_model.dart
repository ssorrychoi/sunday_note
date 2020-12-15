import 'package:flutter/material.dart';
import 'package:sunday_note/common/shared_preferences.dart';

class HomeModel extends ChangeNotifier {
  List<String> _folderName = [];

  List<String> get getFolderName => _folderName;

  int get getFolderCnt => _folderName.length;

  void addFolderName(String value) {
    _folderName.add(value);
    print('####addFolderName####');
    // SharedPreference.addFolder('folder', _folderName);
    // print(SharedPreference.getFolderName('folder'));
    notifyListeners();
  }

  void removeFolderName(int value) {
    _folderName.removeAt(value);
    SharedPreference.addFolder('folder', _folderName);
    print('removeFolderName @');
    print(_folderName);
    SharedPreference.addFolder('folder', _folderName);
    print('####removeFolder###');
    // print(SharedPreference.getFolderName('folder'));
    notifyListeners();
  }

  /// Default 폴더 생성
// List<String> _defaultFolder = [];
// List<String> get getDefaultFolder => _defaultFolder;
// void addDefaultFolderName(String value) {
//   _defaultFolder.add(value);
//   notifyListeners();
// }
//
// void removeDefaultFolder(int value) {
//   _defaultFolder.removeAt(value);
//   notifyListeners();
// }
}

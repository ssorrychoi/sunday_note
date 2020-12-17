import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunday_note/entity/memo_entity.dart';

class MemoListModel extends ChangeNotifier {
  List<Memo> _memoList = [];

  List<String> _jsonMemoList = [];

  // List<Memo> get getMemoList => _memoList;

  List<String> get getJsonMemoList => _jsonMemoList;

  int get memoJsonListCnt => _jsonMemoList.length ?? 0;

  SharedPreferences prefs;

  void initSharedPreferences(String folderName) async {
    prefs = await SharedPreferences.getInstance();
    loadMemoList(folderName);
    notifyListeners();
  }

  void addMemoList(String folderName, Memo value) {
    _memoList.add(value);
    String jsonMemo =
        '{"date" : "${value.date}","title":"${value.title}","words":"${value.words}","contents":"${value.contents.toString().split('\n').join(('\\n'))}"}';
    _jsonMemoList.add(jsonMemo);
    prefs.setStringList(folderName, _jsonMemoList);

    notifyListeners();
  }

  void loadMemoList(String folderName) {
    print('MemoListModel : Load Memo List');
    List<String> spMemoList = prefs.getStringList(folderName) ?? [];
    _jsonMemoList = spMemoList;

    notifyListeners();
  }

  void removeMemo(String folderName, int index) {
    _memoList.removeAt(index);
    _jsonMemoList.removeAt(index);
    prefs.setStringList(folderName, _jsonMemoList);
    notifyListeners();
  }

  void addMemoListSP(String value) {
    _jsonMemoList.add(value);

    notifyListeners();
  }

  /// 폴더 옆에 메모 카운트
// int _memoCount = 0;
// int get getMemoListCnt => _memoCount;
// void changeMemoCount(int value) {
//   _memoCount = value;
//   notifyListeners();
// }
}

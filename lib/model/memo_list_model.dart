import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunday_note/entity/memo_entity.dart';

class MemoListModel extends ChangeNotifier {
  List<Memo> _memoList = [];

  List<String> _jsonMemoList = [];

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
    List<String> spMemoList = prefs.getStringList(folderName) ?? [];
    _jsonMemoList = spMemoList;

    notifyListeners();
  }

  void removeMemo(String folderName, int index) {
    print('before : ${prefs.getStringList(folderName)}');
    _memoList.removeAt(index);
    _jsonMemoList.removeAt(index);
    prefs.setStringList(folderName, _jsonMemoList);
    print('after :${prefs.getStringList(folderName)}');
    notifyListeners();
  }

  void addMemoListSP(String value) {
    _jsonMemoList.add(value);

    notifyListeners();
  }
}

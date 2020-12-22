import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunday_note/entity/memo_entity.dart';

class MemoListModel extends ChangeNotifier {
  List<Memo> _memoList = [];

  List<String> _jsonMemoList = [];

  List<String> get getJsonMemoList => _jsonMemoList;

  int get memoJsonListCnt => _jsonMemoList.length ?? 0;

  SharedPreferences prefs;

  Memo _memo;

  Memo get getMemo => _memo;

  void addMemo(String date, String title, String words, String contents,
      String speaker) {
    _memo = Memo(
        date: date,
        title: title,
        words: words,
        contents: contents,
        speaker: speaker);
    notifyListeners();
  }

  void initSharedPreferences(String folderName) async {
    prefs = await SharedPreferences.getInstance();
    loadMemoList(folderName);
    notifyListeners();
  }

  void addMemoList(String folderName, Memo value) {
    _memoList.add(value);
    String jsonMemo =
        '{"date" : "${value.date}","title":"${value.title}","words":"${value.words}","contents":"${value.contents.toString().split('\n').join(('\\n'))}","speaker":"${value.speaker}"}';
    _jsonMemoList.add(jsonMemo);
    prefs.setStringList(folderName, _jsonMemoList);

    notifyListeners();
  }

  void loadMemoList(String folderName) {
    List<String> spMemoList = prefs.getStringList(folderName) ?? [];
    _jsonMemoList = spMemoList;

    notifyListeners();
  }

  void updateMemoList(String folderName, int value, Memo memo) {
    List<String> spMemoList = prefs.getStringList(folderName);
    _jsonMemoList = spMemoList;
    _jsonMemoList[value] =
        '{"date" : "${memo.date}","title":"${memo.title}","words":"${memo.words}","contents":"${memo.contents.toString().split('\n').join(('\\n'))}","speaker":"${memo.speaker}"}';

    print(spMemoList[value]);
    print(_jsonMemoList[value]);
    prefs.setStringList(folderName, _jsonMemoList);
    notifyListeners();
  }

  void removeMemo(String folderName, int index) {
    List<String> spMemoList = prefs.getStringList(folderName);
    _jsonMemoList = spMemoList;

    _jsonMemoList.removeAt(index);
    prefs.setStringList(folderName, _jsonMemoList);

    notifyListeners();
  }

  void addMemoListSP(String value) {
    _jsonMemoList.add(value);

    notifyListeners();
  }
}

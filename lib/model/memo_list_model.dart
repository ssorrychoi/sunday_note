import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunday_note/entity/memo_entity.dart';

class MemoListModel extends ChangeNotifier {
  // List<Memo> _memoList = [];

  List<String> _jsonMemoList = [];

  List<String> get getJsonMemoList => _jsonMemoList;

  String _sorting = '오래된순';

  bool _backButton = false;

  int get memoJsonListCnt => _jsonMemoList.length ?? 0;

  SharedPreferences prefs;

  Memo _memo;

  Memo get getMemo => _memo;

  String get sortingMemo => _sorting;

  bool get backButtonState => _backButton;

  void changeBackBtnState(bool value) {
    _backButton = value;
    notifyListeners();
  }

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
    // _memoList.add(value);
    // List<String> spMemoList = prefs.getStringList(folderName);
    // _jsonMemoList = spMemoList;
    String jsonMemo =
        '{"date" : "${value.date}","title":"${value.title}","words":"${value.words}","contents":"${value.contents.toString().split('\n').join(('\\n'))}","speaker":"${value.speaker}"}';
    // print('_sorting : $_sorting');
    //
    // if (_sorting == '최신순') {
    //   print('add : 최신순일때');
    //   _memoList.insert(0, value);
    //   _jsonMemoList.insert(0, jsonMemo);
    //   print('memoList : $_memoList');
    //   print('_jsonMemoList : $_jsonMemoList');
    // } else {
    //   print('add : 오래된순일때');
    //   _memoList.add(value);
    //   _jsonMemoList.add(jsonMemo);
    //   print('memoList : $_memoList');
    //   print('_jsonMemoList : $_jsonMemoList');
    // }

    _jsonMemoList.add(jsonMemo);
    prefs.setStringList(folderName, _jsonMemoList);

    notifyListeners();
  }

  void loadMemoList(String folderName) {
    List<String> spMemoList = prefs.getStringList(folderName) ?? [];
    _jsonMemoList = spMemoList;
    print('loadMemoList : $_jsonMemoList');
    print('_sorting : $_sorting');

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
    // List<String> spMemoList = prefs.getStringList(folderName);
    // _jsonMemoList = spMemoList;

    _jsonMemoList.removeAt(index);
    prefs.setStringList(folderName, _jsonMemoList);

    notifyListeners();
  }

  void changeListing(String value) {
    _sorting = value;
    notifyListeners();
  }

  void reverseListing(String value, String folderName) {
    List<String> spMemoList = prefs.getStringList(folderName);
    _jsonMemoList = spMemoList;
    print('넘어온 값 : $value');
    print('_sorting : $_sorting');
    if (value == '최신순') {
      print('최신순일때');
      _jsonMemoList = _jsonMemoList.reversed.toList();
    }

    notifyListeners();
  }
}

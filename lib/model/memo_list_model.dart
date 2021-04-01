import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunday_note/common/strings.dart';
import 'package:sunday_note/entity/memo_entity.dart';

class MemoListModel extends ChangeNotifier {
  // List<Memo> _memoList = [];

  List<String> _jsonMemoList = [];

  /// 가상 List
  List<String> _jsonListingMemoList = [];

  // List<String> get jsonMemoList => _jsonMemoList;

  /// 가상 List
  List<String> get jsonListingMemoList => _jsonListingMemoList;

  String _sorting = Strings.oldSorting;

  bool _backButton = false;

  int get memoJsonListCnt => _jsonMemoList.length ?? 0;

  /// 가상 List
  int get jsonListMemoListCnt => _jsonListingMemoList.length ?? 0;

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
    // print('===Add Memo List===');
    String jsonMemo =
        '{"date" : "${value.date}","title":"${value.title}","words":"${value.words}","contents":"${value.contents.toString().split('\n').join(('\\n'))}","speaker":"${value.speaker}"}';

    if (_sorting == Strings.newSorting) {
      // print('add : 최신순일때');

      /// 가상List에 추가
      _jsonListingMemoList.insert(0, jsonMemo);
      // print('_jsonMemoList : $_jsonMemoList');
      // print('가상List : $_jsonListingMemoList');
    }

    ///실제 List에 추가
    _jsonMemoList.add(jsonMemo);
    prefs.setStringList(folderName, _jsonMemoList);

    notifyListeners();
  }

  void loadMemoList(String folderName) {
    List<String> spMemoList = prefs.getStringList(folderName) ?? [];
    _jsonMemoList = spMemoList;
    _jsonListingMemoList = spMemoList;
    // print('===Load Memo List===');
    // print('loadMemoList : $_jsonMemoList');
    // print('_sorting : $_sorting');
    // print('memoListing : $_jsonListingMemoList');
    notifyListeners();
  }

  void updateMemoList(String folderName, int value, Memo memo, String sorting) {
    // print('===Update Memo List===');
    // print('index : $value');
    // print('sorting: $sorting');
    // print('folderName : $folderName');
    if (sorting == Strings.newSorting) {
      // print('--최신순--');
      value = _jsonListingMemoList.length - value - 1;
      // print(value);
      // print(_jsonMemoList[value]);
      _jsonMemoList[value] =
          '{"date" : "${memo.date}","title":"${memo.title}","words":"${memo.words}","contents":"${memo.contents.toString().split('\n').join(('\\n'))}","speaker":"${memo.speaker}"}';
      // print(_jsonMemoList[value]);
      _jsonListingMemoList = _jsonMemoList.reversed.toList();
      // print(_jsonListingMemoList);
      prefs.setStringList(folderName, _jsonMemoList);
      notifyListeners();
    } else {
      List<String> spMemoList = prefs.getStringList(folderName);
      _jsonMemoList = spMemoList;
      // print('--오래된순--');
      // print(value);
      // print(_jsonMemoList[value]);
      _jsonMemoList[value] =
          '{"date" : "${memo.date}","title":"${memo.title}","words":"${memo.words}","contents":"${memo.contents.toString().split('\n').join(('\\n'))}","speaker":"${memo.speaker}"}';
      // print(_jsonMemoList[value]);
      _jsonListingMemoList = _jsonMemoList;
      // print(_jsonListingMemoList);
      prefs.setStringList(folderName, _jsonListingMemoList);
      notifyListeners();
    }
  }

  void removeMemo(String folderName, int index) {
    // List<String> spMemoList = prefs.getStringList(folderName);
    // _jsonMemoList = spMemoList;

    // print('===Remove Memo===');
    _jsonMemoList.removeAt(index);
    prefs.setStringList(folderName, _jsonMemoList);

    notifyListeners();
  }

  void changeListing(String value) {
    _sorting = value;
    notifyListeners();
  }

  void reverseListing(String value, String folderName) {
    // List<String> spMemoList = prefs.getStringList(folderName);
    // _jsonMemoList = spMemoList;
    // print('넘어온 값 : $value');
    // print('_sorting : $_sorting');
    // if (value == '최신순') {
    //   print('최신순일때');
    //   _jsonMemoList = _jsonMemoList.reversed.toList();
    // }

    if (value == Strings.newSorting) {
      // print('최신순');
      _jsonListingMemoList = _jsonMemoList.reversed.toList();
    } else {
      _jsonListingMemoList = _jsonMemoList;
    }
    notifyListeners();
  }
}

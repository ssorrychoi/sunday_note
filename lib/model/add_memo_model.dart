import 'package:flutter/material.dart';
import 'package:sunday_note/entity/memo_entity.dart';

class AddMemoModel extends ChangeNotifier {
  Memo _memoList;

  Memo get getMemo => _memoList;

  void addMemo(String date, String title, String words, String contents) {
    _memoList =
        Memo(date: date, title: title, words: words, contents: contents);
    notifyListeners();
  }
}

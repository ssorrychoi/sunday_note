import 'package:flutter/material.dart';
import 'package:sunday_note/entity/memo_entity.dart';

class MemoListModel extends ChangeNotifier {
  List<Memo> _memoList = [];

  List<String> _jsonMemoList = [];

  List<Memo> get getMemoList => _memoList;

  List<String> get getJsonMemoList => _jsonMemoList;

  int get getMemoListCnt => _memoList.length;

  void addMemoList(Memo value) {
    _memoList.add(value);
    _jsonMemoList.add(Memo.encode(_memoList));
    // print('add Memo : $_memoList');
    // print('************************');
    // print(_memoList);
    // print('************************');
    // print('========================');
    // print(_jsonMemoList);
    // print('========================');
    notifyListeners();
  }
}

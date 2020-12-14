import 'dart:convert';

class Memo {
  String date;
  String title;
  String words;
  String contents;

  Memo({this.date, this.title, this.words, this.contents});

  Memo.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    title = json['title'];
    words = json['words'];
    contents = json['contents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['title'] = this.title;
    data['words'] = this.words;
    data['contents'] = this.contents;
    return data;
  }

  static Map<String, dynamic> toMap(Memo memo) => {
        'date': memo.date,
        'title': memo.title,
        'words': memo.words,
        'contents': memo.contents
      };

  static String encode(List<Memo> memoList) => json.encode(
      memoList.map<Map<String, dynamic>>((memo) => Memo.toMap(memo)).toList());

  static List<Memo> decode(String memo) => (json.decode(memo) as List<dynamic>)
      .map<Memo>((item) => Memo.fromJson(item))
      .toList();
}

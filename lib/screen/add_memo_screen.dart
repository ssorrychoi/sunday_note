import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunday_note/common/shared_preferences.dart';
import 'package:sunday_note/common/theme.dart';
import 'package:sunday_note/entity/memo_entity.dart';
import 'package:sunday_note/model/add_memo_model.dart';
import 'package:sunday_note/model/memo_list_model.dart';

class AddMemoScreen extends StatefulWidget {
  final String dateText;
  final String titleText;
  final String wordsText;
  final String contentsText;
  final String folderName;
  final String speaker;

  AddMemoScreen(
      {this.dateText,
      this.titleText,
      this.wordsText,
      this.contentsText,
      this.folderName,
      this.speaker});

  @override
  _AddMemoScreenState createState() => _AddMemoScreenState();
}

class _AddMemoScreenState extends State<AddMemoScreen> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController wordsController = TextEditingController();
  final TextEditingController contentsController = TextEditingController();
  final TextEditingController speakerController = TextEditingController();

  // AddMemoModel _model;

  MemoListModel _model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateController.text = widget.dateText ??
        "${DateTime.now().year}년 ${DateTime.now().month}월 ${DateTime.now().day}일";
    titleController.text = widget.titleText ?? '';
    wordsController.text = widget.wordsText ?? '';
    contentsController.text = widget.contentsText ?? '';
    speakerController.text = widget.speaker ?? '';
    _model = Provider.of<MemoListModel>(context, listen: false);
    // _memoModel = Provider.of<MemoListModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        brightness: Brightness.light,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: textBlackColor,
          onPressed: () => Navigator.pop(context),
        ),

        /// Share Icon
        actions: [
          // IconButton(
          //     icon: Icon(
          //       Icons.share_outlined,
          //       color: textBlackColor,
          //     ),
          //     onPressed: null)
          IconButton(
              icon: Icon(
                Icons.save_outlined,
                color: textBlackColor,
              ),
              onPressed: () async {
                print('clicked Save Button');
                _model.addMemo(
                    dateController.text,
                    titleController.text,
                    wordsController.text,
                    contentsController.text,
                    speakerController.text);
                // await print(_model.getMemo.title);
                // print(widget.folderName);
                // await _model.addMemoList(widget.folderName, _model.getMemo);
                Navigator.pop(context, _model.getMemo);
              })
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    '날짜',
                    style: CustomTextTheme.notoSansRegular3
                        .copyWith(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: dateController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 16),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    '제목',
                    style: CustomTextTheme.notoSansRegular3
                        .copyWith(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: titleController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 16),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    '설교자',
                    style: CustomTextTheme.notoSansRegular3
                        .copyWith(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: speakerController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 16),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    '본문',
                    style: CustomTextTheme.notoSansRegular3
                        .copyWith(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: wordsController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 16),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    '내용',
                    style: CustomTextTheme.notoSansRegular3
                        .copyWith(color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: contentsController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 10,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 16, top: 16),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
                const SizedBox(height: 20),
                // Container(
                //   height: 50,
                //   child: SizedBox.expand(
                //     child: RaisedButton(
                //       color: Colors.black,
                //       textColor: Colors.white,
                //       child: Text('저장',
                //           style: CustomTextTheme.notoSansRegular3
                //               .copyWith(color: Colors.white)),
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(50)),
                //       onPressed: () {
                //         ///TODO Save Function
                //         _model.addMemo(
                //             dateController.text,
                //             titleController.text,
                //             wordsController.text,
                //             contentsController.text);
                //
                //         Navigator.pop(context, _model.getMemo);
                //         // _memoModel.addMemoList(widget.folderName, _model.getMemo)
                //       },
                //     ),
                //   ),
                // ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

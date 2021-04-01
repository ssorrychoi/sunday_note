import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:sunday_note/common/strings.dart';
import 'package:sunday_note/common/theme.dart';
import 'package:sunday_note/model/memo_list_model.dart';
import 'package:sunday_note/widget/custom_button_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AddMemoArgs {
  final String dateText;
  final String titleText;
  final String wordsText;
  final String contentsText;
  final String folderName;
  final String speaker;

  AddMemoArgs(
      {this.dateText,
      this.titleText,
      this.wordsText,
      this.contentsText,
      this.folderName,
      this.speaker});
}

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

  // final _controller = Completer<WebViewController>();

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
  void dispose() {
    // TODO: implement dispose
    dateController.dispose();
    titleController.dispose();
    wordsController.dispose();
    contentsController.dispose();
    speakerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          brightness: Brightness.light,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: textBlackColor,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomButtonDialog(
                        // title: '저장함?',
                        message: Strings.dialogMsg,
                        confirmText: Strings.yesBtn,
                        cancelText: Strings.noBtn,
                        onPressedCancel: () {
                          Navigator.pop(context, false);
                        },
                        onPressedConfirm: () {
                          Navigator.pop(context, true);
                        });
                  }).then((value) {
                if (value == null) {
                  null;
                } else if (value) {
                  Navigator.pop(context);
                }
              });
            },
          ),

          /// Share Icon
          actions: [
            IconButton(
                icon: Icon(
                  Icons.share_outlined,
                  color: textBlackColor,
                ),
                onPressed: () {
                  Share.share(
                      '📅 ${dateController.text}\n\n💌 ${titleController.text}\n\n📝 ${wordsController.text}\n\n🎤 ${speakerController.text}\n\n✏️ ${contentsController.text}\n\n\n');
                }),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: TextButton(
                child: Text(
                  'Save',
                  style: CustomTextTheme.notoSansRegular2,
                ),
                onPressed: () {
                  _model.addMemo(
                      dateController.text,
                      titleController.text,
                      wordsController.text,
                      contentsController.text,
                      speakerController.text);
                  Navigator.pop(context, _model.getMemo);
                },
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      Strings.date,
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
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
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
                      Strings.title,
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
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
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
                      Strings.mainSpeaker,
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
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
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
                      Strings.words,
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
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.grey, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                  // Text('말씀'),
                  const SizedBox(height: 8),

                  // const SizedBox(height: 20),
                  // SizedBox(
                  //   height: 200,
                  //   child: WebView(
                  //     initialUrl: "http://www.naver.com",
                  //     javascriptMode: JavascriptMode.unrestricted,
                  //     onWebViewCreated: (WebViewController webViewController) {
                  //       _controller.complete(webViewController);
                  //     },
                  //     onPageFinished: (url) {
                  //       print(url);
                  //       setState(() {
                  //         // _isLoading = false;
                  //       });
                  //     },
                  //   ),
                  // ),

                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      Strings.contents,
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
                      contentPadding:
                          const EdgeInsets.only(left: 16, top: 18, right: 16),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

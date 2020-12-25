import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunday_note/common/theme.dart';
import 'package:sunday_note/entity/memo_entity.dart';
import 'package:sunday_note/model/memo_list_model.dart';
import 'package:sunday_note/screen/add_memo_screen.dart';
import 'package:sunday_note/widget/memo_list_item.dart';

class MemoListScreen extends StatefulWidget {
  final String folderName;

  MemoListScreen({this.folderName});

  @override
  _MemoListScreenState createState() => _MemoListScreenState();
}

class _MemoListScreenState extends State<MemoListScreen> {
  MemoListModel _model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = Provider.of<MemoListModel>(context, listen: false);
    _model.initSharedPreferences(widget.folderName);
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
          onPressed: () {
            Navigator.pop(context, _model.memoJsonListCnt);
          },
        ),
      ),
      body: SafeArea(
          child: CustomScrollView(slivers: [
        Selector<MemoListModel, int>(
            selector: (context, data) => data.memoJsonListCnt,
            builder: (context, memoCnt, _) {
              return memoCnt == 0
                  ? SliverList(
                      delegate: SliverChildListDelegate([
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.folderName,
                              maxLines: 3,
                              style: CustomTextTheme.notoSansBold1,
                            ),
                            const SizedBox(height: 110),
                            Column(
                              children: [
                                Image(
                                  image: AssetImage(
                                      'assets/images/home_illust_bible.png'),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  '메모를 추가해주세요.',
                                  style: CustomTextTheme.notoSansRegular1,
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ]))
                  : SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.folderName,
                                maxLines: 3,
                                style: CustomTextTheme.notoSansBold2,
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Total $memoCnt',
                                  style: CustomTextTheme.notoSansRegular3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    );
            }),
        Selector<MemoListModel, int>(
            selector: (context, data) => data.memoJsonListCnt,
            builder: (context, memoCnt, _) {
              return Selector<MemoListModel, List<String>>(
                  selector: (context, data) => data.getJsonMemoList,
                  builder: (context, memoList, _) {
                    return SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Dismissible(
                                  key: UniqueKey(),
                                  background: Container(
                                    color: Colors.red,
                                  ),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    _model.removeMemo(widget.folderName, index);
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text('메모가 삭제되었습니다.')));
                                  },
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      /// Add Memo Screen 으로 이동
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChangeNotifierProvider(
                                                    create: (context) =>
                                                        MemoListModel(),
                                                    child: AddMemoScreen(
                                                      dateText: Memo.fromJson(
                                                              jsonDecode(
                                                                  memoList[
                                                                      index]))
                                                          .date,
                                                      titleText: Memo.fromJson(
                                                              jsonDecode(
                                                                  memoList[
                                                                      index]))
                                                          .title,
                                                      wordsText: Memo.fromJson(
                                                              jsonDecode(
                                                                  memoList[
                                                                      index]))
                                                          .words,
                                                      contentsText: Memo.fromJson(
                                                              jsonDecode(
                                                                  memoList[
                                                                      index]))
                                                          .contents,
                                                      speaker: Memo.fromJson(
                                                              jsonDecode(
                                                                  memoList[
                                                                      index]))
                                                          .speaker,
                                                      folderName:
                                                          widget.folderName,
                                                    ),
                                                  ))).then((value) {
                                        if (value != null) {
                                          _model.updateMemoList(
                                              widget.folderName, index, value);
                                        }
                                      });
                                    },
                                    child: MemoListItem(
                                        Memo.fromJson(
                                            jsonDecode(memoList[index])),
                                        widget.folderName),
                                  ),
                                )),
                            childCount: memoCnt));
                  });
            })
      ])

          //   }
          // })
          ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 26),
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                              create: (context) => MemoListModel(),
                            ),
                          ],
                          child: AddMemoScreen(
                            folderName: widget.folderName,
                          )))).then((value) {
            if (value != null) {
              _model.addMemoList(widget.folderName, value);
            }
          });
        },
      ),
    );
  }
}

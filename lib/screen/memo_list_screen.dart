import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunday_note/common/strings.dart';
import 'package:sunday_note/common/theme.dart';
import 'package:sunday_note/entity/memo_entity.dart';
import 'package:sunday_note/model/memo_list_model.dart';
import 'package:sunday_note/screen/add_memo_screen.dart';
import 'package:sunday_note/service/analytics_service.dart';
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
    AnalyticsService().logSetScreen('MemoListScreen');
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
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                widget.folderName,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
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
                                    Strings.addMemo,
                                    style: CustomTextTheme.notoSansRegular1,
                                  )
                                ],
                              ),
                            ],
                          ),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Selector<MemoListModel, String>(
                                      selector: (context, data) =>
                                          data.sortingMemo,
                                      builder: (context, sortingValue, _) {
                                        return DropdownButton(
                                            value: sortingValue,
                                            icon: Icon(Icons.arrow_drop_down),
                                            items: <String>[
                                              Strings.oldSorting,
                                              Strings.newSorting
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String newValue) {
                                              // print('onChange : $newValue');
                                              _model.changeListing(newValue);
                                              _model.reverseListing(
                                                  newValue, widget.folderName);
                                              // newValue == '최신순'
                                              //     ? _model.reverseListing(
                                              //         newValue,
                                              //         widget.folderName)
                                              //     : _model.loadMemoList(
                                              //         widget.folderName);
                                            });
                                      }),
                                  Text(
                                    '${Strings.total} $memoCnt',
                                    style: CustomTextTheme.notoSansRegular3,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                    );
            }),
        Selector<MemoListModel, int>(
            selector: (context, data) => data.jsonListMemoListCnt,
            builder: (context, memoCnt, _) {
              return Selector<MemoListModel, List<String>>(
                  selector: (context, data) => data.jsonListingMemoList,
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
                                        content: Text(Strings.removeMemoMsg)));
                                  },
                                  child: Selector<MemoListModel, String>(
                                      selector: (context, data) =>
                                          data.sortingMemo,
                                      builder: (context, sorting, _) {
                                        return InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                                            folderName: widget
                                                                .folderName,
                                                          ),
                                                        ))).then((value) {
                                              if (value != null) {
                                                // print(value.title);
                                                _model.updateMemoList(
                                                    widget.folderName,
                                                    index,
                                                    value,
                                                    sorting);
                                              }
                                            });
                                          },
                                          child: MemoListItem(
                                              Memo.fromJson(
                                                  jsonDecode(memoList[index])),
                                              widget.folderName),
                                        );
                                      }),
                                )),
                            childCount: memoCnt));
                  });
            }),
        SliverList(
            delegate: SliverChildListDelegate([const SizedBox(height: 100)]))
      ])

          //   }
          // })
          ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 51),
        child: FloatingActionButton(
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
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunday_note/common/shared_preferences.dart';
import 'package:sunday_note/common/theme.dart';
import 'package:sunday_note/entity/memo_entity.dart';
import 'package:sunday_note/model/add_memo_model.dart';
import 'package:sunday_note/model/memo_list_model.dart';
import 'package:sunday_note/screen/add_memo_screen.dart';

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
            Navigator.pop(context);
          },
        ),
        // actions: [
        //   IconButton(
        //       icon: Icon(
        //         Icons.share_outlined,
        //         color: textBlackColor,
        //       ),
        //       onPressed: null)
        // ],
      ),
      body: SafeArea(
          child:
              // FutureBuilder(
              //   future: SharedPreference.getMemoList(widget.folderName),
              //   builder: (context, snapshot) {
              //     print('memoList snapshot : ${snapshot.data}');
              //     print('0번째 : ${snapshot.data[0]}');
              //     print('1번째 : ${snapshot.data[1]}');
              //     if (snapshot.hasData) {
              //       return
              Selector<MemoListModel, int>(
                  selector: (context, data) => data.getMemoListCnt,
                  builder: (context, memoListCnt, _) {
                    return CustomScrollView(slivers: [
                      SliverList(
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
                                    'Total 12',
                                    style: CustomTextTheme.notoSansRegular3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),

                      Selector<MemoListModel, List<Memo>>(
                          selector: (context, data) => data.getMemoList,
                          builder: (context, memoList, _) {
                            return SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) => Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Card(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChangeNotifierProvider(
                                                              create: (context) =>
                                                                  AddMemoModel(),
                                                              child:
                                                                  AddMemoScreen(
                                                                dateText: _model
                                                                    .getMemoList[
                                                                        index]
                                                                    .date,
                                                                titleText: _model
                                                                    .getMemoList[
                                                                        index]
                                                                    .title,
                                                                wordsText: _model
                                                                    .getMemoList[
                                                                        index]
                                                                    .words,
                                                                contentsText: _model
                                                                    .getMemoList[
                                                                        index]
                                                                    .contents,
                                                              ),
                                                            ))).then((value) {
                                                  if (value == null) {
                                                    null;
                                                  }
                                                });
                                              },
                                              onDoubleTap: null,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                    bottom: 10,
                                                    top: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            'title',
                                                            // snapshot
                                                            //     .data[index].title,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: CustomTextTheme
                                                                .notoSansRegular3,
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: topBgColor,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5))),
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8,
                                                                  right: 8,
                                                                  top: 4,
                                                                  bottom: 4),
                                                          child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                'words',
                                                                // snapshot.data[index]
                                                                //     .words,
                                                                style: CustomTextTheme
                                                                    .notoSansRegular4,
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Text(
                                                      // snapshot.data[index].contents,
                                                      'contents',
                                                      style: CustomTextTheme
                                                          .notoSansRegular4,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          // snapshot.data[index].date,
                                                          'date',
                                                          style: CustomTextTheme
                                                              .notoSansRegular4,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    childCount: memoListCnt));
                            // });
                          })
                      // })
                    ]);
                  })),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 26),
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                      create: (context) => AddMemoModel(),
                      child: AddMemoScreen()))).then((value) {
            /// memoList
            if (value != null) {
              _model.addMemoList(value);
              SharedPreference.addMemo(
                  widget.folderName, _model.getJsonMemoList);
              SharedPreference.getMemoList(widget.folderName)
                  .then((value) => print('value : $value'));
              print('memoListScreen : ${_model.getMemoList}');
            }
          });
        },
      ),
    );
  }
}

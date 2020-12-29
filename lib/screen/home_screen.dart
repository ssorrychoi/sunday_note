import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunday_note/common/theme.dart';
import 'package:sunday_note/model/home_model.dart';
import 'package:sunday_note/screen/sponsor_screen.dart';
import 'package:sunday_note/widget/folder_list_item.dart';
import 'package:sunday_note/widget/textfield_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final TextEditingController folderNameController = TextEditingController();
  HomeModel _model;

  @override
  void initState() {
    _model = Provider.of<HomeModel>(context, listen: false);
    _model.initSharedPreferences();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: topBgColor,
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: CustomScrollView(
        slivers: [
          Selector<HomeModel, int>(
              selector: (context, data) => data.folderListCnt,
              builder: (context, folderListCnt, _) {
                return SliverList(
                    delegate: SliverChildListDelegate([
                  const SizedBox(height: 50),
                  SizedBox(
                    height: 56,
                    child: Container(color: topBgColor),
                  ),
                  Stack(
                    overflow: Overflow.visible,
                    children: [
                      folderListCnt == 0
                          ? Container(
                              height: 180,
                              color: topBgColor,
                            )
                          : Image(
                              image:
                                  AssetImage('assets/images/home_illust.png'),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: RichText(
                          text: TextSpan(
                              text: '오늘도 하나님이 내게 주신\n말씀을 노트해보세요',
                              style: CustomTextTheme.notoSansBold1,
                              children: [
                                TextSpan(
                                    text: '\n\n\t\tTotal $folderListCnt',
                                    style: CustomTextTheme.notoSansRegular1)
                              ]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            size: 32,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SponsorScreen()));
                          },
                        ),
                        InkWell(
                          child: SizedBox(
                            height: 50,
                            child: Image(
                              image: AssetImage(
                                  'assets/btns/home_btn_add_folder_nor.png'),
                            ),
                          ),
                          onDoubleTap: null,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return TextfieldDialog(
                                      title: '새로운 폴더',
                                      message: '이 폴더의 이름을 입력해주세요.',
                                      confirmText: '추가',
                                      controller: folderNameController,
                                      onPressedConfirm: () {
                                        Navigator.pop(
                                            context, folderNameController.text);
                                      });
                                }).then((value) async {
                              // print('check Duplicate : $isDuplicateFN');
                              // await _model.checkDuplicateFN(value);
                              // await print(
                              //     'check Duplicate after: $isDuplicateFN');
                              _model.checkDuplicateFN(value);

                              if (value != null &&
                                  value != '' &&
                                  !_model.checkDuplicateFolderName) {
                                folderNameController.clear();
                                print('value : $value');

                                /// model에서 추가
                                _model.addFolder(value);
                              } else if (_model.checkDuplicateFolderName) {
                                folderNameController.clear();
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text('같은 이름의 폴더명이 존재합니다.')));
                              } else {
                                folderNameController.clear();
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ]));
              }),
          Selector<HomeModel, List<String>>(
              selector: (context, data) => data.folderList,
              builder: (context, folderList, _) {
                return Selector<HomeModel, int>(
                    selector: (context, data) => data.folderListCnt,
                    builder: (context, folderCnt, _) {
                      return folderCnt == 0
                          ? SliverList(
                              delegate: SliverChildListDelegate([
                                Column(
                                  children: [
                                    const SizedBox(height: 100),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 100,
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/home_illust_bible.png'),
                                      ),
                                    ),
                                    const SizedBox(height: 18),
                                    Center(
                                        child: Text('폴더를 추가해주세요',
                                            style: CustomTextTheme.notoSansBold1
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 20))),
                                  ],
                                ),
                              ]),
                            )
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (context, index) => Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20, left: 20),
                                        child: Dismissible(

                                            ///Key 값에 문제가 있었음
                                            key: UniqueKey(),
                                            background: Container(
                                              color: Colors.red,
                                            ),
                                            direction:
                                                DismissDirection.endToStart,
                                            onDismissed: (direction) {
                                              _model.removeFolderName(index);
                                              Scaffold.of(context).showSnackBar(
                                                  SnackBar(
                                                      duration:
                                                          Duration(seconds: 2),
                                                      content: Text(
                                                          '폴더가 삭제되었습니다.')));
                                            },
                                            child: FolderListItem(
                                                folderList[index])),
                                      ),
                                  childCount: folderCnt),
                            );
                    });
              })
        ],
      ), // child: FutureBuilder(
    );
  }
}

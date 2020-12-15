import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunday_note/common/shared_preferences.dart';
import 'package:sunday_note/common/theme.dart';
import 'package:sunday_note/model/home_model.dart';
import 'package:sunday_note/model/memo_list_model.dart';
import 'package:sunday_note/screen/memo_list_screen.dart';
import 'package:sunday_note/widget/folder_list_item.dart';
import 'package:sunday_note/widget/textfield_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final TextEditingController folderNameController = TextEditingController();
  HomeModel _model;

  AnimationController _colorAnimationController;
  AnimationController _brightnessAnimationController;
  Animation _colorTween, _opacityTween, _elevationTween;

  TabController _tabController;

  List<String> list = [];

  @override
  void initState() {
    _colorAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: topBgColor)
        .animate(_colorAnimationController);
    _opacityTween =
        Tween(begin: 0.0, end: 1.0).animate(_colorAnimationController);
    _elevationTween =
        Tween(begin: 0.0, end: 2.0).animate(_colorAnimationController);

    _brightnessAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 0));

    _tabController = TabController(length: 3, vsync: this);

    _model = Provider.of<HomeModel>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _colorAnimationController.dispose();
    _brightnessAnimationController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      final currentScroll = scrollInfo.metrics.pixels;

      if (currentScroll < 200) {
        _colorAnimationController.animateTo(currentScroll / 100);
      }

      if (_colorAnimationController.value < 0.2) {
        _brightnessAnimationController.animateTo(0);
      } else {
        _brightnessAnimationController.animateTo(1);
      }

      final maxScroll = scrollInfo.metrics.maxScrollExtent;
      return true;
    }
    return false;
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
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(56),
      //   child: AnimatedBuilder(
      //     animation: _colorAnimationController,
      //     builder: (context, child) => AppBar(
      //       brightness: Brightness.light,
      //       backgroundColor: topBgColor,
      //       // elevation: 0,
      //       title: AnimatedOpacity(
      //         duration: const Duration(microseconds: 300),
      //         opacity: _opacityTween.value,
      //         child: Text(
      //           '은혜로운 예배 되세요 🔥',
      //           style: CustomTextTheme.notoSansRegular1,
      //         ),
      //       ),
      //       elevation: _elevationTween.value,
      //       centerTitle: true,
      //     ),
      //   ),
      // ),
      body: SafeArea(
          top: false,
          child: NotificationListener<ScrollNotification>(
            onNotification: _scrollListener,
            child: Selector<HomeModel, int>(
                selector: (context, data) => data.getFolderCnt,
                builder: (context, folderCnt, _) {
                  return FutureBuilder(
                      future: SharedPreference.getFolderName('folder'),
                      builder: (context, snapshot) {
                        print('###HomeScreen### ${snapshot.data}');
                        return CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildListDelegate([
                                const SizedBox(height: 50),
                                SizedBox(
                                  height: 56,
                                  child: Container(
                                    color: topBgColor,
                                  ),
                                ),
                                Stack(
                                  overflow: Overflow.visible,
                                  children: [
                                    // getFolderList.length == 0
                                    folderCnt == 0
                                        ? Container(
                                            height: 180,
                                            color: topBgColor,
                                          )
                                        : Image(
                                            image: AssetImage(
                                                'assets/images/home_illust.png'),
                                          ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 20),
                                        child: RichText(
                                          text: TextSpan(
                                              text:
                                                  '오늘도 하나님이 내게 주신\n말씀을 노트해보세요',
                                              style:
                                                  CustomTextTheme.notoSansBold1,
                                              children: [
                                                // getFolderList.length ==
                                                //         0
                                                folderCnt == 0
                                                    ? TextSpan(text: '')
                                                    : TextSpan(
                                                        text:
                                                            '\n\n\t\tTotal $folderCnt',
                                                        style: CustomTextTheme
                                                            .notoSansRegular1)
                                              ]),
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
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
                                                    message:
                                                        '이 폴더의 이름을 입력해주세요.',
                                                    confirmText: '추가',
                                                    controller:
                                                        folderNameController,
                                                    onPressedConfirm: () {
                                                      Navigator.pop(
                                                          context,
                                                          folderNameController
                                                              .text);
                                                    });
                                              }).then((value) {
                                            if (value != null && value != '') {
                                              folderNameController.clear();

                                              /// model에서 추가
                                              _model.addFolderName(value);
                                              SharedPreference.addFolder(
                                                  'folder',
                                                  _model.getFolderName);
                                              //
                                              // /// prefs에 추가
                                              // SharedPreference.addFolder(
                                              //     'folder',
                                              //     _model.getFolderName);
                                              //
                                              // /// prefs에서 가져오기
                                              // SharedPreference.getFolderName(
                                              //         'folder')
                                              //     .then((value) {
                                              //   print(
                                              //       'get Folder Name : $value');
                                              //   // _model.addFolderName(value);
                                              // });

                                              ///
                                              print(
                                                  'HomeScreen value : $value');
                                            } else {
                                              folderNameController.clear();
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ]),
                            ),
                            folderCnt == 0
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
                                              child: Text('메모를 추가해주세요',
                                                  style: CustomTextTheme
                                                      .notoSansBold1
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 20)))
                                        ],
                                      )
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
                                                  direction: DismissDirection
                                                      .endToStart,
                                                  onDismissed: (direction) {
                                                    print(
                                                        '/// Dismissible ///');
                                                    _model.removeFolderName(
                                                        index);
                                                    Scaffold.of(context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                '폴더가 삭제되었습니다.')));
                                                  },
                                                  child: FolderListItem(
                                                      snapshot.data[index])),
                                            ),
                                        childCount: snapshot.data == null
                                            ? 0
                                            : snapshot.data.length),
                                  )
                          ],
                        );
                      });
                  // }
                  // });
                }),
          )),
    );
  }
}

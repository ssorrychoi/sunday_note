import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunday_note/common/strings.dart';
import 'package:sunday_note/common/theme.dart';
import 'package:sunday_note/model/home_model.dart';
import 'package:sunday_note/routes.dart';
import 'package:sunday_note/screen/webview_screen.dart';
import 'package:sunday_note/service/analytics_service.dart';
import 'package:sunday_note/widget/folder_list_item.dart';
import 'package:sunday_note/widget/textfield_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final TextEditingController folderNameController = TextEditingController();
  HomeModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _model = Provider.of<HomeModel>(context, listen: false);
    _model.initSharedPreferences();
    AnalyticsService().logAppOpen();
    AnalyticsService().logSetScreen('HomeScreen');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: topBgColor,
        elevation: 0,
        brightness: Brightness.light,
        // toolbarHeight: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: topBgColor),
              child: Container(
                height: 100,
                alignment: Alignment.centerLeft,
                color: topBgColor,
                child: Row(
                  children: [
                    Container(height: 80, child: Image.asset('assets/images/home_illust_bible.png')),
                    Text(
                      '설교노트',
                      style: CustomTextTheme.notoSansBold1,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    title: Text(Strings.requestFunction),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebviewScreen('https://forms.gle/9uM2ShXw7A8e7p3v5'),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('기능 및 UI 오류 보고'),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebviewScreen('https://forms.gle/GXcQ1FHje1RrJE2B7'),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('버전정보 V.$version ($buildNumber)'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Selector<HomeModel, int>(
          selector: (context, data) => data.folderListCnt,
          builder: (context, folderListCnt, _) {
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Stack(
                        overflow: Overflow.visible,
                        children: [
                          folderListCnt == 0
                              ? Container(
                                  height: 200,
                                  color: topBgColor,
                                )
                              : Image(
                                  image: AssetImage('assets/images/home_illust.png'),
                                ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Strings.mainTitle,
                                  style: CustomTextTheme.notoSansBold1,
                                ),
                                SizedBox(height: 50),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    '${Strings.total} $folderListCnt',
                                    style: CustomTextTheme.notoSansRegular1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: folderListCnt == 0 ? SizedBox(height: 100) : SizedBox(height: 20),
                ),
                folderListCnt == 0
                    ? SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return TextfieldDialog(
                                          title: Strings.newFolder,
                                          message: Strings.newFolderMsg,
                                          confirmText: Strings.newFolderBtn,
                                          controller: folderNameController,
                                          onPressedConfirm: () {
                                            Navigator.pop(context, folderNameController.text);
                                          });
                                    }).then(
                                  (value) async {
                                    _model.checkDuplicateFN(value);

                                    if (value != null && value != '' && !_model.checkDuplicateFolderName) {
                                      folderNameController.clear();

                                      /// model에서 추가
                                      _model.addFolder(value);
                                    } else if (_model.checkDuplicateFolderName) {
                                      folderNameController.clear();
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(duration: Duration(seconds: 2), content: Text(Strings.duplicateFolderErrMsg)));
                                    } else {
                                      folderNameController.clear();
                                    }
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 100,
                                    child: Image(
                                      image: AssetImage('assets/images/home_illust_bible.png'),
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  Center(
                                    child: Text(
                                      Strings.addFolder,
                                      style: CustomTextTheme.notoSansBold1.copyWith(fontWeight: FontWeight.normal, fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Selector<HomeModel, List<String>>(
                        selector: (context, data) => data.folderList,
                        builder: (context, folderList, _) {
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (context, index) => Padding(
                                      padding: const EdgeInsets.only(right: 20, left: 20),
                                      child: Dismissible(
                                        ///Key 값에 문제가 있었음
                                        key: UniqueKey(),
                                        background: Container(
                                          color: Colors.red,
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.only(right: 20),
                                          child: Icon(
                                            Icons.delete_forever,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                        direction: DismissDirection.endToStart,
                                        onDismissed: (direction) {
                                          _model.removeFolderName(index);
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              duration: Duration(seconds: 2),
                                              content: Text(Strings.removeFolderMsg),
                                            ),
                                          );
                                        },
                                        child: FolderListItem(
                                          folderList[index],
                                        ),
                                      ),
                                    ),
                                childCount: folderListCnt),
                          );
                        },
                      ),
                SliverToBoxAdapter(
                  child: SizedBox(height: 40),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: topBgColor,
        hoverColor: Colors.redAccent,
        focusColor: Colors.greenAccent,
        child: Image(
          height: 45,
          image: AssetImage('assets/btns/home_btn_add_folder_nor.png'),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return TextfieldDialog(
                    title: Strings.newFolder,
                    message: Strings.newFolderMsg,
                    confirmText: Strings.newFolderBtn,
                    controller: folderNameController,
                    onPressedConfirm: () {
                      Navigator.pop(context, folderNameController.text);
                    });
              }).then(
            (value) async {
              _model.checkDuplicateFN(value);

              /// 폴더 이름이 있을경우
              if (value != null && value != '' && !_model.checkDuplicateFolderName) {
                folderNameController.clear();
                _model.addFolder(value);
              }

              /// 폴더 이름이 겹칠 경우
              else if (_model.checkDuplicateFolderName) {
                folderNameController.clear();
                scaffoldKey.currentState.showSnackBar(SnackBar(duration: Duration(seconds: 2), content: Text(Strings.duplicateFolderErrMsg)));
              } else {
                folderNameController.clear();
              }
            },
          );
        },
      ),
    );
  }
}

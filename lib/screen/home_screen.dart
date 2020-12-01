import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunday_note/common/theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool firstMemo = true;

  // final _scrollThreshold = 50.0;
  AnimationController _colorAnimationController;
  AnimationController _brightnessAnimationController;
  Animation _colorTween, _opacityTween, _elevationTween;

  // _brightnessTween;
  TabController _tabController;

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
    // _brightnessTween = Tween(begin: Brightness.light, end: Brightness.light)
    //     .animate(_brightnessAnimationController);

    _tabController = TabController(length: 3, vsync: this);

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AnimatedBuilder(
          animation: _colorAnimationController,
          builder: (context, child) => AppBar(
            brightness: Brightness.light,
            backgroundColor: topBgColor,
            // elevation: 0,
            title: AnimatedOpacity(
              duration: const Duration(microseconds: 300),
              opacity: _opacityTween.value,
              child: Text(
                '은혜로운 예배 되세요 🔥',
                style: CustomTextTheme.notoSansRegular1,
              ),
            ),
            elevation: _elevationTween.value,
            centerTitle: true,
            // backgroundColor: _colorTween.value,
            // leading: IconButton(
            //   icon: Icon(
            //     Icons.arrow_back_ios,
            //     color: Colors.green,
            //   ),
            //   onPressed: () {},
            // ),
            // actions: [
            //   IconButton(
            //     icon: Icon(
            //       Icons.arrow_forward_ios,
            //       color: Colors.green,
            //     ),
            //     onPressed: () {},
            //   )
            // ],
          ),
        ),
      ),
      body: SafeArea(
          top: false,
          child: NotificationListener<ScrollNotification>(
            onNotification: _scrollListener,
            child: CustomScrollView(
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
                        firstMemo
                            ? Container(
                                height: 180,
                                color: topBgColor,
                              )
                            : Image(
                                image:
                                    AssetImage('assets/images/home_illust.png'),
                              ),
                        Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: RichText(
                              text: TextSpan(
                                  text: '오늘도 하나님이 내게 주신\n말씀을 노트해보세요',
                                  style: CustomTextTheme.notoSansBold1,
                                  children: [
                                    firstMemo
                                        ? TextSpan(text: '')
                                        : TextSpan(
                                            text: '\n\n   Total 100',
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
                              setState(() {
                                firstMemo = !firstMemo;
                              });
                            },
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            child: SizedBox(
                              height: 50,
                              child: Image(
                                image: AssetImage(
                                    'assets/btns/home_btn_add_memo_nor.png'),
                              ),
                            ),
                            onDoubleTap: null,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 120),
                    firstMemo
                        ? Column(
                            children: [
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
                                      style: CustomTextTheme.notoSansBold1
                                          .copyWith(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 20)))
                            ],
                          )
                        : Container(),
                  ]),
                )
              ],
            ),
          )

          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     // const SizedBox(height: 60),
          //     Stack(
          //       children: [
          //         // Image(
          //         //   image: AssetImage('assets/images/home_illust.png'),
          //         // ),
          //         SizedBox(
          //           height: 180,
          //           child: Container(
          //             color: topBgColor,
          //           ),
          //         ),
          //         Padding(
          //             padding: const EdgeInsets.only(left: 20, top: 20),
          //             child: Text(
          //               '오늘도 하나님이 내게 주신\n말씀을 노트해보세요',
          //               style: CustomTextTheme.notoSansBold1,
          //             )),
          //       ],
          //     ),
          //     Column(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.only(right: 40),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.end,
          //             children: [
          //               IconButton(
          //                 icon: Icon(
          //                   Icons.folder_open,
          //                   color: Colors.grey,
          //                 ),
          //                 onPressed: () {},
          //               ),
          //               const SizedBox(width: 10),
          //               IconButton(
          //                 icon: Icon(
          //                   Icons.edit,
          //                   color: Colors.grey,
          //                 ),
          //                 onPressed: () {},
          //               )
          //             ],
          //           ),
          //         ),
          //         SizedBox(height: 100),
          //         Container(
          //           alignment: Alignment.center,
          //           height: 100,
          //           child: Image(
          //             image: AssetImage('assets/images/home_illust_bible.png'),
          //           ),
          //         ),
          //         const SizedBox(height: 18),
          //         Center(
          //             child: Text('메모를 추가해주세요',
          //                 style: CustomTextTheme.notoSansBold1.copyWith(
          //                     fontWeight: FontWeight.normal, fontSize: 20)))
          //       ],
          //     )
          //   ],
          // ),
          ),
    );
  }
}

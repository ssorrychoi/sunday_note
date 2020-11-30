import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunday_note/common/theme.dart';
import 'package:sunday_note/screen/add_memo_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: topBgColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 60),
            Stack(
              children: [
                // Image(
                //   image: AssetImage('assets/images/home_illust.png'),
                // ),
                SizedBox(
                  height: 180,
                  child: Container(
                    color: topBgColor,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      '오늘도 하나님이 내게 주신\n말씀을 노트해보세요',
                      style: CustomTextTheme.notoSansBold1,
                    )),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.folder_open,
                          color: Colors.grey,
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                SizedBox(height: 100),
                Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: Image(
                    image: AssetImage('assets/images/home_illust_bible.png'),
                  ),
                ),
                const SizedBox(height: 18),
                Center(
                    child: Text('메모를 추가해주세요',
                        style: CustomTextTheme.notoSansBold1.copyWith(
                            fontWeight: FontWeight.normal, fontSize: 20)))
              ],
            )
          ],
        ),
      ),
    );
  }
}

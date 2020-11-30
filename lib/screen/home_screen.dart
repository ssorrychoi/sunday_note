import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              '오늘도 내게 하신 말씀\n노트하세요',
              style: TextStyle(
                  fontFamily: 'NotoSans',
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
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
                const SizedBox(width: 16),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

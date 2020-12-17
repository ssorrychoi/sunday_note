import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:sunday_note/common/theme.dart';
import 'package:sunday_note/screen/webview_screen.dart';

class SponsorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        brightness: Brightness.light,
        elevation: 2.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: textBlackColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '후원하기',
          style: CustomTextTheme.notoSansRegular2,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            child: InkWell(
              // 'https://forms.gle/WXGdkswXY22jXnTR9'
              child: Text('제안 및 문의하기'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebviewScreen(
                            'https://forms.gle/WXGdkswXY22jXnTR9')));
              },
            ),
          ),
          Container(
            height: 100,
            child: InkWell(
              child: Text('카카오페이로 후원하기'),
              // 'https://bit.ly/3nmBicF'
              onTap: () {
                FlutterWebBrowser.openWebPage(
                  url: 'https://bit.ly/3nmBicF',
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

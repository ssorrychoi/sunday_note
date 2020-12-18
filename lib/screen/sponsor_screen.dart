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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
                color: topBgColor,
                child: Text('기능 제안 및 추가 요청'),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebviewScreen(
                            'https://forms.gle/WXGdkswXY22jXnTR9')))),
            const SizedBox(height: 40),
            Container(
              height: 150,
              child: Image(
                image: AssetImage('assets/images/qr.png'),
              ),
            ),
            Container(
              height: 150,
              child: Image(
                image: AssetImage('assets/images/pay.png'),
              ),
            ),
            RaisedButton(
              color: topBgColor,
              child: Text('카카오페이로 커피한잔 사주기'),
              onPressed: () => FlutterWebBrowser.openWebPage(
                url: 'https://bit.ly/3nmBicF',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

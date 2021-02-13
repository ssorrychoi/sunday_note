import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:sunday_note/common/strings.dart';
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
                child: Text(Strings.requestFunction),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebviewScreen(
                            'https://forms.gle/9uM2ShXw7A8e7p3v5')))),
            const SizedBox(height: 20),
            RaisedButton(
                color: topBgColor,
                child: Text(Strings.errReportFunction),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebviewScreen(
                            'https://forms.gle/GXcQ1FHje1RrJE2B7')))),
            const SizedBox(height: 40),
            InkWell(
              onTap: () => FlutterWebBrowser.openWebPage(
                url: 'https://bit.ly/3nmBicF',
              ),
              child: Column(
                children: [
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

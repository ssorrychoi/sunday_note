import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:sunday_note/common/theme.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                  child: Image(
                image: AssetImage('assets/images/home_illust_bible.png'),
              )),
            ),
            SignInButton(
              Buttons.Google,
              text: 'Sign up with Google',
              onPressed: () {},
            ),
            Platform.isIOS == true
                ? SignInButton(
                    Buttons.Apple,
                    text: 'Sign up with Apple',
                    onPressed: () {},
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

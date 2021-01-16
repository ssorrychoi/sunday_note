import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunday_note/common/theme.dart';

class CustomButtonDialog extends StatelessWidget {
  final String title;
  final String message;
  final String cancelText;
  final String confirmText;
  final VoidCallback onPressedCancel;
  final VoidCallback onPressedConfirm;

  const CustomButtonDialog(
      {Key key,
      this.title,
      @required this.message,
      this.cancelText,
      @required this.confirmText,
      this.onPressedCancel,
      @required this.onPressedConfirm});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AlertDialog(
        title: title != null
            ? Text(title, style: CustomTextTheme.notoSansBold2)
            : null,
        content: Text(message, style: CustomTextTheme.notoSansRegular2),
        actions: [
          if (cancelText != null)
            FlatButton(
              child: Text(
                cancelText,
                style: CustomTextTheme.notoSansRegular1
                    .copyWith(color: Colors.blueAccent),
              ),
              onPressed: onPressedCancel,
            ),
          FlatButton(
            child: Text(
              confirmText,
              style: CustomTextTheme.notoSansRegular1.copyWith(
                  color: cancelText == null
                      ? Colors.blueAccent
                      : Colors.redAccent),
            ),
            onPressed: onPressedConfirm,
          ),
        ],
      );
    } else {
      return CupertinoAlertDialog(
        title: title != null
            ? Text(title, style: CustomTextTheme.notoSansBold1)
            : null,
        content: Text(message),
        actions: [
          if (cancelText != null)
            CupertinoDialogAction(
              child: Text(cancelText),
              onPressed: onPressedCancel,
            ),
          CupertinoDialogAction(
            child: Text(confirmText),
            textStyle: TextStyle(
                color: cancelText == null
                    ? CupertinoColors.activeBlue
                    : CupertinoColors.destructiveRed),
            onPressed: onPressedConfirm,
          )
        ],
      );
    }
  }
}

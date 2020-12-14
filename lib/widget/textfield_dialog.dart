import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunday_note/common/theme.dart';

class TextfieldDialog extends StatelessWidget {
  final String title;
  final String message;
  final String cancelText;
  final String confirmText;
  final VoidCallback onPressedCancel;
  final VoidCallback onPressedConfirm;
  final TextEditingController controller;

  const TextfieldDialog(
      {Key key,
      this.title,
      @required this.message,
      this.cancelText,
      @required this.confirmText,
      this.onPressedCancel,
      @required this.onPressedConfirm,
      @required this.controller});

  @override
  Widget build(BuildContext context) {
    // final TextEditingController folderName = TextEditingController();

    if (Platform.isAndroid) {
      return AlertDialog(
        title: title != null
            ? Text(title, style: CustomTextTheme.notoSansBold1)
            : null,
        content: TextField(
          controller: controller,
        ),
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
              style: TextStyle(
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
            ? Column(
                children: [
                  Text(title),
                  Text(
                    message,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  )
                ],
              )
            : null,
        content: Card(
          elevation: 0,
          child: Container(
            height: 40,
            child: TextField(
              controller: controller,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                hintText: '이름',
                filled: true,
                fillColor: Colors.grey.shade50,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(color: Colors.white, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(color: Colors.white, width: 2)),
              ),
            ),
          ),
        ),
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

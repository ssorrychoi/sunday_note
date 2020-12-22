import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunday_note/common/theme.dart';
import 'package:sunday_note/entity/memo_entity.dart';
import 'package:sunday_note/model/add_memo_model.dart';
import 'package:sunday_note/model/memo_list_model.dart';
import 'package:sunday_note/screen/add_memo_screen.dart';

class MemoListItem extends StatelessWidget {
  final Memo memo;
  final String folderName;

  MemoListItem(this.memo, this.folderName);

  @override
  Widget build(BuildContext context) {
    return Card(
      // child: InkWell(
      //   onTap: () {},
      //   onDoubleTap: null,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    memo.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextTheme.notoSansRegular3,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: topBgColor,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 4, bottom: 4),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        memo.words,
                        style: CustomTextTheme.notoSansRegular4,
                      )),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              memo.contents,
              style: CustomTextTheme.notoSansRegular5,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    memo.speaker,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextTheme.notoSansRegular3,
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      memo.date,
                      style: CustomTextTheme.notoSansRegular4,
                    )),
              ],
            ),
          ],
        ),
      ),
      // ),
    );
  }
}

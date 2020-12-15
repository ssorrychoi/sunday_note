import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunday_note/common/theme.dart';
import 'package:sunday_note/model/memo_list_model.dart';
import 'package:sunday_note/screen/memo_list_screen.dart';

class FolderListItem extends StatelessWidget {
  final String folderName;

  FolderListItem(this.folderName);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Card(
        child: InkWell(
          onTap: () {
            /// TODO Navigator push FolderListScreen
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                          create: (context) => MemoListModel(),
                          child: MemoListScreen(
                            folderName: folderName,
                          ),
                        )));
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  height: 30,
                  child: Image(
                    image: AssetImage('assets/btns/list_folder.png'),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  folderName,
                  style:
                      CustomTextTheme.notoSansRegular1.copyWith(fontSize: 20),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '0',
                style: CustomTextTheme.notoSansRegular1.copyWith(fontSize: 20),
              ),
              const SizedBox(width: 5),
              Icon(
                Icons.keyboard_arrow_right,
                size: 30,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}

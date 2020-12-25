import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunday_note/common/theme.dart';
import 'package:sunday_note/model/home_model.dart';
import 'package:sunday_note/model/memo_list_model.dart';
import 'package:sunday_note/screen/memo_list_screen.dart';

class FolderListItem extends StatefulWidget {
  final String folderName;

  FolderListItem(this.folderName);

  @override
  _FolderListItemState createState() => _FolderListItemState();
}

class _FolderListItemState extends State<FolderListItem> {
  HomeModel _model;
  int memoListCnt;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = Provider.of<HomeModel>(context, listen: false);
    memoListCnt = _model.memoListCnt(widget.folderName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            /// TODO Navigator push FolderListScreen
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                          create: (context) => MemoListModel(),
                          child: MemoListScreen(
                            folderName: widget.folderName,
                          ),
                        ))).then((value) {
              _model.changeMemoCnt(value);
            });
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
                  widget.folderName,
                  style:
                      CustomTextTheme.notoSansRegular1.copyWith(fontSize: 20),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                memoListCnt.toString(),
                style: CustomTextTheme.notoSansRegular1.copyWith(fontSize: 20),
              ),
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

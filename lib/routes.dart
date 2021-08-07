import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunday_note/model/home_model.dart';
import 'package:sunday_note/model/memo_list_model.dart';
import 'package:sunday_note/screen/add_memo_screen.dart';
import 'package:sunday_note/screen/home_screen.dart';
import 'package:sunday_note/screen/memo_list_screen.dart';

class Routes {
  static const main = '/';
  static const home = '/home';
  static const memoList = '/memoList';
  static const addMemo = '/addMemo';
}

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.main:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => HomeModel(),
            child: HomeScreen(),
          ),
        );

      case Routes.memoList:
        final MemoListArgs args = settings.arguments;

        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => MemoListModel(),
            child: MemoListScreen(
              folderName: args.folderName,
              sortingStandard: args.sortingStandard,
            ),
          ),
        );

      case Routes.addMemo:
        final AddMemoArgs args = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => MemoListModel(),
            child: AddMemoScreen(
              dateText: args.dateText,
              titleText: args.titleText,
              wordsText: args.wordsText,
              contentsText: args.contentsText,
              speaker: args.speaker,
              folderName: args.folderName,
            ),
          ),
        );
    }
  }
}

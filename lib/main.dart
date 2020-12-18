// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunday_note/common/shared_preferences.dart';
import 'package:sunday_note/model/home_model.dart';
import 'package:sunday_note/model/login_model.dart';
import 'package:sunday_note/screen/home_screen.dart';
import 'package:sunday_note/screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ChangeNotifierProvider(
            create: (context) => HomeModel(), child: HomeScreen())

        // ChangeNotifierProvider(
        //   create: (context) => LoginModel(),
        //   child: SharedPreference.getUserEmail() == null
        //       ? LoginScreen()
        //       : ChangeNotifierProvider(
        //           create: (context) => HomeModel(), child: HomeScreen()),
        // ),
        );
  }
}

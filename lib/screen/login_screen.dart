// import 'dart:io';
// import 'dart:convert' show json;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_signin_button/button_view.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';
// import 'package:sunday_note/common/theme.dart';
// import 'package:http/http.dart' as http;
// import 'package:sunday_note/model/home_model.dart';
// import 'package:sunday_note/model/login_model.dart';
// import 'package:sunday_note/screen/home_screen.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   GoogleSignInAccount _currentUser;
//   String _contactText;
//
//   LoginModel _model;
//
//   @override
//   void initState() {
//     super.initState();
//     _model = Provider.of<LoginModel>(context, listen: false);
//     // _model.changeLoadingStatus(false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: topBgColor,
//         elevation: 0,
//         brightness: Brightness.light,
//       ),
//       backgroundColor: topBgColor,
//       body: SafeArea(
//         child: Selector<LoginModel, bool>(
//           selector: (context, data) => data.isLoading,
//           builder: (context, loading, _) {
//             return Stack(
//               children: [
//                 SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 50),
//                         child: Center(
//                             child: Image(
//                           image:
//                               AssetImage('assets/images/home_illust_bible.png'),
//                         )),
//                       ),
//                       Column(
//                         children: [
//                           SignInButton(Buttons.GoogleDark, text: '구글로그인',
//                               onPressed: () {
//                             _model.changeLoadingStatus(true);
//                             _model.signInWithGoogle().then((value) {
//                               if (value != null) {
//                                 _model.addUser();
//                                 Navigator.of(context).pushAndRemoveUntil(
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             ChangeNotifierProvider(
//                                                 create: (context) =>
//                                                     HomeModel(),
//                                                 child: HomeScreen())),
//                                     (Route<dynamic> route) => false);
//                               } else {
//                                 _model.changeLoadingStatus(false);
//                               }
//                             });
//                           }),
//                           Platform.isIOS == true
//                               ? SignInButton(
//                                   Buttons.AppleDark,
//                                   text: '애플로그인',
//                                   onPressed: () {
//                                     _model.changeLoadingStatus(true);
//                                     print('click AppleLogin');
//                                     _model.signInWithApple().then((value) {
//                                       print('value : $value');
//                                       if (value != null) {
//                                         _model.addUser();
//                                         Navigator.of(
//                                                 context)
//                                             .pushAndRemoveUntil(
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         ChangeNotifierProvider(
//                                                             create: (context) =>
//                                                                 HomeModel(),
//                                                             child:
//                                                                 HomeScreen())),
//                                                 (Route<dynamic> route) =>
//                                                     false);
//                                       } else {
//                                         _model.changeLoadingStatus(false);
//                                       }
//                                     });
//                                   },
//                                 )
//                               : Container(),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//                 loading
//                     ? Center(child: CircularProgressIndicator())
//                     : Container()
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

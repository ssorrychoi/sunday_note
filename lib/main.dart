import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:sunday_note/routes.dart';
import 'package:sunday_note/service/analytics_service.dart';

import 'common/strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  appName = packageInfo.appName;
  packageName = packageInfo.packageName;
  version = packageInfo.version;
  buildNumber = packageInfo.buildNumber;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1.0),
          child: child,
        );
      },
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Routes.main,
      onGenerateRoute: RouteGenerator().generateRoute,
      navigatorObservers: [AnalyticsService().getObserver()],
    );
  }
}

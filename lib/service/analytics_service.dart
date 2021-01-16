import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AnalyticsService {
  FirebaseAnalytics analytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver getObserver() =>
      FirebaseAnalyticsObserver(analytics: analytics);

  Future logAppOpen() async {
    await analytics.logAppOpen();
  }

  Future logSignUp() async {
    await analytics.logSignUp(signUpMethod: 'email');
  }

  Future logAddFolder(String folderName) async {
    await analytics
        .logEvent(name: 'add_folder', parameters: {'folder': folderName});
  }

  Future logSetScreen(String screenName) async {
    await analytics.setCurrentScreen(screenName: screenName);
  }
}

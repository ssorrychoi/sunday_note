import 'dart:io';

class AdmobService {
  static String get admobId {
    if (Platform.isIOS) {
      return "ca-app-pub-5844691994823832~2916135317";
    } else if (Platform.isAndroid) {
      return "ca-app-pub-5844691994823832~1270869393";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isIOS) {
      return "ca-app-pub-5844691994823832/1850465650";
    } else if (Platform.isAndroid) {
      return "ca-app-pub-5844691994823832/3705461047";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}

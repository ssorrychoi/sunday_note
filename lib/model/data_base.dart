class DatabaseHelper {
  //database_helper.dart
  static DatabaseHelper _databaseHelper = DatabaseHelper._createInstance();

  DatabaseHelper._createInstance(); //Dart에서 _로 시작하는 것은 private를 의미합니다.

  factory DatabaseHelper() {
    return _databaseHelper;
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class userPreferences {
  static var prefs;

  static var startInt;
  static int userScore = 0;

  static Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future isFirstLaunch() async {
    startInt = prefs.getInt('startInt');
    await prefs.setInt('startInt', 1);
    //await prefs.setInt('userScore', 0);
  }

  /*static Future setScore(int score) async {
    await prefs.setInt("userScore", userScore + score);
  }

  static getScore() {
    return prefs.getInt('userScore');
  }*/
}

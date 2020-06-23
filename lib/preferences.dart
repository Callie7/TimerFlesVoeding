import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const String keyNamePeriodH = "PeriodH";
  static const String keyNamePeriodM = "PeriodM";
  static const String keyNameStartTime = "StartTime";

  static const String keyNameCounterDate = "CounterDate";
  static const String keyNameCounterYesterday = "CounterYesterday";
  static const String keyNameCounterToday = "CounterToday";

  static Future<Duration> getPeriod() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int periodH = prefs.getInt(Preferences.keyNamePeriodH) ?? 3;
    int periodM = prefs.getInt(Preferences.keyNamePeriodM) ?? 0;
    return Duration(hours: periodH, minutes: periodM);
  }

  static void setStartTime(DateTime startTime) {
    _setString(keyNameStartTime, startTime.toString());
  }

  static void setCounterDate(DateTime counterDate) {
    _setString(keyNameCounterDate, counterDate.toString());
  }

  static void setCounters(int counterToday, int counterYesterday) {
    _setInt(keyNameCounterToday, counterToday);
    _setInt(keyNameCounterYesterday, counterYesterday);
  }

  static void setCounterToday(int counterToday) {
    _setInt(keyNameCounterToday, counterToday);
  }

  static void setPeriod(int hours, int minutes) {
    _setInt(keyNamePeriodM, minutes);
    _setInt(keyNamePeriodH, hours);
  }

  static _setString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static _setInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }
}

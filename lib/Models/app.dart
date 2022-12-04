import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModel with ChangeNotifier {
  Map<String, dynamic> appConfig = {};
  bool isLoading = true;
  String locale = 'en';
  bool isInit = false;
  bool firstRun = true;

  AppModel() {
    getConfig();
  }

  Future<bool> getConfig() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      locale = prefs.getString("language") ?? 'en';
      firstRun = prefs.getBool("firstRun") ?? true;
      isInit = true;
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> setFirstRun(bool value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      firstRun = value;
      await prefs.setBool("firstRun", value);
      await loadAppConfig();

      notifyListeners();
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> changeLanguage(String country, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      locale = country;
      await prefs.setString("language", country);
      await loadAppConfig();

      notifyListeners();
      return true;
    } catch (err) {
      return false;
    }
  }

  void loadStreamConfig(config) {
    appConfig = config;
    isLoading = false;
    notifyListeners();
  }

  Future<Map> loadAppConfig() async {
    try {
      if (!isInit) {
        await getConfig();
      }
      isLoading = false;
      notifyListeners();
      return appConfig;
    } catch (err, trace) {
      print(trace);
      isLoading = false;
      notifyListeners();
      return {};
    }
  }
}

class App {
  Map<String, dynamic> appConfig;
  App(this.appConfig);
  static GlobalKey<NavigatorState>? materialKey = GlobalKey();
}

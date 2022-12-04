import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Models/app.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with AfterLayoutMixin {
  @override
  void initState() {
    super.initState();
    var appModel = Provider.of<AppModel>(context, listen: false);
    Timer(
      Duration(seconds: 3),
      () => (storage.account.isLoggedIn ?? false)
          ? Navigator.pushReplacementNamed(context, 'mainmenu')
          : appModel.firstRun
              ? Navigator.pushReplacementNamed(context, "black")
              : Navigator.pushReplacementNamed(context, 'welcome'),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // width: size.width / 3.5,
      // height: size.height / 3.5,
      child: Image.asset(
        "assets/icon/icon2.png",
        scale: 7,
      ),
    );
  }

  Future<void> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String locale = prefs.getString("language") ?? 'en';
    Provider.of<AppModel>(context, listen: false)
        .changeLanguage(locale, context);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // soundNoti();

    getLanguage();
  }
}

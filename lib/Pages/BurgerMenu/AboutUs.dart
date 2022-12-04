import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Networking/Mobx/menu_mobx.dart';
import 'package:hilike/Widget/Appbar60.dart';
import 'package:hilike/Widget/Navigation.dart';
import 'package:hilike/generated/l10n.dart';

class Aboutus extends StatefulWidget {
  @override
  _AboutusState createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> with AfterLayoutMixin {
  MenuMobx menuMobx = MenuController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Appbar60(
          title: S.of(context).aboutUs,
        ),
      ),
      body: Observer(
        builder: (_) => Container(
            margin: const EdgeInsets.all(16.0),
            width: size.width / 1,
            // height: size.height / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xff292929),
            ),
            padding: const EdgeInsets.all(25),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.start,
              shrinkWrap: true,
              children: [
                Text(
                  S.of(context).aboutUs,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.90,
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                Theme(
                  data: ThemeData(
                    textTheme: TextTheme(
                      bodyText2: TextStyle(
                        color: Color(0xffc4c4c4),
                      ),
                      headline1: TextStyle(
                        color: Color(0xffc4c4c4),
                      ),
                      subtitle1: TextStyle(
                        color: Color(0xffc4c4c4),
                      ),
                      bodyText1: TextStyle(
                        color: Color(0xffc4c4c4),
                      ),
                    ),
                  ),
                  child: Html(
                    data: menuMobx.about ?? "",
                  ),
                ),
              ],
            )),
      ),
      bottomNavigationBar: NavigationRow(
        currentIndex: 5,
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    menuMobx.getAbout(context);
  }
}

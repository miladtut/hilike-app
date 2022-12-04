import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Networking/Mobx/menu_mobx.dart';
import 'package:hilike/Widget/Appbar60.dart';
import 'package:hilike/generated/l10n.dart';

class Usagepolicy extends StatefulWidget {
  @override
  _UsagepolicyState createState() => _UsagepolicyState();
}

class _UsagepolicyState extends State<Usagepolicy> with AfterLayoutMixin {
  MenuMobx menuMobx = MenuController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Appbar60(
          title: S.of(context).usagePolicy,
        ),
      ),
      body: Observer(
        builder: (_) => Container(
            width: size.width / 1,
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xff292929),
            ),
            child: ListView(
              shrinkWrap: true,
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).usagePolicy,
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
                    data: menuMobx.policy ?? "",
                  ),
                ),
              ],
            )),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    menuMobx.getPolicy(context);
  }
}

import 'package:flutter/material.dart';
import 'package:hilike/Models/app.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:provider/provider.dart';

class ChooseGender extends StatefulWidget {
  @override
  _ChooseGenderState createState() => _ChooseGenderState();
}

class _ChooseGenderState extends State<ChooseGender> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var appModel = Provider.of<AppModel>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0x1A1A1A),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: size.height / 4,
          ),
          Container(
              height: 152, width: 150, child: Image.asset("assets/img/H.png")),
          SizedBox(
            height: size.height / 12,
          ),
          Text(
            S.of(context).chooseYourLanguage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w900,
              letterSpacing: 0.90,
            ),
          ),
          SizedBox(
            height: size.height / 40,
          ),
          // Text(
          //   S.of(context).selectYourLanguageUsingTheButton.replaceAll("\\n", "\n"),
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     color: Color(0xffc4c4c4),
          //     fontSize: 13,
          //     letterSpacing: 0.65,
          //   ),
          // ),
          SizedBox(
            height: size.height / 30,
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await appModel.changeLanguage("en", context);
                    setState(() {});
                    Navigator.pushReplacementNamed(context, 'help');
                  },
                  child: Container(
                    width: 51,
                    height: 51,
                    decoration: BoxDecoration(
                      color: appModel.locale != 'en'
                          ? Colors.transparent
                          : Color(0xffe5003a),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: appModel.locale != 'en'
                            ? Colors.white
                            : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "EN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.50,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () async {
                    await appModel.changeLanguage("ar", context);
                    setState(() {});
                    Navigator.pushReplacementNamed(context, 'help');
                  },
                  child: Container(
                    width: 51,
                    height: 51,
                    decoration: BoxDecoration(
                      color: appModel.locale == 'ar'
                          ? Color(0xffe5003a)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: appModel.locale == 'ar'
                            ? Color(0xffe5003a)
                            : Colors.white,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "AR",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.50,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

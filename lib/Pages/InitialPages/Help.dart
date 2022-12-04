import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Models/app.dart';
import 'package:hilike/Models/onboarding.dart';
import 'package:hilike/Networking/Mobx/on_boarding_mobx.dart';
import 'package:hilike/Widget/HelpPager.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  PageController pager = PageController(
    initialPage: 0,
  );
  num value = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0x1A1A1A),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width / 1,
            height: size.height / 1.3,
            child: PageView(
              controller: pager,
              onPageChanged: (val) {
                setState(() {
                  value = val;
                });
              },
              children: [
                HelpPager(
                  image: "assets/img/Frame.png",
                  pager: 0,
                  text:
                      Localizations.localeOf(context).languageCode.toString() ==
                              "ar"
                          ? "مهمة هاى لايك"
                          : "Mission HilLike",
                  title: Localizations.localeOf(context)
                              .languageCode
                              .toString() ==
                          "ar"
                      ? "يهدف هاي لايك للتعارف والزواج الرسمي لتلبية غايتكم والبحث عن أفضل وأنسب شريك بطريقة عصرية سريعة وأمنة"
                      : "HiLike aims for acquaintance and official marriage to meet your goals and search for the best and most appropriate partner in a modern, fast and safe way",
                ),
                HelpPager(
                  image: "assets/img/Frame2.png",
                  pager: 1,
                  text:
                      Localizations.localeOf(context).languageCode.toString() ==
                              "ar"
                          ? "الآداب العامة"
                          : "Public morals",
                  title: Localizations.localeOf(context)
                              .languageCode
                              .toString() ==
                          "ar"
                      ? "يتوافق مع الشريعة الإسلامية والقيم المجتمعية والأداب العامة، بعيدًا عن برامج التعارف التي تفتقد إلى للجدية وغير آمنة"
                      : "It is in line with Islamic law, community values, and public morals, away from dating programs that lack seriousness and are not safe",
                ),
                HelpPager(
                  image: "assets/img/Frame3.png",
                  pager: 2,
                  text:
                      Localizations.localeOf(context).languageCode.toString() ==
                              "ar"
                          ? "فوق 18 سنة"
                          : "Over 18 years old",
                  title: Localizations.localeOf(context)
                              .languageCode
                              .toString() ==
                          "ar"
                      ? "استخدم التطبيق خاص لمن أعمارهم 18 سنة وما فوق"
                      : "Use the application for those aged 18 years and over",
                ),
                HelpPager(
                  image: "assets/img/Frame4.png",
                  pager: 3,
                  text:
                      Localizations.localeOf(context).languageCode.toString() ==
                              "ar"
                          ? "الأمان والحماية"
                          : "Safety & protection",
                  title: Localizations.localeOf(context)
                              .languageCode
                              .toString() ==
                          "ar"
                      ? "يسعى هاي لايك لتوفير أقصى مستويات الأمان والحماية لجميع مستخدميه، وسيتم تصفية الأعضاء الغير جادين بالزواج لتوفير أفضل جودة لكسب ثقتكم وتلبية غايتكم"
                      : "HiLike seeks to provide the highest levels of security and protection for all its users, and members who are not serious about marriage will be liquidated to provide the best quality",
                )
              ],
            ),
          ),
          Container(
            height: 12,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (ctx, index) {
                return ClipOval(
                  child: Container(
                    //color: Colors.green,
                    height: 15.0, // height of the button
                    width: 15.0, // width of the button
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            color: Color(0xff5c5c5c),
                            width: 1.3,
                            style: BorderStyle.solid),
                        shape: BoxShape.circle),
                    child: Center(
                        child: Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color:
                            index == value ? Colors.white : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.transparent,
                          width: 10,
                        ),
                      ),
                    )),
                  ),
                ).paddingSymmetric(horizontal: 6);
              },
            ),
          ),
          SizedBox(
            height: size.height / 30,
          ),
          GestureDetector(
              onTap: () async {
                await AppModel().setFirstRun(false);
                Navigator.pushReplacementNamed(context, 'welcome');
              },
              child: Container(
                height: size.height / 13.8,
                width: size.width / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color(0xfff5f5f5),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    S.of(context).skip,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.75,
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: size.height / 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).read,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.65,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'policy');
                },
                child: Text(
                  S.of(context).privacyAndPolicy,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff0583f2),
                    fontFamily: 'Roboto',
                    fontSize: 13,
                    letterSpacing: 0.65,
                    fontWeight: FontWeight.normal,
                    // decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

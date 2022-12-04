import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Networking/Mobx/profile_mobx.dart';
import 'package:hilike/Utils/constants.dart';
import 'package:hilike/Widget/MenuRow.dart';
import 'package:hilike/Widget/Navigation.dart';
import 'package:hilike/Widget/UserAvatar.dart';
import 'package:hilike/generated/l10n.dart';

import '../../extensions.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with AfterLayoutMixin {
  ProfileMobx profileMobx = ProfileController();
  String plan = "";
  int isSocial = 10;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Observer(
      builder: (_) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(240),
          child: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Localizations.localeOf(context).languageCode.toString() == "ar"
                    ? Icons.arrow_back_ios
                    : Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 16,
              ),
            ),
            centerTitle: true,
            title: Text(
              S.of(context).menu,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w900,
                letterSpacing: 1.10,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Color(0xff292929),
            flexibleSpace: profileMobx.user == null
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: size.height /
                              9 // ,Platform.isIOS ? 103 : size.height / 9,
                          ),
                      Container(
                        width: 65,
                        // height: 60,
                        child: Stack(
                          children: [
                            Center(
                              child: UserAvatar(
                                image: profileMobx.user!.profileImage ??
                                    (profileMobx.user!.isMale ?? true
                                        ? imgMalePlaceholder
                                        : imgFemalePlaceholder),
                                size: size.width / 6,
                                plan: profileMobx.user!.plan ?? "Free",
                              ),
                            ),
                            profileMobx.user!.online ?? false
                                ? Positioned(
                                    left: size.width / 7.5,
                                    bottom: size.height / 17,
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: Color(0xff3BC148),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Color(0xff505050),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " ${profileMobx.user!.nickname ?? ""}  ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.90,
                            ),
                          ),
                          Container(
                              height: 20,
                              width: 20,
                              child: Image.asset(
                                "assets/img/gold.png",
                              )),
                          Text(
                            " ${profileMobx.user!.balance ?? 0}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xfff5f5f5),
                              fontSize: 12,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.60,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          "${profileMobx.user!.plan ?? ""} ${S.of(context).account}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'upgrade');
                        },
                        child: Container(
                          width: size.width / 4,
                          // height: size.height / 22,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          // height: size.height / 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xffffb84f),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              S.of(context).upgradePlan,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xffffb84f),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          shrinkWrap: true,
          children: [
            MenuRow(
              text: S.of(context).myLikes,
              img: "assets/img/rheart.png",
              dis: "mylikes",
            ),
            MenuRow(
              text: S.of(context).blocked,
              img: "assets/img/block.png",
              dis: "blocked",
            ),
            MenuRow(
              text: S.of(context).setting,
              img: "assets/img/setting.png",
              dis: "setting",
              isSocial: isSocial,
            ),
            MenuRow(
              text: S.of(context).share,
              img: "assets/img/share.png",
              dis: "share",
            ),
            MenuRow(
              text: S.of(context).aboutUs,
              img: "assets/img/iii.png",
              dis: "us",
            ),
            MenuRow(
              text: S.of(context).usagePolicy,
              img: "assets/img/lock.png",
              dis: "policy",
            ),
            MenuRow(
              text: S.of(context).supportTeam,
              img: "assets/img/mess.png",
              dis: "Steam",
              plan: plan,
            ),
            MenuRow(
              text: S.of(context).upgradePlan,
              img: "assets/img/dollar.png",
              dis: "upgrade",
            ),
            MenuRow(
              text: S.of(context).logout,
              img: "assets/img/logout.png",
              dis: "logout",
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
        bottomNavigationBar: NavigationRow(
          currentIndex: 5,
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    print("isNavOpen $isNavOpen");
    profileMobx.getMyProfile(context).then((value) {
      isSocial = profileMobx.user!.is_social!;
      plan = profileMobx.user!.plan!;
    });
  }
}

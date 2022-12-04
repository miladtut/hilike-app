import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Networking/Mobx/login_mobx.dart';
import 'package:hilike/Networking/Mobx/menu_mobx.dart';
import 'package:hilike/Pages/InitialPages/Welcome.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Widget/customDialog.dart';
import 'package:hilike/extensions.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:share_plus/share_plus.dart';

class MenuRow extends StatefulWidget {
  const MenuRow(
      {Key? key,
      required this.img,
      required this.text,
      required this.dis,
      this.isSocial,
      this.plan})
      : super(key: key);
  final String img, text, dis;
  final int? isSocial;
  final String? plan;

  @override
  _MenuRowState createState() => _MenuRowState();
}

class _MenuRowState extends State<MenuRow> {
  LoginMobx loginMobx = LoginController();
  MenuMobx menuMobx = MenuController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(40, 22, 40, 0),
      child: GestureDetector(
        onTap: () async {
          if (widget.dis == "logout") {
            showLogoutDialog(context);
          } else {
            if (widget.dis == "setting") {
              Navigator.pushNamed(context, widget.dis,
                  arguments: widget.isSocial);
            } else if (widget.dis == "share") {
              print("Platform.isIOS ${Platform.isIOS}");
              var typeee = Platform.isIOS ? "ios" : "android";
              await menuMobx.getSharedLink(context, typeee);
              Share.share(
                menuMobx.link!,
              );
            } else if (widget.dis == "Steam") {
              Navigator.pushNamed(context, "Steam",
                  arguments: [0, widget.plan]);
            } else {
              Navigator.pushNamed(context, widget.dis);
            }
          }
        },
        child: Row(
          children: [
            Container(
              height: 23,
              width: 25,
              child: Image.asset(
                widget.img,
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Text(
              widget.text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }

  void showLogoutDialog(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return CustomDialogg(
          title: S.of(context).areYouSureYouWantToLogout,
          negativeButtonText:
              Localizations.localeOf(context).languageCode.toString() == "ar"
                  ? S.of(context).logout
                  : S.of(context).cancel,
          positiveButtonText:
              Localizations.localeOf(context).languageCode.toString() == "ar"
                  ? S.of(context).cancel
                  : S.of(context).logout,
          onNegativeClick: () {
            if (Localizations.localeOf(context).languageCode.toString() ==
                "ar") {
              Navigator.pop(context);
              loginMobx.logout(ctx, onSuccess: () async {
                await FirebaseAuth.instance.signOut();

                storage.clear();
                Welcome().launch(ctx, isNewTask: true);
              });
            } else {
              Navigator.pop(context);
            }
          },
          onPositiveClick: () {
            if (Localizations.localeOf(context).languageCode.toString() ==
                "ar") {
              Navigator.pop(context);
            } else {
              Navigator.pop(context);
              loginMobx.logout(ctx, onSuccess: () async {
                await FirebaseAuth.instance.signOut();

                storage.clear();
                Welcome().launch(ctx, isNewTask: true);
              });
            }
          },
        );
      },
    );
  }
}

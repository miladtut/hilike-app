import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Networking/Firebase/FirebaseApi.dart';
import 'package:hilike/Networking/Mobx/settings_mobx.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:mobx/mobx.dart';

class NavigationRow extends StatefulWidget {
  int currentIndex;
  var function;
  NavigationRow({
    Key? key,
    this.function,
    required this.currentIndex,
  }) : super(key: key);
  static int? global_value;
  static int? global_notification_on;
  static int? messageCount;
  static int? chatCount;

  static bool settt = false;
  @override
  _NavigationRowState createState() => _NavigationRowState();
}

class _NavigationRowState extends State<NavigationRow> {
  var nav;
  int? counter;

  var val = 0;
  var notification_on;
  @override
  Widget build(BuildContext context) {
    // if (settt == true && counter != null && (counter ?? 0) > 0) {
    //   WidgetsBinding.instance!.addPostFrameCallback((_) {
    //     setState(() {
    //       val = counter!;
    //       settt = false;
    //       print(settt);
    //     });
    //   });
    // }
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseApi.mainMessageCount(), //get my id  + userid
            builder: (context, asyncSnapshot) {
              switch (asyncSnapshot.connectionState) {
                case ConnectionState.waiting:
                  return Container();
                default:
                  if (asyncSnapshot.hasError) {
                    return Container();
                  } else {
                    Map<String, dynamic>? kk = asyncSnapshot.data!.data();
                    notification_on = kk!['notification_on'] ?? 1;
                    NavigationRow.global_notification_on =
                        kk['notification_on'] ?? 1;
                    counter = kk['messages_count'] ?? 0;
                    NavigationRow.chatCount = kk['chats'] ?? 0;
                    if (Platform.isIOS) {
                      FlutterAppBadger.updateBadgeCount(
                          kk['messages_count'] ?? 0);
                    }
                    if (counter != val && counter != null) {
                      // setState(() {
                      //   val = counter!;
                      //  });
                      val = counter!;
                      NavigationRow.settt = true;
                    }
                    NavigationRow.messageCount = kk['messages_count'] ?? 0;
                    print(
                        "see count from nav   : ${NavigationRow.messageCount!}  ");
                    print("see count obs: ${counter!}  ");

                    return Container();
                  }
              }
            }),
        CustomNavigationBar(
          borderRadius: Radius.circular(15),
          selectedColor: Color(0xffe5003a),
          strokeColor: Color(0x30040307),
          unSelectedColor: Colors.white,
          backgroundColor: Color(0xff292929),
          items: [
            CustomNavigationBarItem(
              title: Text(
                S.of(context).home,
                style: TextStyle(
                  color: widget.currentIndex == 0
                      ? Color(0xffe5003a)
                      : Colors.white,
                  fontSize: 11,
                  letterSpacing: 0.55,
                ),
              ),
              icon: Container(
                height: 20,
                width: 20,
                child: Image.asset(widget.currentIndex == 0
                    ? "assets/img/menu2Red.png"
                    : "assets/img/menu2.png"),
              ),
            ),
            CustomNavigationBarItem(
              badgeCount: counter ?? 0,
              showBadge: (counter ?? 0) <= 0 ||
                      notification_on == 0 ||
                      widget.currentIndex == 1
                  ? false
                  : true,
              title: Text(
                S.of(context).chats,
                style: TextStyle(
                  color: widget.currentIndex == 1
                      ? Color(0xffe5003a)
                      : Colors.white,
                  fontSize: 11,
                  letterSpacing: 0.55,
                ),
              ),
              icon: Container(
                height: 22,
                width: 22,
                child: Image.asset(widget.currentIndex == 1
                    ? "assets/img/messred.png"
                    : "assets/img/message.png"),
              ),
            ),
            CustomNavigationBarItem(
              title: Text(
                S.of(context).fans,
                style: TextStyle(
                  color: widget.currentIndex == 2
                      ? Color(0xffe5003a)
                      : Colors.white,
                  fontSize: 11,
                  letterSpacing: 0.55,
                ),
              ),
              icon: Container(
                height: 20,
                width: 20,
                child: Image.asset(widget.currentIndex == 2
                    ? "assets/img/heartred.png"
                    : "assets/img/heart.png"),
              ),
            ),
            CustomNavigationBarItem(
              title: Text(
                S.of(context).profile,
                style: TextStyle(
                  color: widget.currentIndex == 3
                      ? Color(0xffe5003a)
                      : Colors.white,
                  fontSize: 11,
                  letterSpacing: 0.55,
                ),
              ),
              icon: Container(
                height: 20,
                width: 20,
                child: Image.asset(widget.currentIndex == 3
                    ? "assets/img/profilered.png"
                    : "assets/img/profile.png"),
              ),
            ),
          ],

          //  currentIndex: widget.currentIndex,
          onTap: (index) async {
            setState(() {
              NavigationRow.global_value = index;
            });
            if (widget.currentIndex == 8) {
              await widget.function();
            } else {
              if (widget.currentIndex != index) {
                setState(() {
                  widget.currentIndex = index;
                });
                switch (index) {
                  case 0:
                    nav = 'mainmenu';
                    break;
                  case 1:
                    nav = 'messages';
                    break;
                  case 2:
                    nav = 'liked';
                    break;
                  case 3:
                    nav = 'profile';
                    break;
                }
                Navigator.pushNamedAndRemoveUntil(
                    context, nav, ModalRoute.withName('/'));

                // Navigator.pushReplacementNamed(context, nav);
              }
            }

            // print("ssss ${widget.currentIndex}  " + nav);
          },
        )
      ],
    );
  }
}

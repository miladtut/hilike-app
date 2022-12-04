import 'package:after_layout/after_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Models/chat_listner.dart';
import 'package:hilike/Networking/Firebase/FirebaseApi.dart';
import 'package:hilike/Networking/Mobx/login_mobx.dart';
import 'package:hilike/Networking/Mobx/user_mobx.dart';
import 'package:hilike/Pages/InitialPages/Welcome.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Utils/constants.dart';
import 'package:hilike/Utils/time_ago.dart';
import 'package:hilike/Widget/CustomDialogBan.dart';
import 'package:hilike/Widget/MessageContainer.dart';
import 'package:hilike/Widget/Navigation.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/src/extensions/widget_extensions.dart';
import 'package:provider/provider.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> with AfterLayoutMixin {
  UserMobx userMobx = UserController();
  List msg = [];
  final TextEditingController messageController = TextEditingController();


  num counter = 0;
  bool reqestApi = true;
  num count = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            S.of(context).chats,
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
          leading: Text(""),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'menu');
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 14,
                  width: 20,
                  child: Image.asset(
                    "assets/img/menu.png",
                    matchTextDirection: true,
                  )),
            ),
          ],
        ),
        body:
        Observer(
          builder: (_) {
            return ListView(
                padding: EdgeInsets.fromLTRB(20, 22, 20, 0),
                shrinkWrap: true,
                children:
                [
                  for (int i = 0; i < userMobx.chatlist.length; i++)
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, 'chat',
                            arguments: [
                              userMobx.chatlist[i].nickname,
                              userMobx.chatlist[i].profileImage == null &&
                                  userMobx.chatlist[i].gender == "female"
                                  ? imgFemalePlaceholder
                                  : userMobx.chatlist[i].profileImage == null &&
                                  userMobx.chatlist[i].gender == "male"
                                  ? imgMalePlaceholder
                                  : userMobx.chatlist[i].profileImage,
                              userMobx.chatlist[i].userId.toString(),
                              userMobx.chatlist[i].threadId,
                              0,
                              userMobx.chatlist[i].plan,
                              userMobx.chatlist[i].is_blocked,
                              5555
                            ]);
                      },
                      child: MessageContainer(
                        noti: userMobx.notification,
                        subtype: userMobx.chatlist[i].plan == "Gold"
                            ? 1
                            : userMobx.chatlist[i].plan == "admin"
                            ? 3
                            : userMobx.chatlist[i].plan == "Vip"
                            ? 2
                            : 0,
                        img: userMobx.chatlist[i].profileImage == null &&
                            userMobx.chatlist[i].gender == "female"
                            ? imgFemalePlaceholder
                            : userMobx.chatlist[i].profileImage == null &&
                            userMobx.chatlist[i].gender == "male"
                            ? imgMalePlaceholder
                            : userMobx.chatlist[i].profileImage,
                        name: userMobx.chatlist[i].nickname!,
                        age: userMobx.chatlist[i].age!,
                        country: userMobx.chatlist[i].residenceCountry ?? "",
                        lastseen: DateFormat('MM/dd/yyyy')
                            .format(DateTime.now()) ==
                            DateFormat('MM/dd/yyyy')
                                .format(userMobx.chatlist[i].updatedAt!)
                            ? TimeAgo.chatTimeAgo(
                            userMobx.chatlist[i].updatedAt!,
                            locale: Localizations.localeOf(context)
                                .languageCode
                                .toString())
                            .toString()
                            : (DateFormat('yyyy').format(DateTime.now()) ==
                            DateFormat('yyyy').format(
                                userMobx.chatlist[i].updatedAt!))
                            ? DateFormat('MMM / dd')
                            .format(userMobx.chatlist[i].updatedAt!)
                            : DateFormat('MMM / dd / yy')
                            .format(userMobx.chatlist[i].updatedAt!),
                        location:
                        userMobx.chatlist[i].distance!.toStringAsFixed(2),
                        online: userMobx.chatlist[i].online!,
                        count: userMobx.chatlist[i].count,
                        text: '${userMobx.chatlist[i].messages!.last}',
                      ),
                    ),
                ]
            );
          },
        ),
        bottomNavigationBar: NavigationRow(
          currentIndex: 1,
        ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<ChatListner>(context, listen: false).setIsOpen(false);
    Provider.of<ChatListner>(context, listen: false).setChatThread("");
    userMobx.chatlist.clear();
    userMobx.getChatList(context, onRecive: () {
      if (this.mounted) {
        setState(() {});
      }
      // if (userMobx.x == 0) {
      //   userMobx.setx(1);
      //   if (mounted) setState(() {});
      // } else {
      //   return;
      // }
      // //userMobx.setx(0);
      // Future.delayed(Duration(seconds: 5), () {
      //   userMobx.setx(0);
      // });
    }).then((value) {
      if (userMobx.isban == true) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBan(
                text: userMobx.message!,
                text2: userMobx.expired!,
              );
            });
        LoginMobx loginMobx = LoginController();
        Future.delayed(Duration(seconds: 8), () {
          loginMobx.logout(context, onSuccess: () async {
            await FirebaseAuth.instance.signOut();

            storage.clear();
            Welcome().launch(context, isNewTask: true);
          });
        });
      } else {
        count = userMobx.countApi!;
        print("test${userMobx.notification} ");
      }
      Future.delayed(Duration(seconds: 15), () {
        reqestApi = false;
      });
    });
  }
}

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
        body:StreamBuilder<List<dynamic>>(
          stream: FirebaseApi.getFireThreads(storage.account.id),
          builder: (context, snapshot) {
            switch (snapshot.connectionState){
              case ConnectionState.waiting:
                print('snap waiting');
                return Container();
              default :
                if (snapshot.hasError) {
                  print("${snapshot.error}-----------------------------------error");
                  return Container();
                }
                else{
                  List<dynamic>? snaps = snapshot.data;
                  return ListView.builder(
                    padding: EdgeInsets.fromLTRB(20, 22, 20, 0),
                    shrinkWrap: true,
                    itemCount: snaps?.length,
                    itemBuilder: (BuildContext context, int index){
                      Map<String,dynamic> snapuser ;
                      if(snaps?[index].sender_id == storage.account.id.toString()){
                        snapuser = {
                          "subtype":snaps?[index].receiver_plan == 'Gold' ? 1 : snaps?[index].receiver_plan == 'admin' ? 3 : snaps?[index].receiver_plan == 'Vip' ? 2 : 0,
                          "img":snaps?[index].receiver_image??"",
                          "name":snaps?[index].receiver_nickname??"",
                          "age":snaps?[index].receiver_age??0,
                          "country":snaps?[index].receiver_country??"",
                          "lastseen":"",
                          "location":(snaps?[index].sender_distance) != null ? (snaps?[index].sender_distance.toStringAsFixed(2)):'0',
                          "online":1,
                          "count":1,
                          "text":snaps?[index].txt??"",
                          "gender":snaps?[index].receiver_gender??""
                        };
                      }else{
                        snapuser = {
                          "subtype":snaps?[index].sender_plan == 'Gold' ? 1 : snaps?[index].sender_plan == 'admin' ? 3 : snaps?[index].sender_plan == 'Vip' ? 2 : 0,
                          "img":snaps?[index].sender_image??"",
                          "name":snaps?[index].sender_nickname??"",
                          "age": snaps?[index].sender_age??0,
                          "country":snaps?[index].sender_country??"",
                          "lastseen":"",
                          "location":(snaps?[index].sender_distance) != null ? (snaps?[index].sender_distance.toStringAsFixed(2)) : '0',
                          "online":1,
                          "count":1,
                          "text":snaps?[index].txt??"",
                          "gender":snaps?[index].sender_gender??""
                        };
                      }

                      return GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, 'chat',
                              arguments: [
                                snapuser['name'],
                                snapuser['img'] == null &&
                                    snapuser['gender'] == "female"
                                    ? imgFemalePlaceholder
                                    : snapuser['img'] == null &&
                                    snapuser['gender'] == "male"
                                    ? imgMalePlaceholder
                                    : snapuser['img'],
                                snaps?[index].sender_id.toString(),
                                "${snaps?[index].sender_id}_${snaps?[index].receiver_id}",
                                0,
                                snapuser['plan'],
                                0,
                                5555
                              ]);
                        },
                        child: MessageContainer(
                          noti: 1,
                          subtype: snapuser['subtype'],
                          img: snapuser['img'],
                          name: snapuser['name'],
                          age: snapuser['age'],
                          country: snapuser['country'],
                          lastseen: "",
                          location: snapuser['location'],
                          online: 1,
                          count: 10,
                          text: snapuser['text'],
                        ),
                      );
                    },
                  );
                }
            }

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

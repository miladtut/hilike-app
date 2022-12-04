import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Models/app.dart';
import 'package:hilike/Models/chat_listner.dart';
import 'package:hilike/Models/user_image.dart';
import 'package:hilike/Networking/Mobx/user_mobx.dart';
import 'package:hilike/Pages/MainPages/Messages.dart';
import 'package:hilike/Pages/userpages/pressedphoto.dart';
import 'package:hilike/Utils/constants.dart';
import 'package:hilike/Widget/BottomSheet.dart';
import 'package:hilike/Widget/Navigation.dart';
import 'package:hilike/Widget/UserDetails.dart';
import 'package:hilike/Widget/WiledProfilephoto.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';

class Pressuser extends StatefulWidget {
  final int userId;
  final bool? fromChat;
  final Function(bool isBlocked)? onFinish;

  const Pressuser(
      {Key? key, required this.userId, this.onFinish, this.fromChat})
      : super(key: key);

  @override
  _PressuserState createState() => _PressuserState();
}

class _PressuserState extends State<Pressuser> with AfterLayoutMixin {
  UserMobx userMobx = UserController();
  PageController sliderController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
        onWillPop: () async {
          if (widget.onFinish != null) widget.onFinish!(false);
          return true;
        },
        child: Observer(
          builder: (_) => Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: GestureDetector(
                  onTap: () {
                    if (widget.onFinish != null) widget.onFinish!(false);
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Localizations.localeOf(context).languageCode.toString() ==
                            "ar"
                        ? Icons.arrow_back_ios
                        : Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                centerTitle: true,
                title: Text(
                  userMobx.user == null ? "" : userMobx.user!.nickname ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.10,
                  ),
                ),
                actions: [
                  // if (userMobx.user != null)
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      child: GestureDetector(
                        onTap: () {
                          showBarModalBottomSheet(
                            topControl: Container(
                              // height: 0,
                              width: size.width / 3.5,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            bounce: false,
                            expand: false,
                            enableDrag: true,
                            duration: const Duration(milliseconds: 400),
                            context: context,
                            backgroundColor: Color(0xff292929),
                            barrierColor: Color(0xDD4d4d4d),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                            ),
                            builder: (context) => BottomSheetview(
                              userMobx: userMobx,
                              onFinish: () {
                                if (widget.fromChat == true) {
                                  Navigator.pushAndRemoveUntil(
                                    App.materialKey!.currentContext!,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Messages()),
                                    ModalRoute.withName('/messages'),
                                  );
                                } else {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                                if (widget.onFinish != null)
                                  widget.onFinish!(true);
                              },
                            ),
                          );
                        },
                        child: Container(
                          // width: 31,
                          // height: 31,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0x33ffffff),
                          ),
                          child: Icon(Icons.more_horiz, color: Colors.white),
                        ),
                      )),
                ],
                backgroundColor: Color(0xff292929),
              ),
              body: Stack(
                children: [
                  ListView(
                    children: [
                      if (userMobx.user != null)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                userMobx.user!.images!.length > 0
                                    ? Pressedphoto(
                                        userMobx: userMobx,
                                        onFinish: () {
                                          sliderController.animateToPage(
                                              userMobx.pageViewIndex ?? 0,
                                              duration:
                                                  Duration(milliseconds: 1500),
                                              curve: Curves.easeInOutCubic);
                                        },
                                      ).launch(context)
                                    : print("wow");
                              },
                              child: Container(
                                width: size.width / 1,
                                height: size.height / 2,
                                color: userMobx.user!.profileImage == null
                                    ? Color(0xff292929)
                                    : Colors.transparent,
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  children: [
                                    Padding(
                                      padding:
                                          userMobx.user!.profileImage == null
                                              ? EdgeInsets.fromLTRB(
                                                  0, 0, 0, size.height / 20)
                                              : EdgeInsets.all(0),
                                      child: PageView(
                                        controller: sliderController,
                                        children: [...getSlider()],
                                        onPageChanged: (index) {
                                          userMobx.setPageViewIndex(index);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(child: Container()),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: size.width / 1.5,
                                            child: Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              alignment: WrapAlignment.center,
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  userMobx.user!.nickname ?? "",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  userMobx.user!.age.toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                (userMobx.user!.plan ??
                                                            "Free") ==
                                                        "Gold"
                                                    ? Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0, 5, 0, 0),
                                                        width: 40,
                                                        height: 17,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xffffb84f),
                                                            width: 1,
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "Gold",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xffffb84f),
                                                              fontSize: 9,
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : (userMobx.user!.plan ??
                                                                "Free") ==
                                                            "Vip"
                                                        ? Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 5, 0, 0),
                                                            width: 40,
                                                            height: 17,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3),
                                                              border:
                                                                  Border.all(
                                                                color: Color(
                                                                    0xffe5003a),
                                                                width: 1,
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "Vip",
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0xffe5003a),
                                                                  fontSize: 9,
                                                                  fontFamily:
                                                                      "Roboto",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : SizedBox(
                                                            width: 0.1,
                                                          ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,

                                            children: [
                                              Text(
                                                "  ${userMobx.user!.otherInfo == null ? "" : userMobx.user!.otherInfo!.originCountry ?? ""}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Text(
                                                "  ${(userMobx.user!.distance ?? 0.0).toStringAsFixed(2)}  ${S.of(context).km}      ",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: size.width / 1,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x3f000000),
                                            blurRadius: 25,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                        // gradient: LinearGradient(
                                        //   begin: Alignment.topCenter,
                                        //   end: Alignment.bottomCenter,
                                        //   colors: [
                                        //     Color(0x00929292),
                                        //     Colors.black54
                                        //   ],
                                        // ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 12,
                                      bottom: 60,
                                      child: GestureDetector(
                                        onTap: () async {
                                          await userMobx.getChatThread(context,
                                              userMobx.user!.id.toString());

                                          Navigator.pushNamed(context, 'chat',
                                              arguments: [
                                                userMobx.user!.nickname
                                                    .toString(),
                                                userMobx.user!.profileImage ==
                                                            null &&
                                                        userMobx.user!.isMale ==
                                                            false
                                                    ? imgFemalePlaceholder
                                                    : userMobx.user!.profileImage ==
                                                                null &&
                                                            userMobx.user!
                                                                    .isMale ==
                                                                true
                                                        ? imgMalePlaceholder
                                                        : userMobx
                                                            .user!.profileImage,
                                                userMobx.user!.id.toString(),
                                                userMobx.thread ?? "no",
                                                1,
                                                userMobx.user!.plan,
                                                0
                                              ]);
                                        },
                                        child: Container(
                                          width: 42,
                                          height: 42,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0x59ffffff),
                                          ),
                                          child: Image.asset(
                                              "assets/img/gift2.png",
                                              scale: 21),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 12,
                                      bottom: 8,
                                      child: GestureDetector(
                                        onTap: () {
                                          userMobx.setIsLiked(
                                              context,
                                              !(userMobx.isLiked ?? false),
                                              false);
                                        },
                                        child: Container(
                                          width: 42,
                                          height: 42,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0x59ffffff),
                                          ),
                                          child: userMobx.isLiked ?? false
                                              ? Icon(
                                                  Icons.favorite,
                                                  color: Color(0xffe5003a),
                                                )
                                              : Image.asset(
                                                  "assets/img/heart.png",
                                                  scale: 3.5,
                                                ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 12,
                                      bottom: 8,
                                      child: GestureDetector(
                                        onTap: () async {
                                          await userMobx.getChatThread(context,
                                              userMobx.user!.id.toString());

                                          Navigator.pushNamed(context, 'chat',
                                              arguments: [
                                                userMobx.user!.nickname.toString(),//0
                                                userMobx.user!.profileImage == null && userMobx.user!.isMale == false ? imgFemalePlaceholder : userMobx.user!.profileImage == null && userMobx.user!.isMale == true ? imgMalePlaceholder : userMobx.user!.profileImage,//1
                                                userMobx.user!.id.toString(),//2
                                                "no",//3
                                                0,//4
                                                userMobx.user!.plan,//5
                                                0,//6
                                                userMobx.user!.distance,//7
                                                userMobx.user!.age,//8
                                                userMobx.user!.isMale == true ? 'male' : 'female',//9
                                                userMobx.user!.residenceCountry,//10
                                              ]);
                                        },
                                        child: Container(
                                          width: 42,
                                          height: 42,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0x59ffffff),
                                          ),
                                          child: Image.asset(
                                            "assets/img/message.png",
                                            scale: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            UserDetails(
                                user: userMobx.user!, isMyProfile: false),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                    ],
                  ),
                ],
              ),
              bottomNavigationBar: NavigationRow(
                currentIndex: 5,
              )),
        )
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<ChatListner>(context, listen: false).setIsOpen(false);
    Provider.of<ChatListner>(context, listen: false).setChatThread("");
    userMobx.setUserId(widget.userId);
    userMobx.getUserProfile(context);
  }

  List<Widget> getSlider() {
    List<Widget> widgets = [];
    if ((userMobx.user!.images ?? []).isEmpty) {
      widgets.add(Profilephoto(
        noPhoto: userMobx.user!.profileImage == null ? true : false,
        count: 1,
        img: userMobx.user!.profileImage ??
            (userMobx.user!.isMale == true
                ? imgMalePlaceholder
                : imgFemalePlaceholder),
        index: 0,
      ));
      return widgets;
    }
    for (int i = 0; i < (userMobx.user!.images ?? []).length; i++) {
      UserImageModel item = userMobx.user!.images![i];
      widgets.add(Profilephoto(
        count: userMobx.user!.images!.length,
        index: i,
        img: item.image ?? imgPlaceholder,
      ));
    }
    return widgets;
  }
}

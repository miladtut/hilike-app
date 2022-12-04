import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Networking/Mobx/user_mobx.dart';
import 'package:hilike/Utils/constants.dart';
import 'package:hilike/Widget/OthersPhotosCard.dart';
import 'package:hilike/Widget/UserAvatar.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class Pressedphoto extends StatefulWidget {
  final UserMobx userMobx;
  final Function? onFinish;

  const Pressedphoto({Key? key, required this.userMobx, this.onFinish})
      : super(key: key);

  @override
  _PressedphotoState createState() => _PressedphotoState();
}

class _PressedphotoState extends State<Pressedphoto> with AfterLayoutMixin {
  bool ispressed = false;
  late UserMobx userMobx;
  int previousPageViewIndex = 0;
  ItemScrollController controller = ItemScrollController();

  @override
  void initState() {
    super.initState();
    userMobx = widget.userMobx;
    previousPageViewIndex = userMobx.pageViewIndex ?? 0;
    //userMobx.setPageViewIndex(0);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Observer(
      builder: (_) => WillPopScope(
        onWillPop: () async {
          if (widget.onFinish != null) widget.onFinish!();
          return true;
        },
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    userMobx.user!.images![userMobx.pageViewIndex ?? 0].image ??
                        imgPlaceholder),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 40, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: UserAvatar(
                              size: 31,
                              image: userMobx.user!.profileImage ??
                                  (userMobx.user!.isMale ?? true
                                      ? imgMalePlaceholder
                                      : imgFemalePlaceholder),
                              onClick: () {},
                              plan: userMobx.user!.plan ?? "Free",
                            )),
                        SizedBox(
                          width: 13,
                        ),
                        Text(
                          userMobx.user!.nickname ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.75,
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        if ((userMobx.user!.plan ?? "Free") != "Free")
                          Container(
                            width: 30,
                            height: 13,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(
                                color: userMobx.user!.plan == null
                                    ? Color(0xff292929)
                                    : userMobx.user!.plan == "Vip"
                                        ? Color(0xffe5003a)
                                        : userMobx.user!.plan == "Gold"
                                            ? Color(0xffffb84f)
                                            : Color(0xff292929),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                userMobx.user!.plan ?? "Free",
                                style: TextStyle(
                                  color: userMobx.user!.plan == null
                                      ? Color(0xff292929)
                                      : userMobx.user!.plan == "Vip"
                                          ? Color(0xffe5003a)
                                          : userMobx.user!.plan == "Gold"
                                              ? Color(0xffffb84f)
                                              : Color(0xff292929),
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        //widget.userMobx.setPageViewIndex(previousPageViewIndex);
                        Navigator.pop(context);
                        if (widget.onFinish != null) widget.onFinish!();
                      },
                      child: Container(
                        width: 31,
                        height: 31,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0x33ffffff),
                        ),
                        child: Image.asset(
                          "assets/img/x.png",
                          scale: 70,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 75, 15, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            S.of(context).otherPhotos,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.90,
                            ),
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await userMobx.getChatThread(
                                      context, userMobx.user!.id.toString());
                                  Navigator
                                      .pushNamed(context, 'chat', arguments: [
                                    userMobx.user!.nickname.toString(),
                                    userMobx.user!.profileImage == null &&
                                            userMobx.user!.isMale == false
                                        ? imgFemalePlaceholder
                                        : userMobx.user!.profileImage == null &&
                                                userMobx.user!.isMale == true
                                            ? imgMalePlaceholder
                                            : userMobx.user!.profileImage,
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
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0x59ffffff),
                                  ),
                                  child: Image.asset(
                                    "assets/img/gift2.png",
                                    scale: 24,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () async {
                                  await userMobx.getChatThread(
                                      context, userMobx.user!.id.toString());
                                  Navigator
                                      .pushNamed(context, 'chat', arguments: [
                                    userMobx.user!.nickname.toString(),
                                    userMobx.user!.profileImage == null &&
                                            userMobx.user!.isMale == false
                                        ? imgFemalePlaceholder
                                        : userMobx.user!.profileImage == null &&
                                                userMobx.user!.isMale == true
                                            ? imgMalePlaceholder
                                            : userMobx.user!.profileImage,
                                    userMobx.user!.id.toString(),
                                    userMobx.thread ?? "no",
                                    0,
                                    userMobx.user!.plan,
                                    0
                                  ]);
                                },
                                child: Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0x59ffffff),
                                  ),
                                  child: Image.asset(
                                    "assets/img/message.png",
                                    scale: 24,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  userMobx.setIsLiked(context,
                                      !(userMobx.isLiked ?? false), false);
                                },
                                child: Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
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
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: size.height / 3.5,
                      child: ScrollablePositionedList.builder(
                        itemScrollController: controller,
                        padding: EdgeInsets.symmetric(vertical: 7),
                        itemCount: (userMobx.user!.images ?? []).length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return Row(
                            children: [
                              if (index == 0) SizedBox(width: 6),
                              OthersPhotosCard(
                                userMobx: userMobx,
                                index: index,
                                onClick: (_index) {
                                  userMobx.setPageViewIndex(_index);
                                },
                              ).paddingSymmetric(horizontal: 1),
                              if (index ==
                                  (userMobx.user!.images ?? []).length - 1)
                                SizedBox(width: 6),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    controller.scrollTo(
        index: userMobx.pageViewIndex ?? 0,
        duration: Duration(milliseconds: 1500),
        curve: Curves.easeInOutCubic);
  }
}

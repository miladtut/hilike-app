import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Models/chat_listner.dart';
import 'package:hilike/Models/gift.dart';
import 'package:hilike/Models/gift_category.dart';
import 'package:hilike/Models/message.dart';
import 'package:hilike/Networking/Firebase/FirebaseApi.dart';
import 'package:hilike/Networking/Mobx/chat_mobx.dart';
import 'package:hilike/Networking/Mobx/gifts_mobx.dart';
import 'package:hilike/Networking/Mobx/plans_mobx.dart';
import 'package:hilike/Networking/Mobx/profile_mobx.dart';
import 'package:hilike/Networking/Mobx/user_mobx.dart';
import 'package:hilike/Pages/Payment/Buycoins.dart';
import 'package:hilike/Pages/userpages/pressuser.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Utils/constants.dart';
import 'package:hilike/Widget/CustomDialogWithOneButton.dart';
import 'package:hilike/Widget/Gift.dart';
import 'package:hilike/Widget/MessageWidget.dart';
import 'package:hilike/Widget/Navigation.dart';
import 'package:hilike/Widget/customDialog.dart';
import 'package:hilike/Widget/customDialogwithphoto.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:intl/intl.dart' as ss;
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  GiftsMobx giftsMobx = GiftsController();
  ChatMobx chatMobx = ChatController();
  PlansMobx plansMobx = PlansController();
  var x;
  var userid;

  ProfileMobx profileMobx = ProfileController();
  Animation<double>? animation;
  late AnimationController controller;
  TextEditingController messageController = TextEditingController();
  var maxWidth;
  var minWidth;

  // var buttonSize = 35.0;
  PageController pager = PageController(
    initialPage: 0,
  );
  // String desc = Get.arguments[1] ?? "";
  var lastone;
  int limit = 10;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
  }

  UserMobx userMobx = UserController();
  final ScrollController scrollController =
      ScrollController(keepScrollOffset: true);

  void _animate() {
    if (giftsMobx.expanded) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }

  bool havePhoto = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  var chatThred;
  Future<void> giftPopup() async {
    // if (profileMobx.user!.plan != "Free") {
    await giftsMobx.getGiftCategories(context);
    if (!giftsMobx.expanded) _animate();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {});
    });
  }

  var textDirection;
  bool? isfirstmassage;
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as List;

    Provider.of<ChatListner>(context, listen: false).setIsOpen(true);
    Provider.of<ChatListner>(context, listen: false).setChatThread(
      arguments[3] == "no"
          ? storage.account.id.toString() + "_" + arguments[2].toString()
          : arguments[3],
    );
    chatThred = arguments[3] == "no"
        ? storage.account.id.toString() + "_" + arguments[2].toString()
        : arguments[3];
    x = arguments[4];
    userid = arguments[2];
    Size size = MediaQuery.of(context).size;
    minWidth = 40.0;
    maxWidth = size.width - 32;

    return WillPopScope(
      onWillPop: () async {
        Provider.of<ChatListner>(context, listen: false).setIsOpen(false);
        Provider.of<ChatListner>(context, listen: false).setChatThread("");
        Navigator.pushReplacementNamed(context, "messages");
        return true;
      },
      child: GestureDetector(
        onTap: () async {
          FocusScope.of(context).requestFocus(new FocusNode());
          if (giftsMobx.expanded == true) {
            _animate();
            Future.delayed(Duration(seconds: 1), () {
              setState(() {});
            });
          }

          if (plansMobx.reqestApi == false && arguments[5] != "admin") {
            await plansMobx.setReqestApi(true);

            await giftsMobx.isOnline(context, userid).then((value) {
              if (giftsMobx.is_blocked == true) {
                setState(() {});
              }
            });
            plansMobx.setReqestApi(false);
          }
        },
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: AppBar(
                leading: GestureDetector(
                  onTap: () {
                    Provider.of<ChatListner>(context, listen: false)
                        .setIsOpen(false);
                    Provider.of<ChatListner>(context, listen: false)
                        .setChatThread("");
                    Navigator.pushReplacementNamed(context, "messages");
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
                  // profileMobx.user == null
                  //     ? ''
                  //     : profileMobx.user!.nickname ?? "",
                  arguments[0].toString(),
                  // "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.050,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: Color(0xff292929),
                actions: [
                  Padding(
                    padding: Localizations.localeOf(context)
                                .languageCode
                                .toString() ==
                            "ar"
                        ? EdgeInsets.fromLTRB(14, 0, 0, 0)
                        : EdgeInsets.fromLTRB(0, 0, 14, 0),
                    child: GestureDetector(
                      onTap: () async {
                        if (arguments[5] != "admin" &&
                            giftsMobx.is_blocked != true) {
                          Pressuser(
                            fromChat: true,
                            userId: int.parse(arguments[2] ?? 0),
                            onFinish: (bool isBlocked) {
                              // widget.onBackFromPressUser(isBlocked);
                            },
                          ).launch(context);
                        }
                      },
                      child: Stack(alignment: Alignment.center, children: [
                        Container(
                          // margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(arguments[1]),
                              fit: BoxFit.contain,
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: arguments[5] == "Gold"
                                  ? Color(0xffffb84f)
                                  : arguments[5] == "Vip"
                                      ? Color(0xffe5003a)
                                      : Color(0xff292929),
                              width: 1,
                            ),
                            color: Color(0xffc4c4c4),
                          ),
                        ),
                        giftsMobx.online && giftsMobx.is_blocked != true
                            ? Positioned(
                                right: 2.5,
                                bottom: 38,
                                child: Container(
                                  width: 9,
                                  height: 9,
                                  decoration: BoxDecoration(
                                    color: Color(0xff3BC148),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xff292929),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              )
                            : Container()
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(color: Color(0xff1a1a1a)),
                ),
                Column(
                  children: [
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: StreamBuilder<List<Message>>(
                            stream: FirebaseApi.getMessages(chatThread: arguments[3] == "no" ? storage.account.id.toString() + "_" + arguments[2].toString() : arguments[3], llimitval: lastone), //get my id  + userid
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Container();
                                default:
                                  if (snapshot.hasError) {
                                    //showTopSnackBar(S.of(context).somethingIsWrong,
                                    //    "assets/img/iii.png");
                                    return Container();
                                  } else {
                                    List<Message>? messages = snapshot.data;
                                    if ((messages ?? []).isEmpty) {
                                      isfirstmassage = false;
                                      return Container();
                                    }
                                    else {
                                      isfirstmassage = true;
                                      int i = 0;
                                      int j = 0;
                                      int lastSenderId = -1;
                                      DateTime? lastCreatedAt;
                                      // if (lastone == null) {
                                      List<Message> groupedMessages = [];

                                      // }
                                      for (Message message in messages!) {
                                        DateTime date = message.createdAt;
                                        DateTime dateWithoutSeconds = DateTime(
                                            date.year,
                                            date.month,
                                            date.day,
                                            date.hour,
                                            date.minute);
                                        if (lastSenderId == -1)
                                          lastSenderId = message.senderId;
                                        if (lastCreatedAt == null)
                                          lastCreatedAt = dateWithoutSeconds;
                                        if (lastSenderId == message.senderId &&
                                            lastCreatedAt ==
                                                dateWithoutSeconds) {
                                          groupedMessages
                                              .add(message.copyWith(type: i));
                                          i++;
                                          j++;
                                        } else {
                                          if (j > 0)
                                            groupedMessages.last.type = -2;
                                          else
                                            groupedMessages.last.type = -1;
                                          i = 0;
                                          j = 0;
                                          groupedMessages
                                              .add(message.copyWith(type: i));
                                          i++;
                                        }
                                        lastSenderId = message.senderId;
                                        lastCreatedAt = dateWithoutSeconds;
                                      }
                                      groupedMessages.last.type = -2;

                                      return ListView.builder(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 6),
                                        // physics: BouncingScrollPhysics(),
                                        controller: scrollController,

                                        reverse: true,
                                        itemCount: groupedMessages.length,
                                        itemBuilder: (context, index) {
                                          final message = groupedMessages[index];
                                          lastone = groupedMessages[
                                                  groupedMessages.length - 1]
                                              .createdAt;

                                          if (giftsMobx.is_blocked != true) {
                                            FirebaseApi.updateAllMessageStatus(
                                              arguments[3] == "no"
                                                  ? storage.account.id
                                                          .toString() +
                                                      "_" +
                                                      arguments[2].toString()
                                                  : arguments[3],
                                            );
                                            FirebaseApi.updateAllMessageStatus2(
                                              arguments[3] == "no"
                                                  ? storage.account.id
                                                          .toString() +
                                                      "_" +
                                                      arguments[2].toString()
                                                  : arguments[3],
                                            );
                                          }

                                          bool visable = index == 0
                                              ? true
                                              : ss.DateFormat('MM/dd/yyyy')
                                                          .format(
                                                              groupedMessages[
                                                                      index - 1]
                                                                  .createdAt) !=
                                                      ss.DateFormat(
                                                              'MM/dd/yyyy')
                                                          .format(
                                                              groupedMessages[
                                                                      index]
                                                                  .createdAt)
                                                  ? true
                                                  : false;
                                          return MessageWidget(
                                            visable: visable,
                                            lastdate: index ==
                                                    groupedMessages.length - 1
                                                ? "true"
                                                : ss.DateFormat('MM/dd/yyyy')
                                                    .format(groupedMessages[
                                                            index + 1]
                                                        .createdAt),
                                            secondplan: arguments[5],
                                            date: ss.DateFormat('MM/dd/yyyy').format(groupedMessages[index].createdAt),
                                            secondimg: arguments[1],
                                            message: message,
                                            mePlan: storage.account.plan,
                                            isMe: message.senderId ==
                                                storage.account.id,
                                            locale:
                                                Localizations.localeOf(context)
                                                    .languageCode,
                                            isgift: message.giftId != 0
                                                ? true
                                                : false,
                                          );
                                        },
                                      ).paddingBottom(giftsMobx.expanded
                                          ? animation!.value / 1.02
                                          : 60);
                                    }
                                  }
                              }
                            },
                          )),
                    ),
                  ],
                ),
                Observer(
                  builder: (_) => Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Container(
                      width: animation != null ? size.width / 1 : minWidth,
                      height: animation != null &&
                              animation!.value > (minWidth * 1.05)
                          ? animation!.value / 1.05
                          : minWidth,
                      decoration: BoxDecoration(
                        color: giftsMobx.expanded ||
                                (animation != null &&
                                    animation!.value == minWidth)
                            ? Colors.transparent
                            : Color(0xff292929),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child:
                            (animation != null &&
                                        animation!.value == minWidth) ||
                                    animation == null
                                ? Container()
                                : Visibility(
                                    visible: giftsMobx.expanded,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 42,
                                          width: maxWidth,
                                          decoration: BoxDecoration(
                                            color: Color(0xff292929),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: giftsMobx
                                                  .giftCategories.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (ctx, index) {
                                                GiftCategoryModel item =
                                                    giftsMobx
                                                        .giftCategories[index];

                                                return GestureDetector(
                                                  onTap: () {
                                                    giftsMobx.setCurrentPage(0);
                                                    giftsMobx
                                                        .setSelectedCategory(
                                                            index);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: giftsMobx
                                                                  .selectedCategory ==
                                                              index
                                                          ? Color(0xFFE5003A)
                                                          : Colors.transparent,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        item.name ?? "",
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.white,
                                                        ),
                                                      ).paddingSymmetric(
                                                          horizontal: 8),
                                                    ),
                                                  ),
                                                ).paddingSymmetric(vertical: 6);
                                              }).paddingSymmetric(horizontal: 12),
                                        ),
                                        Container(
                                          height: 3,
                                          color: Color(0xff1a1a1a),
                                        ),
                                        Container(
                                          height: maxWidth / 1.05 - 45,
                                          width: size.width - 32,
                                          decoration: BoxDecoration(
                                            color: Color(0xff292929),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: maxWidth / 1.05 - 98,
                                                width: size.width - 32,
                                                child: PageView(
                                                  controller: pager,
                                                  onPageChanged: (val) {
                                                    giftsMobx
                                                        .setCurrentPage(val);
                                                  },
                                                  children: [
                                                    for (List<GiftModel> giftGroup
                                                        in (giftsMobx
                                                                .giftCategoryPartitioned[
                                                                    giftsMobx
                                                                        .selectedCategory]
                                                                .giftGroups ??
                                                            []))
                                                      GridView.builder(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 10,
                                                                horizontal: 5),
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        gridDelegate:
                                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                          maxCrossAxisExtent:
                                                              size.width / 4,
                                                          childAspectRatio:
                                                              0.80,
                                                        ),
                                                        itemCount:
                                                            giftGroup.length,
                                                        itemBuilder:
                                                            (ctx, index) {
                                                          GiftModel gift =
                                                              giftGroup[index];
                                                          return Observer(
                                                            builder: (_) =>
                                                                Gift(
                                                              gift: gift,
                                                              clicked: gift == giftsMobx.clickedGift,
                                                              onClick:
                                                                  (_gift) async {
                                                                if (_gift == giftsMobx.clickedGift) {
                                                                  giftsMobx
                                                                      .setClickedGift(
                                                                          null);
                                                                  //hoooon
                                                                  if (profileMobx
                                                                              .user!
                                                                              .plan !=
                                                                          "Free" &&
                                                                      havePhoto ==
                                                                          true) {
                                                                    await plansMobx.sendGift(
                                                                        context,
                                                                        gift
                                                                            .id!,
                                                                        arguments[
                                                                            2]);

                                                                    if (plansMobx.canpay! == false) {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return CustomDialogBox(
                                                                              title: S.of(context).notEnoughCoins,
                                                                              descriptions: S.of(context).thereAreNotEnoughCoinsInYourAccount,
                                                                              text: S.of(context).recharge,
                                                                              text2: S.of(context).cancel,
                                                                              img: "assets/img/gold.png",
                                                                            );
                                                                          });
                                                                    }

                                                                    if (plansMobx.canpay! == true) {



                                                                      isfirstmassage == false ? await await FirebaseApi.createThread(
                                                                          {
                                                                            "sender_id":storage.account.id.toString(),
                                                                            "receiver_id":arguments[2].toString(),
                                                                            "sender_nickname":profileMobx.user!.nickname,
                                                                            "sender_image":profileMobx.user!.profileImage,
                                                                            "sender_distance":arguments[7],
                                                                            "sender_plan":profileMobx.user!.plan,
                                                                            "updated_at":DateTime.now(),
                                                                            "sender_gender":profileMobx.user!.isMale == 1 ? 'male' : 'female',
                                                                            "sender_country":profileMobx.user!.residenceCountry,
                                                                            "sender_age":profileMobx.user!.age,

                                                                            "receiver_nickname":arguments[0],
                                                                            "receiver_image":arguments[1],
                                                                            "receiver_plan":arguments[5],
                                                                            "receiver_gender":arguments[9],
                                                                            "receiver_country":arguments[10],
                                                                            "receiver_age":arguments[8],
                                                                          }
                                                                      ) : print("wow");

                                                                      FirebaseApi.sendMessage(
                                                                          arguments[3] == "no"
                                                                              ? storage.account.id.toString() + "_" + arguments[2].toString()
                                                                              : arguments[3],
                                                                          gift.image!,
                                                                          gift.id!
                                                                      );
                                                                    }
                                                                  }
                                                                  else
                                                                  {
                                                                    if (profileMobx
                                                                            .user!
                                                                            .plan ==
                                                                        "Free") {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return CustomDialogg(
                                                                              title: S.of(context).upgradePlan,
                                                                              negativeButtonText: S.of(context).later,
                                                                              positiveButtonText: S.of(context).upgrade,
                                                                              onNegativeClick: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              onPositiveClick: () {
                                                                                Navigator.pushNamed(context, "upgrade");
                                                                              });
                                                                        },
                                                                      );
                                                                    } else {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return CustomDialogButton(
                                                                            title:
                                                                                S.of(context).Uploadanimage,
                                                                            text:
                                                                                S.of(context).Theuseronlywants,
                                                                            text2:
                                                                                S.of(context).Uploadimage,
                                                                          );
                                                                        },
                                                                      );
                                                                    }
                                                                  }
                                                                }
                                                                else {
                                                                  giftsMobx
                                                                      .setClickedGift(
                                                                          _gift);
                                                                }
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 12,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: (giftsMobx
                                                                      .giftCategoryPartitioned[
                                                                          giftsMobx
                                                                              .selectedCategory]
                                                                      .giftGroups ??
                                                                  [])
                                                              .length ==
                                                          1
                                                      ? 0
                                                      : (giftsMobx
                                                                  .giftCategoryPartitioned[
                                                                      giftsMobx
                                                                          .selectedCategory]
                                                                  .giftGroups ??
                                                              [])
                                                          .length,
                                                  itemBuilder: (ctx, index) {
                                                    return Observer(
                                                      builder: (_) => Container(
                                                        width: 10,
                                                        height: 10,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: index ==
                                                                  giftsMobx
                                                                      .currentPage
                                                              ? Colors.white
                                                              : Colors
                                                                  .transparent,
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: Color(
                                                                0xff5c5c5c),
                                                            width: 1,
                                                          ),
                                                        ),
                                                      ).paddingSymmetric(
                                                          horizontal: 4),
                                                    );
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 3),
                                              GestureDetector(
                                                onTap: () {
                                                  Buycoins().launch(context);
                                                },
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 16),
                                                    Container(
                                                      width: 87,
                                                      height: 28,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.white),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                              flex: 7,
                                                              child:
                                                                  Container()),
                                                          Text(
                                                            S
                                                                .of(context)
                                                                .recharge,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontSize: 12),
                                                          ),
                                                          Expanded(
                                                              flex: 3,
                                                              child:
                                                                  Container()),
                                                          Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            color: Colors.white,
                                                            size: 14,
                                                          ),
                                                          Expanded(
                                                              flex: 2,
                                                              child:
                                                                  Container()),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                      ),
                    ),
                  ).paddingAll(12),
                ),
                arguments[5] != "admin" && giftsMobx.is_blocked != true
                    ? Visibility(
                        visible: !giftsMobx.expanded,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            // height: size.height / 13,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xcc292929),
                            ),
                            child: TextField(
                              controller: messageController,
                              textDirection: textDirection,
                              onChanged: (val) {
                                RegExp regex = new RegExp("[a-zA-Z]");
                                if (val.length > 0 && val.length < 2) {
                                  if (val.substring(0, 1) != " ") {
                                    regex.hasMatch(val.substring(0, 1))
                                        ? setState(() {
                                            textDirection = TextDirection.ltr;
                                          })
                                        : setState(() {
                                            textDirection = TextDirection.rtl;
                                          });
                                  } else if (val.length == 2) {
                                    if (val.substring(0, 1) == " " &&
                                        val.substring(1, 2) != " ")
                                      regex.hasMatch(val.substring(1, 2))
                                          ? setState(() {
                                              textDirection = TextDirection.ltr;
                                            })
                                          : setState(() {
                                              textDirection = TextDirection.rtl;
                                            });
                                  } else if (val.length > 2) {
                                    regex.hasMatch(val.substring(
                                            val.lastIndexOf(" ") + 1,
                                            val.lastIndexOf(" ") + 2))
                                        ? setState(() {
                                            textDirection = TextDirection.ltr;
                                          })
                                        : setState(() {
                                            textDirection = TextDirection.rtl;
                                          });
                                  }
                                }
                              },
                              style: TextStyle(color: Colors.white),
                              textInputAction: TextInputAction.newline,
                              minLines: 1,
                              onTap: () async {
                                if (plansMobx.reqestApi == false &&
                                    arguments[5] != "admin") {
                                  await plansMobx.setReqestApi(true);

                                  await giftsMobx
                                      .isOnline(context, userid)
                                      .then((value) {
                                    if (giftsMobx.is_blocked == true) {
                                      setState(() {});
                                    }
                                  });
                                  plansMobx.setReqestApi(false);
                                }
                              },
                              maxLines: 5,
                              cursorColor: Color(0xffe5003a),
                              decoration: InputDecoration(
                                hintText: S.of(context).writeMessage,
                                hintStyle: TextStyle(
                                  color: Color(0xff949393),
                                  fontSize: 13,
                                  letterSpacing: 0.65,
                                ),
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: (animation != null && animation!.value == minWidth)
                        ? Align(
                                alignment: Localizations.localeOf(context)
                                            .languageCode
                                            .toString() ==
                                        "ar"
                                    ? AlignmentDirectional.bottomEnd
                                    : AlignmentDirectional.bottomStart,
                                child: arguments[5] != "admin" &&
                                        giftsMobx.is_blocked != true
                                    ? GestureDetector(
                                        onTap: () async {
                                          giftsMobx.giftCategories.clear();
                                          await giftsMobx
                                              .getGiftCategories(context);

                                          FocusScope.of(context).unfocus();
                                          if (!giftsMobx.expanded) _animate();

                                          print("test : ${giftsMobx.expanded}");
                                          Future.delayed(
                                              Duration(milliseconds: 500), () {
                                            setState(() {});
                                          });
                                          if (plansMobx.reqestApi == false &&
                                              arguments[5] != "admin") {
                                            await plansMobx.setReqestApi(true);

                                            await giftsMobx.isOnline(
                                                context, userid);
                                            setState(() {});
                                            plansMobx.setReqestApi(false);
                                          }

                                          // FirebaseApi.createChatThread("55", " 54");
                                        },
                                        child: Image.asset(
                                          "assets/img/gifttt.png",
                                          width: 32,
                                          height: 32,
                                        ),
                                      )
                                    : Container())
                            .paddingSymmetric(horizontal: 24, vertical: 20)
                        : Container()),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: arguments[5] != "admin" && giftsMobx.is_blocked != true
                      ? Visibility(
                          visible: (animation != null &&
                              animation!.value == minWidth),
                          child: Align(
                            alignment: Localizations.localeOf(context)
                                        .languageCode
                                        .toString() ==
                                    "ar"
                                ? AlignmentDirectional.bottomStart
                                : AlignmentDirectional.bottomEnd,
                            child: GestureDetector(
                              onTap: () async {
                                print('--------------------------------------------------------');
                                print(arguments);
                                print('--------------------------------------------------------');
                                print(storage.account);
                                print('--------------------------------------------------------');
                                if (plansMobx.reqestApi == false &&
                                    arguments[5] != "admin") {
                                  await plansMobx.setReqestApi(true);

                                  giftsMobx
                                      .isOnline(context, userid)
                                      .then((value) {
                                    if (giftsMobx.is_blocked == true) {
                                      setState(() {});
                                    }
                                  });
                                  plansMobx.setReqestApi(false);
                                }

                                if (profileMobx.user!.plan != "Free" &&
                                    havePhoto == true) {
                                  if (messageController.text
                                      .trim()
                                      .isNotEmpty) {
                                    isfirstmassage == false ? await FirebaseApi.createThread(
                                      {
                                        "sender_id":storage.account.id.toString(),
                                        "receiver_id":arguments[2].toString(),
                                        "sender_nickname":profileMobx.user!.nickname,
                                        "sender_image":profileMobx.user!.profileImage,
                                        "sender_distance":arguments[7],
                                        "sender_plan":profileMobx.user!.plan,
                                        "updated_at":DateTime.now(),
                                        "sender_gender":profileMobx.user!.isMale == 1 ? 'male' : 'female',
                                        "sender_country":profileMobx.user!.residenceCountry,
                                        "sender_age":profileMobx.user!.age,

                                        "receiver_nickname":arguments[0],
                                        "receiver_image":arguments[1],
                                        "receiver_plan":arguments[5],
                                        "receiver_gender":arguments[9],
                                        "receiver_country":arguments[10],
                                        "receiver_age":arguments[8],
                                      }
                                    ):print('wow');
                                    FirebaseApi.sendMessage(
                                        arguments[3] == "no"
                                            ? storage.account.id.toString() +
                                                "_" +
                                                arguments[2].toString()
                                            : arguments[3],
                                        messageController.text.trim(),
                                        0);

                                    messageController.clear();
                                  }
                                } else {
                                  if (profileMobx.user!.plan == "Free") {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialogg(
                                            title: S.of(context).upgradePlan,
                                            negativeButtonText:
                                                S.of(context).later,
                                            positiveButtonText:
                                                S.of(context).upgrade,
                                            onNegativeClick: () {
                                              Navigator.pop(context);
                                            },
                                            onPositiveClick: () {
                                              Navigator.pushNamed(
                                                  context, "upgrade");
                                            });
                                      },
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialogButton(
                                          title: S.of(context).Uploadanimage,
                                          text: S.of(context).Theuseronlywants,
                                          text2: S.of(context).Uploadimage,
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                              child: Image.asset(
                                "assets/img/enter.png",
                                width: 32,
                                height: 32,
                              ),
                            ),
                          ).paddingSymmetric(horizontal: 24, vertical: 20),
                        )
                      : Container(),
                ),
                Positioned(
                  // bottom: 0,
                  // right: 0,
                  child: Visibility(
                    visible: giftsMobx.show_unblock,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return CustomDialogg(
                              title: S.of(context).doYouWantToUnblock +
                                  " " +
                                  arguments[0].toString() +
                                  " ?",
                              negativeButtonText: S.of(context).no,
                              positiveButtonText: S.of(context).yes,
                              onNegativeClick: () {
                                Navigator.pop(context);
                              },
                              onPositiveClick: () async {
                                Navigator.pop(context);
                                bool success = await userMobx.removeBlockInChat(
                                    context, arguments[2]);
                                if (userMobx.Isdone == true) {
                                  setState(() {
                                    giftsMobx.setIsBlocked(false);
                                    giftsMobx.setShowUnblock(false);
                                  });
                                } else {}
                              },
                            );
                          },
                        );
                      },
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            // height: size.height / 13,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xcc292929),
                            ),
                            child: Text(
                              S.of(context).Youblockedthiscontact,
                              style: TextStyle(
                                color: Color(0xffc4c4c4),
                                fontSize: 14,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w900,
                                // letterSpacing: 1.050,
                              ),
                            )),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    giftsMobx.isOnline(context, userid).then((value) {
      if (giftsMobx.is_blocked == true) {
        setState(() {});
      }
    });

    profileMobx.getMyProfile(context, fromChat: true).then((value) {
      if (profileMobx.user!.profileImage == null) {
        havePhoto = false;
      } else {
        havePhoto = true;
      }
      x == 1 ? giftPopup() : print("");
    });
    animation = Tween<double>(begin: minWidth, end: maxWidth).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0,
          1,
          curve: Curves.easeInOutCubic,
        ),
      ),
    )..addListener(() {
        if ((animation == null ? minWidth : animation!.value) == maxWidth) {
          giftsMobx.setExpanded(true);
        } else {
          giftsMobx.setExpanded(false);
        }
      });

    // FirebaseApi.count(chatThred).then((value) {
    //   FirebaseApi.updateMessageCounterMin(value);
    // });

    //setState(() {}); //todo

    // getData().then((value) => x == 1 ? giftPopup() : print("sss"));
  }

  // Future<void> getData() async {
  //   await giftsMobx.getGiftCategories(context);
  // }
}

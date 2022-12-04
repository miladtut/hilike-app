import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hilike/Models/account.dart';
import 'package:hilike/Models/app.dart';

import 'package:hilike/Networking/Mobx/home_mobx.dart';
import 'package:hilike/Networking/Mobx/login_mobx.dart';
import 'package:hilike/Networking/Mobx/search_mobx.dart';
import 'package:hilike/Pages/InitialPages/Welcome.dart';
import 'package:hilike/Pages/userpages/EditProfile.dart';
import 'package:hilike/Pages/userpages/SearchResults.dart';
import 'package:hilike/Pages/userpages/StandartFilters.dart';
import 'package:hilike/Pages/userpages/UserSeeAll.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Utils/user_location.dart';
import 'package:hilike/Widget/CustomDialogBan.dart';
import 'package:hilike/Widget/FirstTimeDialog.dart';
import 'package:hilike/Widget/Navigation.dart';
import 'package:hilike/Widget/RegularProfilephoto.dart';
import 'package:hilike/Widget/SpecialPeopleProfilephoto.dart';
import 'package:hilike/Widget/VIPProfilephoto.dart';
import 'package:hilike/extensions.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Mainmenu extends StatefulWidget {
  final String? fromPage;
  Mainmenu({
    this.fromPage,
    Key? key,
  }) : super(key: key);
  @override
  _MainmenuState createState() => _MainmenuState();
}

class _MainmenuState extends State<Mainmenu> with AfterLayoutMixin {
  Position? userPosition;
  UserLocation? userLocation;
  HomeMobx homeMobx = HomeController();
  SearchMobx searchMobx = SearchController();
  LoginMobx loginMobx = LoginController();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    getUserLocation();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  final TextEditingController messageController = TextEditingController();

  var textDirection;
  Position? position;
  @override
  Widget build(BuildContext context) {
    userLocation = UserLocation(context);
    userLocation!.getUserLocation().then((value) {
      storage.pos = value;
      position = value;
    });

    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Observer(
        builder: (_) => Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(145),
            child: AppBar(
              // centerTitle: true,
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: size.height / 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Localizations.localeOf(context)
                                        .languageCode
                                        .toString() ==
                                    "ar"
                                ? size.width / 5.25
                                : size.width / 5.6),
                        child: Text(
                          S.of(context).hiLike,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.10,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'menu');
                        },
                        child: Container(
                            height: 14,
                            width: 20,
                            child: Image.asset(
                              "assets/img/menu.png",
                              matchTextDirection: true,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: Color(0xff292929),
              leading: Text(""),

              // actions: [

              // ],
              flexibleSpace: Column(
                children: [
                  Padding(
                    padding: Localizations.localeOf(context)
                                .languageCode
                                .toString() ==
                            "ar"
                        ? EdgeInsets.fromLTRB(
                            0, size.height / 7.8, size.width / 14, 10)
                        : EdgeInsets.fromLTRB(
                            size.width / 14, size.height / 7.8, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: size.width / 1.3,
                          height: size.height / 17.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xffe5e5e5),
                          ),
                          child: TextFormField(
                            cursorColor: Color(0xffe5003a),
                            onFieldSubmitted: (val) {
                              if (val.length > 0) {
                                searchMobx.resetFilter();
                                searchMobx.setOffset(0);
                                searchMobx.clearVip();
                                searchMobx.clearFeed();
                                searchMobx.setQuery(val);
                                FocusScope.of(context).unfocus();

                                Searchresults(
                                  lastSearch: val,
                                  searchMobx: searchMobx,
                                  fromMain: true,
                                ).launch(context);
                                messageController.clear();
                              }
                            },
                            textDirection: textDirection,
                            // maxLength: 18,
                            controller: messageController,
                            onChanged: (val) {
                              RegExp regex = new RegExp("[a-zA-Z]");
                              // print("test ${regex.hasMatch(val)}");
                              if (val.length > 0) {
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
                              } else if (val.length == 0) {
                                setState(() {});
                              }
                            },

                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    if (messageController.text.length > 0) {
                                      messageController.clear();
                                      FocusScope.of(context).unfocus();
                                    }
                                  },
                                  icon: messageController.text.length > 0
                                      ? Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xff5c5c5c),
                                            border: Border.all(
                                              color: Color(0xff5c5c5c),
                                              width: 2,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.close_rounded,
                                            size: 16,
                                            color: Color(0xffe5e5e5),
                                          ),
                                        )
                                      : Container()),
                              hintText: "${S.of(context).search_}",
                              hintStyle: TextStyle(
                                color: Color(0xff5c5c5c),
                                fontSize: 10,
                              ),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: GestureDetector(
                            onTap: () {
                              StandartFilters().launch(context);
                            },
                            child: Container(
                                height: 20,
                                width: 20,
                                child: Image.asset(
                                  "assets/img/menu3.png",
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          body: SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      homeMobx.welcomeMessage == ""
                          ? Container()
                          : Text(
                              homeMobx.welcomeMessage ?? "",
                              maxLines: 10,
                              style: TextStyle(
                                color: Color(0xffc4c4c4),
                                fontSize: 13,
                              ),
                            ),
                      SizedBox(
                        height: homeMobx.welcomeMessage == ""
                            ? 0
                            : size.height / 70,
                      ),
                      Visibility(
                        visible: homeMobx.vipUsers.length > 0 ? true : false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 3.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: Text(
                                S.of(context).vip,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.90,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Userseeall(from: ComesFrom.Vip).launch(context);
                              },
                              child: Text(
                                S.of(context).seeAll,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  letterSpacing: 0.65,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height / 80,
                ),
                Visibility(
                  visible: homeMobx.vipUsers.length > 0 ? true : false,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      disableCenter: false,
                      viewportFraction: 0.48,
                      autoPlay: true,
                      aspectRatio: 1.5,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        if (NavigationRow.settt == true) {
                          setState(() {
                            NavigationRow.settt = false;
                          });
                        }
                      },
                    ),
                    items: [
                      for (AccountModel item in homeMobx.vipUsers)
                        VIPProfilephoto(
                          userId: item.id ?? 0,
                          age: item.age,
                          withPhoto: item.profileImage != null ? false : true,
                          iscurs: true,
                          isonline: item.online,
                          country: item.residenceCountry ?? "",
                          distnce: item.distance == null
                              ? ""
                              : item.distance!.toStringAsFixed(2),
                          img: item.profileImage,
                          name: item.nickname ?? "",
                          subtype: item.plan ?? "Free",
                          isMale: item.isMale ?? true,
                          onBackFromPressUser: (isBlocked) {
                            if (isBlocked) {
                              homeMobx.getHome(context,
                                  lat: storage.pos.latitude,
                                  long: storage.pos.longitude);
                            }
                          },
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: homeMobx.vipUsers.length > 0 ? size.height / 40 : 0,
                ),
                Visibility(
                  visible: homeMobx.specialUsers.length > 0 ? true : false,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).specialPeople,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.90,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Userseeall(from: ComesFrom.SpecialPeople)
                                .launch(context);
                          },
                          child: Text(
                            S.of(context).seeAll,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              letterSpacing: 0.65,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height:
                      homeMobx.specialUsers.length > 0 ? size.height / 60 : 0,
                ),
                Visibility(
                  visible: homeMobx.specialUsers.length > 0 ? true : false,
                  child: SizedBox(
                    height: (size.width / 2 - 25) * 4 / 3,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: homeMobx.specialUsers.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, index) {
                              AccountModel item = homeMobx.specialUsers[index];
                              return SpecialPeopleProfilephoto(
                                userId: item.id ?? 0,
                                age: item.age,
                                withPhoto:
                                    item.profileImage == null ? true : false,
                                isonline: item.online,
                                country: item.residenceCountry ?? "",
                                distnce: item.distance == null
                                    ? ""
                                    : item.distance!.toStringAsFixed(2),
                                img: item.profileImage,
                                name: item.nickname ?? "",
                                subtype: item.plan ?? "Free",
                                isMale: item.isMale ?? true,
                                onBackFromPressUser: (isBlocked) {
                                  if (isBlocked) {
                                    homeMobx.getHome(context,
                                        lat: storage.pos.latitude,
                                        long: storage.pos.longitude);
                                    ;
                                  }
                                },
                              ).paddingAll(8);
                            },
                          ),
                        ),
                      ],
                    ),
                  ).paddingSymmetric(horizontal: 12),
                ),
                SizedBox(
                  height:
                      homeMobx.specialUsers.length > 0 ? size.height / 40 : 0,
                ),
                Visibility(
                  visible: homeMobx.suggestedUsers.length > 0 ? true : false,
                  child: Text(
                    S.of(context).suggestedPeople,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.90,
                    ),
                  ).paddingSymmetric(horizontal: 10),
                ),
                SizedBox(
                  height:
                      homeMobx.suggestedUsers.length > 0 ? size.height / 50 : 0,
                ),
                Visibility(
                  visible: homeMobx.suggestedUsers.length > 0 ? true : false,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: size.width / 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 17,
                    ),
                    itemCount: homeMobx.suggestedUsers.length,
                    itemBuilder: (ctx, index) {
                      AccountModel item = homeMobx.suggestedUsers[index];
                      return RegProfilephoto(
                        userId: item.id ?? 0,
                        withPhoto: item.profileImage == null ? true : false,
                        isonline: item.online,
                        age: item.age,
                        country: item.residenceCountry ?? "",
                        distnce: item.distance == null
                            ? ""
                            : item.distance!.toStringAsFixed(2),
                        img: item.profileImage,
                        name: item.nickname ?? "",
                        subtype: item.plan ?? "Free",
                        isMale: item.isMale!,
                        onBackFromPressUser: (isBlocked) {
                          if (isBlocked) {
                            homeMobx.getHome(context,
                                lat: storage.pos.latitude,
                                long: storage.pos.longitude);
                          }
                        },
                      );
                    },
                  ).paddingSymmetric(horizontal: 10),
                ),
                SizedBox(
                  height:
                      homeMobx.suggestedUsers.length > 0 ? size.height / 50 : 0,
                ),
                Visibility(
                  visible: homeMobx.newUsers.length > 0 ? true : false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).newPeople,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.90,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Userseeall(from: ComesFrom.NewPeople).launch(context);
                        },
                        child: Text(
                          S.of(context).seeAll,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            letterSpacing: 0.65,
                          ),
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 10),
                ),
                SizedBox(
                  height: homeMobx.newUsers.length > 0 ? size.height / 100 : 0,
                ),
                Visibility(
                  visible: homeMobx.newUsers.length > 0 ? true : false,
                  child: SizedBox(
                    height: (size.width / 2 - 25) * 4 / 3,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: homeMobx.newUsers.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (ctx, index) {
                                AccountModel item = homeMobx.newUsers[index];
                                return SpecialPeopleProfilephoto(
                                  userId: item.id ?? 0,
                                  age: item.age,
                                  isnew: true,
                                  country: item.residenceCountry ?? "",
                                  distnce: item.distance == null
                                      ? ""
                                      : item.distance!.toStringAsFixed(2),
                                  withPhoto:
                                      item.profileImage != null ? false : true,
                                  img: item.profileImage,
                                  isonline: item.online,
                                  name: item.nickname ?? "",
                                  subtype: item.plan ?? "Free",
                                  isMale: item.isMale ?? true,
                                  onBackFromPressUser: (isBlocked) {
                                    if (isBlocked) {
                                      homeMobx.getHome(context,
                                          lat: storage.pos.latitude,
                                          long: storage.pos.longitude);
                                    }
                                  },
                                ).paddingAll(8);
                              }),
                        ),
                      ],
                    ),
                  ).paddingSymmetric(horizontal: 12),
                ),
                SizedBox(
                  height: homeMobx.newUsers.length > 0 ? size.height / 45 : 5,
                ),
                Visibility(
                  visible: storage.showBox != true &&
                          (homeMobx.suggestedUsers.length > 0 ||
                              homeMobx.specialUsers.length > 0 ||
                              homeMobx.vipUsers.length > 0)
                      ? true
                      : false,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if ((homeMobx.profileProgress ?? 0) < 100)
                          Stack(children: [
                            Container(
                              // height: size.height / 4,
                              width: size.width / 1,
                              padding: const EdgeInsets.symmetric(vertical: 22),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xff292929),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 14),
                                      width: 60,
                                      height: 60,
                                      child: Image.asset(
                                          "assets/img/headphone.png")),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            S
                                                .of(context)
                                                .weRecommendThatYouCompleteYourPersonalPage
                                                .replaceAll("\\n", "\n"),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.w900,
                                              letterSpacing: 0.60,
                                            ),
                                            maxLines: 2,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            S
                                                .of(context)
                                                .mostOfTheUsersAreInterestedIn,
                                            style: TextStyle(
                                              color: Color(0xffc4c4c4),
                                              fontSize: 13,
                                              letterSpacing: 0.50,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            // margin: EdgeInsets.symmetric(vertical: 20),
                                            width: 150,
                                            height: 9,
                                            // color: Color(0xffD6D6D6),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                color: Color(0xffD6D6D6),
                                                width: 0.5,
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              child: StepProgressIndicator(
                                                totalSteps: 100,
                                                currentStep:
                                                    homeMobx.profileProgress ??
                                                        0,
                                                size: 8,
                                                padding: 0,
                                                unselectedColor:
                                                    Color(0xffD6D6D6),
                                                roundedEdges:
                                                    Radius.circular(15),
                                                selectedGradientColor:
                                                    LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    HexColor("#f01537"),
                                                    HexColor("#ffbc58")
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              EditProfile(
                                                onEditSuccess: () {
                                                  homeMobx.getHome(
                                                    context,
                                                    lat: storage.pos.latitude,
                                                    long: storage.pos.longitude,
                                                  );
                                                },
                                              ).launch(context);
                                            },
                                            child: Text(
                                              S.of(context).continueNow,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontFamily: "Roboto",
                                                fontWeight: FontWeight.w900,
                                                letterSpacing: 0.60,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Localizations.localeOf(context)
                                        .languageCode
                                        .toString() ==
                                    "ar"
                                ? Positioned(
                                    left: 0,
                                    top: 0,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          storage.showBox = true;
                                        });
                                      },
                                      icon: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                          border: Border.all(
                                            color: Color(0xffc4c4c4),
                                            width: 1,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.close_rounded,
                                          size: 16,
                                          color: Color(0xffc4c4c4),
                                        ),
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    right: 0,
                                    top: 0,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          storage.showBox = true;
                                        });
                                      },
                                      icon: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                          border: Border.all(
                                            color: Color(0xffc4c4c4),
                                            width: 1,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.close_rounded,
                                          size: 16,
                                          color: Color(0xffc4c4c4),
                                        ),
                                      ),
                                    ),
                                  ),
                          ]),
                        if ((homeMobx.profileProgress ?? 0) < 100)
                          SizedBox(
                            height: size.height / 50,
                          ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: homeMobx.likedYouUsers.length > 0 ? true : false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).peopleLikedYou,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.90,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Userseeall(from: ComesFrom.LikedYou).launch(context);
                        },
                        child: Text(
                          S.of(context).seeAll,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            letterSpacing: 0.65,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).paddingSymmetric(horizontal: 10),
                SizedBox(
                  height: size.height / 80,
                ),
                Visibility(
                  visible: homeMobx.likedYouUsers.length > 0 ? true : false,
                  child: SizedBox(
                    height: (size.width / 2 - 25) * 4 / 3,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: homeMobx.likedYouUsers.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, index) {
                              AccountModel item = homeMobx.likedYouUsers[index];
                              return SpecialPeopleProfilephoto(
                                userId: item.id ?? 0,
                                age: item.age,
                                isnew: true,
                                withPhoto:
                                    item.profileImage != null ? false : true,
                                isonline: item.online,
                                country: item.residenceCountry ?? "",
                                distnce: item.distance == null
                                    ? ""
                                    : item.distance!.toStringAsFixed(2),
                                img: item.profileImage,
                                name: item.nickname ?? "",
                                subtype: item.plan ?? "Free",
                                isMale: item.isMale ?? true,
                                onBackFromPressUser: (isBlocked) {
                                  if (isBlocked) {
                                    homeMobx.getHome(context,
                                        lat: storage.pos.latitude,
                                        long: storage.pos.longitude);
                                  }
                                },
                              ).paddingAll(8);
                            },
                          ),
                        ),
                      ],
                    ),
                  ).paddingSymmetric(horizontal: 12),
                ),
              ],
            ),
          ),
          bottomNavigationBar: NavigationRow(
            currentIndex: 0,
          ),
        ),
      ),
    );
  }

  Future<void> getUserLocation() async {
    // AppModel().firstRun
    //     ? print("object")
    //     : await showDialog(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return FirstTimeDialog();
    //         });

    if (storage.pos != null) {
      userPosition = storage.pos;
      homeMobx
          .getHome(context,
              lat: userPosition!.latitude, long: userPosition!.longitude)
          .then((value) {
        if (homeMobx.isban == true) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBan(
                  text: homeMobx.message!,
                  text2: homeMobx.expired!,
                );
              });

          Future.delayed(Duration(seconds: 8), () {
            loginMobx.logout(context, onSuccess: () async {
              await FirebaseAuth.instance.signOut();

              storage.clear();
              Welcome().launch(context, isNewTask: true);
            });
          });
        }
      });
    } else {
      homeMobx.getHome(context, lat: 0, long: 0).then((value) {
        if (homeMobx.isban == true) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBan(
                  text: homeMobx.message!,
                  text2: homeMobx.expired!,
                );
              });

          Future.delayed(Duration(seconds: 8), () {
            loginMobx.logout(context, onSuccess: () async {
              await FirebaseAuth.instance.signOut();

              storage.clear();
              Welcome().launch(context, isNewTask: true);
            });
          });
        }
      });
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getUserLocation();

    print("my id: ${storage.account.id}");
    if (widget.fromPage == "log") {
      Future.delayed(Duration(seconds: 4), () {
        // Navigator.pop(context);
        showTopSnackBar(S.of(context).Signed_in, "assets/img/check.png");
      });
    } else if (widget.fromPage == "new") {
      Future.delayed(Duration(seconds: 8), () {
        Navigator.pop(context);
        showDialog(
            barrierDismissible: false,
            context: App.materialKey!.currentContext!,
            builder: (BuildContext context) {
              return FirstTimeDialog();
            });
      });
    }
    homeMobx.getEditNotificationStatus(context);
  }
}

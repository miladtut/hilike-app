import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Models/user_image.dart';
import 'package:hilike/Networking/Mobx/login_mobx.dart';
import 'package:hilike/Networking/Mobx/profile_mobx.dart';
import 'package:hilike/Pages/InitialPages/Welcome.dart';
import 'package:hilike/Pages/userpages/EditProfile.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Utils/constants.dart';
import 'package:hilike/Widget/ContainerText.dart';
import 'package:hilike/Widget/CustomDialogBan.dart';
import 'package:hilike/Widget/GiftScroll.dart';
import 'package:hilike/Widget/Navigation.dart';
import 'package:hilike/Widget/UserAvatar.dart';
import 'package:hilike/Widget/UserDetails.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with AfterLayoutMixin {
  ProfileMobx profileMobx = ProfileController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).profilePage,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w900,
            letterSpacing: 1.10,
          ),
        ),
        elevation: 0,
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
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xff1A1A1A),
      body: Observer(
        builder: (_) => ListView(
          shrinkWrap: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                profileMobx.user == null
                    ? Container()
                    : Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                              color: Color(0xff292929),
                            ),
                            height: size.height / 4 + 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                width: size.height / 12,
                                height: size.height / 12,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: UserAvatar(
                                        image: profileMobx.user!.profileImage ??
                                            (profileMobx.user!.isMale ?? true
                                                ? imgMalePlaceholder
                                                : imgFemalePlaceholder),
                                        size: size.height / 12,
                                        plan: profileMobx.user!.plan ?? "Free",
                                      ),
                                    ),
                                    profileMobx.user!.online ?? false
                                        ? Positioned(
                                            left: size.height / 14.5,
                                            bottom: size.height / 17,
                                            child: Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: Color(0xff3BC148),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: Color(0xff505050),
                                                  width: 0.80,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
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
                                height: 3,
                              ),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text(
                                  profileMobx.user!.plan == "free"
                                      ? "${S.of(context).Free} ${S.of(context).account}"
                                      : "${profileMobx.user!.plan ?? ""} ${S.of(context).account}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, 'upgrade');
                                    },
                                    child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2),
                                        width: size.width / 4,
                                        height: Localizations.localeOf(context)
                                                    .languageCode
                                                    .toString() ==
                                                "ar"
                                            ? size.height / 22
                                            : size.height / 20,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                              fontSize: 11,
                                            ),
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      EditProfile(
                                        profileMobx: profileMobx,
                                        onEditSuccess: () {
                                          profileMobx.getMyProfile(context);
                                        },
                                      ).launch(context);
                                    },
                                    child: Container(
                                      width: size.width / 4,
                                      height: Localizations.localeOf(context)
                                                  .languageCode
                                                  .toString() ==
                                              "ar"
                                          ? size.height / 22
                                          : size.height / 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Color(0xffe5003a),
                                          width: 1,
                                        ),
                                        color: Color(0xffe5003a),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${S.of(context).edit}   ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                            ),
                                          ),
                                          Container(
                                              height: 12,
                                              width: 12,
                                              child: Image.asset(
                                                "assets/img/edit.png",
                                              )),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // SizedBox(
                              //   height: 8,
                              // )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                16, size.height / 4.35, 16, 10),
                            // height: size.height / ,
                            child: Container(
                                width: size.width / 1,
                                height: size.height / 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x59000000),
                                      blurRadius: 2,
                                      offset: Offset(0, 0),
                                    )
                                  ],
                                  color: Color(0xff292929),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "${S.of(context).originCountry}",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          profileMobx.user!.otherInfo == null
                                              ? ""
                                              : profileMobx.user!.otherInfo!
                                                      .originCountry ??
                                                  "",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 1,
                                      height: 47,
                                      color: Color(0xffc4c4c4),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "${S.of(context).residenceCountry}",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          profileMobx.user!.otherInfo == null
                                              ? ""
                                              : profileMobx.user!.otherInfo!
                                                      .residenceCountry ??
                                                  "",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 1,
                                      height: 47,
                                      color: Color(0xffc4c4c4),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "${S.of(context).age}",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${profileMobx.user!.isMale ?? true ? S.of(context).male : S.of(context).female}  ${profileMobx.user!.age ?? 0}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ),
              ],
            ),
            profileMobx.user == null
                ? Container()
                : Column(
                    children: [
                      if ((profileMobx.user!.gifts ?? []).isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).giftsReceived + ":",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.75,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'gseeall');
                                },
                                child: Text(
                                  S.of(context).seeAll,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    letterSpacing: 0.65,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      if ((profileMobx.user!.gifts ?? []).isNotEmpty)
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child:
                              GiftScroll(gifts: profileMobx.user!.gifts ?? []),
                        ),
                      Visibility(
                        visible: profileMobx.user!.images!.length == 0
                            ? false
                            : true,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
                          child: Container(
                            width: size.width / 1.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xff292929),
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16, 14, 16, 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).myPhotos,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.90,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Container(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          (profileMobx.user!.images ?? [])
                                              .length,
                                      gridDelegate:
                                          SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: size.width / 4,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                      ),
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (ctx, index) {
                                        UserImageModel item =
                                            profileMobx.user!.images![index];
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xff212121),
                                            ),
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              child: CachedNetworkImage(
                                                imageUrl: item.image ??
                                                    imgPlaceholder,
                                                fit: BoxFit.cover,
                                                progressIndicatorBuilder:
                                                    (context, url, progress) =>
                                                        Center(
                                                  child: Wrap(
                                                    alignment:
                                                        WrapAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        width: 20,
                                                        height: 20,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color:
                                                              Color(0xffe5003a),
                                                          strokeWidth: 2,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: profileMobx.user!.otherInfo!.about == null
                            ? false
                            : true,
                        child: ContainerText(
                          title: S.of(context).aboutMe,
                          text: profileMobx.user!.otherInfo == null
                              ? ""
                              : profileMobx.user!.otherInfo!.about ?? "",
                        ),
                      ),
                      Visibility(
                        visible: profileMobx.user!.otherInfo!.lookingFor == null
                            ? false
                            : true,
                        child: ContainerText(
                          title: S.of(context).iLookFor,
                          text: profileMobx.user!.otherInfo == null
                              ? ""
                              : profileMobx.user!.otherInfo!.lookingFor ?? "",
                        ),
                      ),
                      UserDetails(
                        user: profileMobx.user!,
                        isMyProfile: true,
                      ),
                    ],
                  ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationRow(
        currentIndex: 3,
      ),
    );
  }

  void afterFirstLayout(BuildContext context) {
    profileMobx.getMyProfile(context).then((value) {
      if (profileMobx.isban == true) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBan(
                text: profileMobx.message!,
                text2: profileMobx.expired!,
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
        storage.image = profileMobx.user!.profileImage;
        setState(() {});
      }
    });
  }
}

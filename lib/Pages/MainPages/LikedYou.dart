import 'package:after_layout/after_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Models/account.dart';
import 'package:hilike/Networking/Mobx/login_mobx.dart';
import 'package:hilike/Networking/Mobx/search_mobx.dart';
import 'package:hilike/Pages/InitialPages/Welcome.dart';
import 'package:hilike/Pages/userpages/StandartFilters.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Widget/CustomDialogBan.dart';
import 'package:hilike/Widget/EmptyDialog.dart';
import 'package:hilike/Widget/Navigation.dart';
import 'package:hilike/Widget/RegularProfilephoto.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class Likedyou extends StatefulWidget {
  @override
  _LikedyouState createState() => _LikedyouState();
}

class _LikedyouState extends State<Likedyou> with AfterLayoutMixin {
  SearchMobx searchMobx = SearchController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            S.of(context).fans,
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
        body: Observer(
          builder: (_) => LazyLoadScrollView(
            onEndOfPage: () {
              searchMobx.setOffset((searchMobx.offset ?? 0) + 1);
              searchMobx.search(context);
            },
            child: ListView(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
              shrinkWrap: true,
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
                SizedBox(
                  height: size.height / 70,
                ),
                Text(
                  S.of(context).chatWithPeopleWhoLikeYou,
                  style: TextStyle(
                    color: Color(0xffc4c4c4),
                    fontSize: 13,
                  ),
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                searchMobx.vipUsers.length +
                            searchMobx.searchFeedsUsers.length ==
                        0
                    ? EmptyBox(
                        descriptions: S.of(context).donthaveanyfans,
                        img: "assets/img/Group 2631.png",
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: size.width / 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: searchMobx.vipUsers.length +
                            searchMobx.searchFeedsUsers.length,
                        itemBuilder: (ctx, index) {
                          ObservableList<AccountModel> list =
                              ObservableList<AccountModel>.of([]);
                          list.addAll(searchMobx.vipUsers);
                          list.addAll(searchMobx.searchFeedsUsers);
                          AccountModel item = list[index];
                          return RegProfilephoto(
                            withPhoto: item.profileImage == null ? true : false,
                            userId: item.id ?? 0,
                            age: item.age,
                            country: item.residenceCountry ?? "",
                            distnce: (item.distance ?? 0.0).toStringAsFixed(2),
                            img: item.profileImage,
                            name: item.nickname ?? "",
                            subtype: item.plan ?? "Free",
                            isMale: item.isMale ?? true,
                            onBackFromPressUser: (isBlocked) {
                              if (isBlocked) {
                                searchMobx.search(context);
                              }
                            },
                          );
                        },
                      ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Wrap(
                    children: [
                      searchMobx.loading
                          ? Center(child: CircularProgressIndicator())
                          : Container(),
                    ],
                  ),
                ).paddingBottom(16),
              ],
            ),
          ),
        ),
        bottomNavigationBar: NavigationRow(
          currentIndex: 2,
        ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    searchMobx.setOffset(0);
    searchMobx.setLikedYou(true);
    searchMobx.search(context).then((value) {
      {
        if (searchMobx.isban == true) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBan(
                  text: searchMobx.message!,
                  text2: searchMobx.expired!,
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
          setState(() {});
        }
      }
    });
  }
}

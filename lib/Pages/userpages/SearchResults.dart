import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Models/account.dart';
import 'package:hilike/Networking/Mobx/search_mobx.dart';
import 'package:hilike/Widget/EmptyDialog.dart';

import 'package:hilike/Widget/Navigation.dart';
import 'package:hilike/Widget/RegularProfilephoto.dart';
import 'package:hilike/Widget/SpecialPeopleProfilephoto.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../../extensions.dart';
import 'StandartFilters.dart';
import 'UserSeeAll.dart';

class Searchresults extends StatefulWidget {
  final SearchMobx? searchMobx;
  final bool? fromMain;
  final String? lastSearch;

  const Searchresults(
      {Key? key, this.searchMobx, this.fromMain, this.lastSearch})
      : super(key: key);

  @override
  _SearchresultsState createState() => _SearchresultsState();
}

class _SearchresultsState extends State<Searchresults> with AfterLayoutMixin {
  SearchMobx searchMobx = SearchController();
  final TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    if ((widget.lastSearch ?? "").length > 0) {
      messageController.text = widget.lastSearch!;
    }
    super.initState();
    if (widget.searchMobx != null) searchMobx = widget.searchMobx!;
  }

  var textDirection;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
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
                              ? size.width / 4.5
                              : size.width / 5.9),
                      child: Text(
                        S.of(context).search__,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.10,
                        ),
                      ),
                    ),
                    GestureDetector(
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
                  padding:
                      Localizations.localeOf(context).languageCode.toString() ==
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
                              searchMobx.setQuery(val);
                              searchMobx.setOffset(0);
                              searchMobx.clearVip();
                              searchMobx.clearFeed();
                              searchMobx.search(context);
                              FocusScope.of(context).unfocus();
                            } else if (val.length == 0) {
                              setState(() {});
                            }
                          },
                          textDirection: textDirection,
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
                              searchMobx.vipUsers.clear();
                              searchMobx.searchFeedsUsers.clear();
                              setState(() {});
                              setState(() {});
                            }
                          },
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText: "${S.of(context).search_}",
                            hintStyle: TextStyle(
                              color: Color(0xff5c5c5c),
                              fontSize: 10,
                              // letterSpacing: 0.65,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  if (messageController.text.length > 0) {
                                    // messageController.clear();
                                    // FocusScope.of(context).unfocus();
                                    // searchMobx.vipUsers.clear();
                                    // searchMobx.searchFeedsUsers.clear();
                                    // setState(() {});
                                    Navigator.pop(context);
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
                            widget.fromMain!
                                ? StandartFilters().launch(context)
                                : Navigator.pop(context);
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
        body: Observer(
          builder: (_) => LazyLoadScrollView(
            onEndOfPage: () {
              searchMobx.setOffset((searchMobx.offset ?? 0) + 1);
              // searchMobx.searchFeedsUsers.length == 0 ||
              //         searchMobx.searchFeedsUsers.length < 15
              //     ? print("no more")
              //     :
              searchMobx.numberSearch == 0 || searchMobx.numberSearch! < 15
                  ? print("no more")
                  : searchMobx.search(context);
            },
            child: ListView(shrinkWrap: true, children: [
              Visibility(
                visible: searchMobx.vipUsers.length > 0 ? true : false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                          Userseeall(
                                  from: ComesFrom.searchVip,
                                  searchMobx: searchMobx)
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
                height: searchMobx.vipUsers.length > 0 ? size.height / 80 : 1,
              ),
              Visibility(
                visible: searchMobx.vipUsers.length > 0 ? true : false,
                child: SizedBox(
                  height: (size.width / 2 - 25) * 4 / 3,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: searchMobx.vipUsers.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            AccountModel item = searchMobx.vipUsers[index];
                            return SpecialPeopleProfilephoto(
                              userId: item.id ?? 0,
                              withPhoto:
                                  item.profileImage != null ? false : true,
                              age: item.age,
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
                                  searchMobx.clearFeed();
                                  searchMobx.setOffset(0);
                                  searchMobx.search(context);
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
                height: searchMobx.vipUsers.length > 0 ? size.height / 40 : 1,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  S.of(context).searchFeed,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.90,
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 60,
              ),
              searchMobx.searchFeedsUsers.length == 0
                  ? EmptyBox(
                      descriptions: S.of(context).Searchdidnot,
                      img: "assets/img/Group 2628.png",
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
                      itemCount: searchMobx.searchFeedsUsers.length,
                      itemBuilder: (ctx, index) {
                        AccountModel item = searchMobx.searchFeedsUsers[index];
                        return RegProfilephoto(
                          withPhoto: item.profileImage == null ? true : false,
                          userId: item.id ?? 0,
                          age: item.age,
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
                              searchMobx.setOffset(0);
                              searchMobx.clearFeed();
                              searchMobx.search(context);
                            }
                          },
                        );
                      },
                    ).paddingSymmetric(horizontal: 20),
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
              ),
            ]),
          ),
        ),
        bottomNavigationBar: NavigationRow(
          currentIndex: 5,
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    searchMobx.setOffset(0);
    searchMobx.search(context);
  }
}

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Models/account.dart';
import 'package:hilike/Networking/Mobx/search_mobx.dart';
import 'package:hilike/Networking/Mobx/see_all_mobx.dart';
import 'package:hilike/Widget/Appbar60.dart';
import 'package:hilike/Widget/RegularProfilephoto.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

import '../../extensions.dart';

class Userseeall extends StatefulWidget {
  final ComesFrom from;
  final SearchMobx? searchMobx;

  const Userseeall({Key? key, required this.from, this.searchMobx})
      : super(key: key);

  @override
  UserseeallState createState() => UserseeallState();
}

class UserseeallState extends State<Userseeall> with AfterLayoutMixin {
  SeeAllMobx seeAllMobx = SeeAllController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Appbar60(
            title: widget.from == ComesFrom.NewPeople
                ? S.of(context).newPeople
                : widget.from == ComesFrom.LikedYou
                    ? S.of(context).likedYou
                    : widget.from == ComesFrom.SpecialPeople
                        ? S.of(context).specialPeople
                        : S.of(context).vip,
          )),
      body: Observer(
        builder: (_) => Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Color(0xffe5003a),
            // disabledColor: Colors.blue
          ),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: size.width / 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: widget.searchMobx != null
                ? widget.searchMobx!.vipUsers.length
                : seeAllMobx.users.length,
            itemBuilder: (ctx, index) {
              AccountModel item = widget.searchMobx != null
                  ? widget.searchMobx!.vipUsers[index]
                  : seeAllMobx.users[index];
              return RegProfilephoto(
                userId: item.id ?? 0,
                age: item.age,
                //  isnew: true,
                withPhoto: item.profileImage != null ? false : true,
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
                    getData();
                  }
                },
              );
            },
          ).paddingSymmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  void getData() {
    switch (widget.from) {
      case ComesFrom.Vip:
        seeAllMobx.getVip(context);
        break;
      case ComesFrom.SpecialPeople:
        seeAllMobx.getSpecialPeople(context);
        break;
      case ComesFrom.LikedYou:
        seeAllMobx.getLikedYou(context);
        break;
      case ComesFrom.NewPeople:
        seeAllMobx.getNewPeople(context);
        break;
      case ComesFrom.searchVip:
        widget.searchMobx!.setVip(true);
        widget.searchMobx!.search(context);
        Navigator.pop(context);
        break;
    }
    // Navigator.pop(context);
  }
}

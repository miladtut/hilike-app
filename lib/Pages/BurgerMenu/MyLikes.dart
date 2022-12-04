import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Models/account.dart';
import 'package:hilike/Networking/Mobx/menu_mobx.dart';
import 'package:hilike/Widget/Appbar60.dart';
import 'package:hilike/Widget/Navigation.dart';
import 'package:hilike/Widget/RegularProfilephoto.dart';
import 'package:hilike/generated/l10n.dart';

class MyLikes extends StatefulWidget {
  @override
  _MyLikesState createState() => _MyLikesState();
}

class _MyLikesState extends State<MyLikes> with AfterLayoutMixin {
  MenuMobx menuMobx = MenuController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Appbar60(
          title: S.of(context).myLikes,
        ),
      ),
      body: Observer(
        builder: (_) => ListView(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
          shrinkWrap: true,
          children: [
            Text(
              S.of(context).likedPeople,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w900,
                letterSpacing: 0.90,
              ),
            ),
            SizedBox(
              height: size.height / 80,
            ),
            Text(
              S.of(context).youCanSeeTheProfilesThatYouLikedEarlier,
              style: TextStyle(
                color: Color(0xffc4c4c4),
                fontSize: 13,
              ),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: size.width / 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 15,
                mainAxisSpacing: 10,
              ),
              itemCount: menuMobx.likedUsers.length,
              itemBuilder: (ctx, index) {
                AccountModel item = menuMobx.likedUsers[index];
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
                    menuMobx.getMyLikes(context);
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationRow(
        currentIndex: 5,
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    menuMobx.getMyLikes(context);
  }
}

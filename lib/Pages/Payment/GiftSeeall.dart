import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Models/gift.dart';
import 'package:hilike/Networking/Mobx/gifts_mobx.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Utils/constants.dart';
import 'package:hilike/Widget/Appbar60.dart';
import 'package:hilike/Widget/GiftCol.dart';
import 'package:hilike/generated/l10n.dart';

class GiftSeeall extends StatefulWidget {
  @override
  _GiftSeeallState createState() => _GiftSeeallState();
}

class _GiftSeeallState extends State<GiftSeeall> with AfterLayoutMixin {
  GiftsMobx giftsMobx = GiftsController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Observer(
      builder: (_) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Appbar60(
            title: S.of(context).giftsReceived,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
          shrinkWrap: true,
          children: [
            Text(
              S.of(context).giftsReceived + ":",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w900,
                letterSpacing: 0.90,
              ),
            ),
            SizedBox(
              height: size.height / 75,
            ),
            Text(
              S
                  .of(context)
                  .giftsYouReceivedFromPeopleWhoLikeYou
                  .replaceAll("\\n", "\n"),
              style: TextStyle(
                color: Color(0xffc4c4c4),
                fontSize: 13,
              ),
            ),
            SizedBox(
              height: size.height / 32,
            ),
            Container(
              width: size.width / 5,
              padding: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xff292929),
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: size.width / 3,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemCount: giftsMobx.gifts.length,
                itemBuilder: (ctx, index) {
                  GiftModel item = giftsMobx.gifts[index];

                  return GiftCol(
                    userId: item.userId ?? 0,
                    name: "",
                    subtype: 1,
                    img: item.image ?? imgPlaceholder,
                    price: item.price ?? 0,
                    rimg: item.profileImage ??
                        (storage.account.isMale == true
                            ? imgFemalePlaceholder
                            : imgMalePlaceholder),
                    isBuyGiftPage: false,
                  );
                },
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    giftsMobx.getMyGifts(context);
  }
}

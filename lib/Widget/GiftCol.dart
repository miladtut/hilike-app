import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Networking/Mobx/user_mobx.dart';
import 'package:hilike/Pages/userpages/pressuser.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:nb_utils/src/extensions/widget_extensions.dart';

import 'UserAvatar.dart';

class GiftCol extends StatefulWidget {
  const GiftCol(
      {Key? key,
      required this.img,
      required this.rimg,
      required this.price,
      this.userId,
      this.name,
      this.isBlocked = false,
      required this.subtype,
      required this.isBuyGiftPage})
      : super(key: key);
  final String img, rimg;
  final num price, subtype;
  final bool isBuyGiftPage;
  final bool isBlocked;
  final String? name;
  final int? userId;

  @override
  _GiftColState createState() => _GiftColState();
}

class _GiftColState extends State<GiftCol> with TickerProviderStateMixin {
  late AnimationController _iconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      // value: 15.0,
      lowerBound: 14.0,
      upperBound: 17);
  UserMobx userMobx = UserController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        GestureDetector(
          onTap: _onTap,
          child: Container(
            width: widget.isBuyGiftPage ? 75 : size.width / 4.6,
            height: widget.isBuyGiftPage ? 75 : size.height / 9.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white,
                width: 0.50,
              ),
              color: Color(0xff212121),
            ),
            child: ScaleTransition(
              scale: _iconAnimationController,
              child: Image.network(
                widget.img,
                scale: 90,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.isBuyGiftPage
                ? SizedBox(
                    width: 0.001,
                  )
                : UserAvatar(
                    image: widget.rimg,
                    size: 32,
                    onClick: () async {
                      Pressuser(
                        userId: widget.userId ?? 0,
                        onFinish: (bool isBlocked) {
                          // widget.onBackFromPressUser(isBlocked);
                        },
                      ).launch(context);
                    }),
            Container(
                width: size.width / 12,
                height: size.height / 34,
                child: Image.asset(
                  "assets/img/gold.png",
                )),
            Text(
              "${widget.price}",
              // textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xfff5f5f5),
                fontSize: 14,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w700,
                letterSpacing: 0.60,
              ),
            ),
          ],
        )
      ],
    );
  }

  void _onTap() {
    _iconAnimationController.forward().then((value) {
      _iconAnimationController.reverse();
    });
  }
}

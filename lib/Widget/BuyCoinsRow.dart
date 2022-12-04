import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:hilike/Networking/Mobx/plans_mobx.dart';
import 'package:hilike/Pages/Payment/AppPurchaseView.dart';
import 'package:hilike/generated/l10n.dart';
import 'dart:io' show Platform;

import 'package:nb_utils/src/extensions/widget_extensions.dart';

class BuyCoinsRow extends StatefulWidget {
  final String text, coin, id;

  const BuyCoinsRow({
    Key? key,
    required this.coin,
    required this.id,
    required this.text,
  }) : super(key: key);

  @override
  _BuyCoinsRowState createState() => _BuyCoinsRowState();
}

class _BuyCoinsRowState extends State<BuyCoinsRow> {
  PlansMobx plansMobx = PlansController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              if (plansMobx.reqestApi == false && Platform.isIOS) {
                await plansMobx.setReqestApi(true);
                await plansMobx.applePay(context, "1");
                plansMobx.setReqestApi(false);
                plansMobx.ApplePay == "true"
                    ? AppleView(
                        type: 'coins',
                      ).launch(context)
                    : Navigator.pushNamed(context, 'pay', arguments: [
                        (widget.text).replaceAll(new RegExp(r'[^0-9]'), ''),
                        widget.id,
                        "null",
                        "null"
                      ]);
              } else if (plansMobx.reqestApi == false) {
                Navigator.pushNamed(context, 'pay', arguments: [
                  (widget.text).replaceAll(new RegExp(r'[^0-9]'), ''),
                  widget.id,
                  "null",
                  "null"
                ]);
              }
            },
            child: Container(
              width: Localizations.localeOf(context).languageCode.toString() ==
                      "ar"
                  ? 120
                  : 100,
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color(0xffffb84f),
                  width: 1,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).buy,
                      style: TextStyle(
                        color: Color(0xfff5f5f5),
                        fontSize: 12,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.60,
                      ),
                    ),
                    Text(
                      widget.text,
                      style: TextStyle(
                        color: Color(0xfff5f5f5),
                        fontSize: 12,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.60,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.coin,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xfff5f5f5),
                  fontSize: 15,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.75,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    "assets/img/gold.png",
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

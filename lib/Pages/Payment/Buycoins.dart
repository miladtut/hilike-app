import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Models/coins.dart';
import 'package:hilike/Networking/Mobx/plans_mobx.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Widget/Appbar60.dart';

import 'package:hilike/Widget/BuyCoinsRow.dart';
import 'package:hilike/generated/l10n.dart';

class Buycoins extends StatefulWidget {
  @override
  _BuycoinsState createState() => _BuycoinsState();
}

class _BuycoinsState extends State<Buycoins> with AfterLayoutMixin {
  PlansMobx plansMobx = PlansController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Observer(
      builder: (_) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Appbar60(
            title: S.of(context).RechargeCoins,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Text(
                  S.of(context).Balance + ":",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.90,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Row(
                  children: [
                    Text(
                      "${plansMobx.balance}",
                      style: TextStyle(
                        color: Color(0xfff5f5f5),
                        fontSize: 16,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.60,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          height: 25,
                          width: 25,
                          child: Image.asset(
                            "assets/img/gold.png",
                          )),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              // width: size.width / ,
              height: size.height / 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xff292929),
              ),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: Center(
                    child: Image.asset(
                      "assets/img/goldbag.png",
                      scale: 10,
                    ),
                  )),
            ),
            SizedBox(
              height: 28,
            ),
            for (CoinsModel coin in plansMobx.coins)
              BuyCoinsRow(
                text: (coin.price ?? 0) > 0
                    ? "${coin.price!.toStringAsFixed(0)}\$"
                    : S.of(context).freeTrial,
                coin: "${coin.coins ?? 0}",
                id: "${coin.id ?? 0}",
              ),
            SizedBox(
              height: 28,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).ifYouNeedHelpPlease,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.65,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'Steam',
                          arguments: [0, storage.account.plan]);
                    },
                    child: Text(
                      S.of(context).contactUs,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff0583f2),
                        fontFamily: 'Roboto',
                        fontSize: 13,
                        letterSpacing: 0.65,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    plansMobx.getMyBalance(context);
    plansMobx.getCoins(context);
  }
}

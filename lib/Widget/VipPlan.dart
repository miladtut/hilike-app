import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hilike/Models/plan.dart';
import 'package:hilike/Networking/Mobx/plans_mobx.dart';
import 'package:hilike/Pages/Payment/AppPurchaseView.dart';
import 'package:hilike/generated/l10n.dart';
import 'dart:io' show Platform;

import 'package:nb_utils/src/extensions/widget_extensions.dart';

import '../extensions.dart';
import 'looding.dart';

class VipPlan extends StatelessWidget {
  final String name;
  final int months, per;
  final double price;
  final double packagePrice;
  final Function() onClick;
  final PlansMobx plansMobx;
  final int index, id;

  const VipPlan({
    Key? key,
    required this.name,
    required this.months,
    required this.price,
    required this.id,
    required this.per,
    required this.packagePrice,
    required this.onClick,
    required this.plansMobx,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Observer(
      builder: (_) => Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: GestureDetector(
              onTap: () async {
                onClick();
                // print("sss");

                if (plansMobx.reqestApi == false && Platform.isIOS) {
                  await plansMobx.setReqestApi(true);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Loadoingw();
                      });
                  await plansMobx.applePay(context, "1");
                  Navigator.pop(context);
                  if (isNavOpen == false) {
                    Navigator.pop(context);
                    isNavOpen = true;
                  }
                  plansMobx.setReqestApi(false);
                  plansMobx.ApplePay == "true"
                      ? AppleView(
                          type: 'VIP',
                        ).launch(context)
                      : Navigator.pushNamed(context, 'pay',
                          arguments: [price, "3", id, months]);
                } else if (plansMobx.reqestApi == false) {
                  Navigator.pushNamed(context, 'pay',
                      arguments: [price, "3", id, months]);
                }
              },
              child: Container(
                width: size.width,
                // height: size.height / 10,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: plansMobx.selectedIndex == index
                        ? [Color(0xffF01537), Color(0xffFFBC58)]
                        : [Color(0x1A1A1A), Color(0x1A1A1A)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "$months",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    SizedBox(width: 4),
                    // packagePrice > price
                    //     ?
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              months == 1
                                  ? S.of(context).month
                                  : S.of(context).months,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.60,
                              ),
                            ),
                            SizedBox(width: 4),
                            if (packagePrice != price)
                              Container(
                                width: 48,
                                height: 15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xffe5e5e5),
                                ),
                                child: Center(
                                  child: Text(
                                    "${S.of(context).save.toUpperCase()} ${per}%",
                                    style: TextStyle(
                                      color: Color(0xff5c5c5c),
                                      fontSize: 9,
                                      letterSpacing: 0.35,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 2),
                        RichText(
                          // textAlign: TextAlign.justify,
                          text: TextSpan(
                            children: <TextSpan>[
                              if (packagePrice != price)
                                TextSpan(
                                  text: '${packagePrice.toStringAsFixed(2)}\$',
                                  style: TextStyle(
                                    color: Color(0xfff5f5f5),
                                    fontSize: 10,
                                    letterSpacing: 0.40,
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 2,
                                  ),
                                ),
                              TextSpan(
                                text: packagePrice != price
                                    ? '  US\$ ${price.toStringAsFixed(2)}'
                                    : 'US\$ ${price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Color(0xfff5f5f5),
                                  fontSize: 10,
                                  letterSpacing: 0.40,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                    // : Container()
                    // Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         months == 1
                    //             ? S.of(context).month
                    //             : S.of(context).months,
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 12,
                    //           fontFamily: "Roboto",
                    //           fontWeight: FontWeight.w500,
                    //           letterSpacing: 0.60,
                    //         ),
                    //       ),
                    //       SizedBox(height: 2),
                    //       Text(
                    //         'US\$ ${price.toStringAsFixed(2)}',
                    //         style: TextStyle(
                    //           color: Color(0xfff5f5f5),
                    //           fontSize: 8,
                    //           letterSpacing: 0.40,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: size.width / 6,
            height: size.height / 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white,
                width: 0.50,
              ),
              color: Color(0xff292929),
            ),
            child: Center(
              child: Text(
                S.of(context).package,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

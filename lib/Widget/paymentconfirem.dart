import 'dart:ui';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Networking/Mobx/plans_mobx.dart';
import 'package:hilike/Pages/MainPages/MainMenu.dart';
import 'package:hilike/generated/l10n.dart';

class PaymentConf extends StatefulWidget {
  final bool status, fromCoins, free;
  const PaymentConf(
      {Key? key,
      required this.status,
      required this.fromCoins,
      required this.free})
      : super(key: key);

  @override
  _PaymentConfState createState() => _PaymentConfState();
}

class _PaymentConfState extends State<PaymentConf> {
  PlansMobx plansMobx = PlansController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if(widget.status==true) {
      if(widget.fromCoins == true)
        {
          final firebaseAnalytics = FirebaseAnalytics.instance;
          firebaseAnalytics.logEvent(name: 'New_Coins_Payment',parameters:null);
        }
      else
        {
          final firebaseAnalytics = FirebaseAnalytics.instance;
          firebaseAnalytics.logEvent(name: 'New_Subscription',parameters:null);
        }
    }
    return GestureDetector(
      onTap: () {
        // if (widget.status == true) {
        //   if (widget.fromCoins == false) {
        //     widget.free
        //         ? Navigator.pushReplacementNamed(context, 'messages')
        //         : Navigator.pushAndRemoveUntil(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (BuildContext context) => Mainmenu()),
        //             ModalRoute.withName('/'),
        //           );
        //   } else {
        //     Navigator.pop(context);
        //     Navigator.pop(context);
        //     Navigator.pop(context);

        //     // Navigator.pop(context);
        //   }
        // } else {
        //   Navigator.pop(context);
        // }
      },
      child: AlertDialog(
          backgroundColor: Color(0xff292929),
          actionsPadding: EdgeInsets.all(25.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          actions: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      widget.status
                          ? "assets/img/Gcheck.png"
                          : "assets/img/Group 2627.png",
                      // scale: 2,
                    ),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  Text(
                    widget.free
                        ? S.of(context).upgradePlanScuss
                        : widget.status
                            ? S.of(context).payPlanScuss
                            : S.of(context).somethingIsWrong,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 0.65,
                      fontSize: 18,
                      color:
                          widget.status ? Color(0xff80c56e) : Color(0xffE5003A),
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.status
                        ? S.of(context).Welcome
                        : S.of(context).PleaseTryAgain,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            )
          ]),
    );
  }
}

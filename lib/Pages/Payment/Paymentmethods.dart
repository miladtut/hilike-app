import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:hilike/Networking/Mobx/plans_mobx.dart';
import 'package:hilike/Widget/Appbar60.dart';
import 'package:hilike/Widget/PaymentRow.dart';
import 'package:hilike/extensions.dart';
import 'package:hilike/generated/l10n.dart';

import 'AppPurchase.dart';
import 'WebviewPage.dart';

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int _radioValue = -1;

  void _handleRadioValueChange(value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          payway = "card";
          break;
        case 1:
          payway = "apple";
          break;
        case 2:
          payway = "google";
          break;
      }
    });
    // print("objectttt ${arguments[3]}");
  }

  String? payway;
  void _handleURLButtonPress(BuildContext context, String url, y) {
    String x = _radioValue == 0 ? "MyFatoorah" : "Stripe";
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebViewContainer(plansMobx.purl!, x, y)));
  }

  PlansMobx plansMobx = PlansController();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as List;

    Size size = MediaQuery.of(context).size;
    print("objects ${arguments[3]}");
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Appbar60(
          title: S.of(context).paymentMethods,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.fromLTRB(15, 23, 15, 0),
        children: [
          Text(
            S.of(context).choosePaymentMethods,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w900,
              letterSpacing: 0.90,
            ),
          ),
          SizedBox(
            height: size.height / 90,
          ),
          Text(
            S.of(context).chooseConvenientPaymentMethodForTheService,
            style: TextStyle(
              color: Color(0xffc4c4c4),
              fontSize: 13,
            ),
          ),
          SizedBox(
            height: size.height / 40,
          ),
          PaymentRow(
              funcation: () {
                setState(() {
                  _radioValue = 0;
                });
                _handleRadioValueChange(0);
              },
              text: Localizations.localeOf(context).languageCode.toString() ==
                      "ar"
                  ? "ادفع عبر الائتمان / كي نت"
                  : "Pay Via Credit/Debit Card",
              img: "assets/img/card.png",
              first: true,
              wid: new Radio(
                activeColor: Colors.white,
                value: 0,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
              ),
              durtaion: arguments[3].toString()),
          SizedBox(
            height: size.height / 60,
          ),
          PaymentRow(
              funcation: () {
                setState(() {
                  _radioValue = 1;
                });
                _handleRadioValueChange(1);
              },
              text: S.of(context).payViaAppleStore,
              img: "assets/img/Papple.png",
              first: false,
              wid: new Radio(
                activeColor: Colors.white,
                value: 1,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
              ),
              durtaion: arguments[3].toString()),
          SizedBox(
            height: size.height / 60,
          ),
          PaymentRow(
              funcation: () {
                setState(() {
                  _radioValue = 2;
                });
                _handleRadioValueChange(2);
              },
              text: S.of(context).payViaGoogleStore,
              img: "assets/img/Pgoogle.png",
              first: false,
              wid: new Radio(
                activeColor: Colors.white,
                value: 2,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
              ),
              durtaion: arguments[3].toString()),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          vertical: size.height / 35,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
                onTap: () {
                  if (_radioValue == -1) {
                    showTopSnackBar(
                        S.of(context).youHaveToSelectPaymentMeathodFirst,
                        "assets/img/iii.png");
                  } else {
                    if (arguments[2] == "null") {
                      plansMobx
                          .paymentStreb(context, arguments[1], payway!)
                          .then((value) => {
                                _handleURLButtonPress(context, plansMobx.purl!,
                                    arguments[3].toString())
                              });
                    } else {
                      if (arguments[3].toString() == "1") {
                        plansMobx
                            .paymentStrebplan(context, arguments[1], payway!)
                            .then((value) => {
                                  _handleURLButtonPress(context,
                                      plansMobx.purl!, arguments[3].toString())
                                });
                      } else {
                        plansMobx
                            .paymentStrebplanwithPackage(
                                context, arguments[1], payway!, arguments[2])
                            .then((value) => {
                                  _handleURLButtonPress(context,
                                      plansMobx.purl!, arguments[3].toString())
                                });
                      }
                    }
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  width: size.width / 1,
                  height: size.height / 13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff292929),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(33, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${arguments[0]}\$",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.90,
                            ),
                          ),
                        ),
                        Text(
                          S.of(context).payNow,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.75,
                          ),
                        ),
                        SizedBox(
                          width: size.width / 22,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.white,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: size.height / 50,
            ),
            Visibility(
              visible: _radioValue != -1 ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 11,
                    height: 14.09,
                    child: Image.asset("assets/img/verf.png"),
                  ),
                  Text(
                    _radioValue == 0
                        ? "  ${S.of(context).garnted} MyFatoorah"
                        : "  ${S.of(context).garnted} Stripe",
                    style: TextStyle(
                      color: Color(0xff3ac148),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

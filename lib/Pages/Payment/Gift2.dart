import 'package:flutter/material.dart';

import 'package:hilike/Widget/customDialogwithphoto.dart';

class Gifts2 extends StatefulWidget {
  @override
  _Gifts2State createState() => _Gifts2State();
}

class _Gifts2State extends State<Gifts2> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Localizations.localeOf(context).languageCode.toString() == "ar"
                  ? Icons.arrow_back_ios
                  : Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 16,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Buy Gifts",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w900,
              letterSpacing: 1.10,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Color(0xff292929),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          "assets/img/gold.png",
                        )),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "85",
                    style: TextStyle(
                      color: Color(0xfff5f5f5),
                      fontSize: 12,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.60,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Send the gift",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.90,
                ),
              ),
              Text(
                "Pay 25 Coins ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  letterSpacing: 0.70,
                ),
              )
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Container(
            // width: size.width / ,
            height: size.height / 4.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xff292929),
            ),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(17, 15, 17, 8),
                child: Image.asset(
                  "assets/img/gift.png",
                  scale: 10,
                )),
          ),
          SizedBox(
            height: 23,
          ),
          GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialogBox(
                        title: "Not enough coins",
                        descriptions:
                            "There are not enough coins in your account, \nplease top up your account",
                        text: "BUY",
                        text2: "Cancel",
                        img: "assets/img/gold.png",
                      );
                    });
              },
              child: Container(
                width: size.width / 1,
                height: size.height / 13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color(0xfff5f5f5),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    "Send",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.75,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

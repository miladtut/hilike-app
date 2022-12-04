import 'package:flutter/material.dart';
import 'package:hilike/Widget/GiftCol.dart';

class Gifts1 extends StatefulWidget {
  @override
  _Gifts1State createState() => _Gifts1State();
}

class _Gifts1State extends State<Gifts1> {
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
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                      "assets/img/gold.png",
                    )),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
        shrinkWrap: true,
        children: [
          Text(
            "Choose a gift alerts",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w900,
              letterSpacing: 0.90,
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            "Choose a worthy gift and send it to the person you like\nSo that the gift appears as an alert on your message to \nattract people",
            style: TextStyle(
              color: Color(0xffc4c4c4),
              fontSize: 13,
            ),
          ),
          SizedBox(
            height: 27,
          ),
          Text(
            "Category 1",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w900,
              letterSpacing: 0.90,
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            "Choose a gift from the list",
            style: TextStyle(
              color: Color(0xffc4c4c4),
              fontSize: 13,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Container(
            // width: size.width / ,
            height: size.height / 2.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xff292929),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(17, 15, 17, 8),
              child: PageView(
                  controller: PageController(initialPage: 0),
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                GiftCol(
                                  subtype: 0,
                                  img: "assets/img/sticker1.png",
                                  price: 40,
                                  rimg: "assets/img/roundgirl.png",
                                  isBuyGiftPage: true,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GiftCol(
                                  subtype: 0,
                                  img: "assets/img/sticker2.png",
                                  price: 40,
                                  rimg: "assets/img/roundgirl.png",
                                  isBuyGiftPage: true,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                GiftCol(
                                  subtype: 0,
                                  img: "assets/img/sticker1.png",
                                  price: 40,
                                  rimg: "assets/img/roundgirl.png",
                                  isBuyGiftPage: true,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GiftCol(
                                  subtype: 0,
                                  img: "assets/img/sticker2.png",
                                  price: 40,
                                  rimg: "assets/img/roundgirl.png",
                                  isBuyGiftPage: true,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                GiftCol(
                                  subtype: 0,
                                  img: "assets/img/sticker2.png",
                                  price: 40,
                                  rimg: "assets/img/roundgirl.png",
                                  isBuyGiftPage: true,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GiftCol(
                                  subtype: 0,
                                  img: "assets/img/sticker1.png",
                                  price: 40,
                                  rimg: "assets/img/roundgirl.png",
                                  isBuyGiftPage: true,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                GiftCol(
                                  subtype: 0,
                                  img: "assets/img/sticker3.png",
                                  price: 40,
                                  rimg: "assets/img/roundgirl.png",
                                  isBuyGiftPage: true,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GiftCol(
                                  subtype: 0,
                                  img: "assets/img/sticker3.png",
                                  price: 40,
                                  rimg: "assets/img/roundgirl.png",
                                  isBuyGiftPage: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xff5c5c5c),
                                  width: 1,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xff5c5c5c),
                                  width: 1,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xff5c5c5c),
                                  width: 1,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xff5c5c5c),
                                  width: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                GiftCol(
                                  subtype: 0,
                                  img: "assets/img/sticker1.png",
                                  price: 40,
                                  rimg: "assets/img/roundgirl.png",
                                  isBuyGiftPage: true,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GiftCol(
                                  subtype: 0,
                                  img: "assets/img/sticker2.png",
                                  price: 40,
                                  rimg: "assets/img/roundgirl.png",
                                  isBuyGiftPage: true,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                GiftCol(
                                  subtype: 0,
                                  img: "assets/img/sticker1.png",
                                  price: 40,
                                  rimg: "assets/img/roundgirl.png",
                                  isBuyGiftPage: true,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GiftCol(
                                  subtype: 0,
                                  img: "assets/img/sticker3.png",
                                  price: 40,
                                  rimg: "assets/img/roundgirl.png",
                                  isBuyGiftPage: true,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                GiftCol(
                                  subtype: 0,
                                  img: "assets/img/sticker1.png",
                                  price: 40,
                                  rimg: "assets/img/roundgirl.png",
                                  isBuyGiftPage: true,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GiftCol(
                                  subtype: 0,
                                  img: "assets/img/sticker3.png",
                                  price: 40,
                                  rimg: "assets/img/roundgirl.png",
                                  isBuyGiftPage: true,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                GiftCol(
                                  subtype: 0,
                                  img: "assets/img/sticker1.png",
                                  price: 40,
                                  rimg: "assets/img/roundgirl.png",
                                  isBuyGiftPage: true,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GiftCol(
                                  subtype: 0,
                                  img: "assets/img/sticker2.png",
                                  price: 40,
                                  rimg: "assets/img/roundgirl.png",
                                  isBuyGiftPage: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xff5c5c5c),
                                  width: 1,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xff5c5c5c),
                                  width: 1,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xff5c5c5c),
                                  width: 1,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xff5c5c5c),
                                  width: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
          SizedBox(
            height: 27,
          ),
          Text(
            "Category 2",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w900,
              letterSpacing: 0.90,
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            "Choose a gift from the list",
            style: TextStyle(
              color: Color(0xffc4c4c4),
              fontSize: 13,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(17),
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, 'G2');
          },
          child: Container(
            height: size.height / 13,
            width: size.width / 1.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Color(0xfff5f5f5),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Pay 25 Coins",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.75,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

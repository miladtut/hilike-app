import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Models/app.dart';
import 'package:hilike/Pages/MainPages/MainMenu.dart';
import 'package:hilike/generated/l10n.dart';

class FirstTimeDialog extends StatefulWidget {
  const FirstTimeDialog({
    Key? key,
  }) : super(key: key);

  @override
  _FirstTimeDialogState createState() => _FirstTimeDialogState();
}

class _FirstTimeDialogState extends State<FirstTimeDialog> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 45),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Color(0xe5292929),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color(0xffe5003a),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              // height: size.height / 5,
              padding: EdgeInsets.all(size.height / 70),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          S.of(context).rule1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "Tahoma",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          S.of(context).rule2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                    Image.asset(
                      "assets/img/image 210.png",
                      // scale: 1,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
              height: 1,
              color: Colors.transparent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/img/image 211.png",
                  // scale: 1,
                ),
                Column(
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Color(0xffe5003a),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Color(0xff292929),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "1",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      S.of(context).rule3,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: "Tahoma",
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 1,
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Color(0xffe5003a),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Color(0xff292929),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "2",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      S.of(context).rule4,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: "Tahoma",
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Image.asset(
                  "assets/img/image 212.png",
                  // scale: 1,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 1,
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/img/image 213.png",
                  // scale: 1,
                ),
                Column(
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Color(0xffe5003a),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Color(0xff292929),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "3",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      S.of(context).rule5,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: "Tahoma",
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  App.materialKey!.currentContext!,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Mainmenu()),
                  ModalRoute.withName('/'),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                height: size.height / 13,
                width: size.width / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xffe5003a),
                ),
                child: Center(
                  child: Text(
                    S.of(context).accept,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: "Tahoma",
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.75,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

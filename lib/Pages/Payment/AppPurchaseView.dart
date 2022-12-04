import 'package:flutter/material.dart';
import 'package:hilike/Widget/Appbar60.dart';
import 'package:hilike/generated/l10n.dart';

import 'AppPurchase.dart';

class AppleView extends StatefulWidget {
  String type;
  AppleView({required this.type});
  @override
  _AppleViewState createState() => _AppleViewState();
}

class _AppleViewState extends State<AppleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Color(0xff292929),
          title: Text(
            S.of(context).payNow,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w900,
              letterSpacing: 1.10,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
            child: AppPurchase(
          type: widget.type,
        )));
  }
}

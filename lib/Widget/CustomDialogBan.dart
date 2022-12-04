import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hilike/generated/l10n.dart';

class CustomDialogBan extends StatefulWidget {
  final String text, text2;

  const CustomDialogBan({
    Key? key,
    required this.text,
    required this.text2,
  }) : super(key: key);

  @override
  _CustomDialogBanState createState() => _CustomDialogBanState();
}

class _CustomDialogBanState extends State<CustomDialogBan> {
  static const double padding = 16;
  static const double avatarRadius = 30;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // height: size.height / 4,
      width: size.width / 1,
      // margin: EdgeInsets.only(top: avatarRadius),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color(0xff292929),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            S.of(context).notic,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w900,
              letterSpacing: 0.90,
            ),
          ),
          SizedBox(
            height: size.height / 60,
          ),
          Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffc4c4c4),
              fontSize: 13,
            ),
          ),
          SizedBox(
            height: size.height / 30,
          ),
          Visibility(
            visible: widget.text2.length > 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time_sharp,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: size.width / 25,
                ),
                Text(
                  widget.text2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

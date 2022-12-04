import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Pages/userpages/EditProfile.dart';
import 'package:hilike/Pages/userpages/UserSeeAll.dart';
import 'package:nb_utils/src/extensions/widget_extensions.dart';

import '../extensions.dart';

class CustomDialogButton extends StatefulWidget {
  final String title, text, text2;

  const CustomDialogButton({
    Key? key,
    required this.title,
    required this.text,
    required this.text2,
  }) : super(key: key);

  @override
  _CustomDialogButtonState createState() => _CustomDialogButtonState();
}

class _CustomDialogButtonState extends State<CustomDialogButton> {
  static const double padding = 16;
  static const double avatarRadius = 30;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: size.width / 18,
      ),
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
      height: size.height / 4,
      width: size.width / 1,
      // margin: EdgeInsets.symmetric(horizontal: 1),

      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color(0xff292929),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.90,
                  ),
                ),
                Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xffc4c4c4),
                    fontSize: 15,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    EditProfile().launch(context);
                  },
                  child: Container(
                    width: size.width / 1.7,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.white,
                        width: 0.50,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.text2,
                        style: TextStyle(
                          color: Color(0xffc4c4c4),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Localizations.localeOf(context).languageCode.toString() != "ar"
              ? Positioned(
                  left: 0,
                  top: 0,
                  child: IconButton(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(
                          color: Color(0xffc4c4c4),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 16,
                        color: Color(0xffc4c4c4),
                      ),
                    ),
                  ),
                )
              : Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(
                          color: Color(0xffc4c4c4),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 16,
                        color: Color(0xffc4c4c4),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

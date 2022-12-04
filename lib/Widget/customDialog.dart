import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogg extends StatefulWidget {
  final String title, positiveButtonText, negativeButtonText;
  final Function? onPositiveClick, onNegativeClick;

  const CustomDialogg({
    Key? key,
    required this.title,
    required this.positiveButtonText,
    required this.negativeButtonText,
    this.onPositiveClick,
    this.onNegativeClick,
  }) : super(key: key);

  @override
  _CustomDialoggState createState() => _CustomDialoggState();
}

class _CustomDialoggState extends State<CustomDialogg> {
  static const double padding = 16;
  static const double avatarRadius = 30;

  @override
  Widget build(BuildContext context) {
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
      width: size.width / 1,
      padding: EdgeInsets.only(
        left: padding,
        top: padding + 8,
        right: padding,
        bottom: padding + 8,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color(0xff292929),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (widget.onNegativeClick != null)
                      widget.onNegativeClick!();
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white,
                        width: 0.50,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.negativeButtonText,
                        style: TextStyle(
                          color: Color(0xffc4c4c4),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (widget.onPositiveClick != null)
                      widget.onPositiveClick!();
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white,
                        width: 0.50,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.positiveButtonText,
                        style: TextStyle(
                          color: Color(0xffc4c4c4),
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hilike/generated/l10n.dart';

class PointRow extends StatefulWidget {
  const PointRow({
    Key? key,
    required this.color1,
    required this.color2,
    required this.line1color,
    required this.line2color,
    required this.line3color,
  }) : super(key: key);

  final Color color1, color2, line1color, line2color, line3color;

  @override
  _PointRowState createState() => _PointRowState();
}

class _PointRowState extends State<PointRow> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width / 1,
      height: size.height / 13,
      color: Color(0x4c292929),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color1,
                    border: Border.all(width: 5, color: Colors.white)),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 45,
                height: 1,
                color: widget.line1color,
              ),
              Container(
                width: 45,
                height: 1,
                color: widget.line2color,
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color2,
                    border: Border.all(width: 5, color: Colors.white)),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 45,
                height: 1,
                color: widget.line3color,
              ),
              Container(
                width: 45,
                height: 1,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffe5003a),
                    border: Border.all(width: 5, color: Colors.white)),
              ),
            ],
          ),
          SizedBox(
            height: size.height / 150,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).generalInfo,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  letterSpacing: 0.50,
                ),
              ),
              SizedBox(
                width: size.width / 6.5,
              ),
              Text(
                S.of(context).personalInfo +
                    "      ", //  "Personal info      ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  letterSpacing: 0.50,
                ),
              ),
              SizedBox(
                width: size.width / 9,
              ),
              Text(
                S.of(context).nickname, // "Nickname",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  letterSpacing: 0.50,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

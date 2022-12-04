import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyBox extends StatefulWidget {
  final String descriptions, img;

  const EmptyBox({
    Key? key,
    required this.descriptions,
    required this.img,
  }) : super(key: key);

  @override
  _EmptyBoxState createState() => _EmptyBoxState();
}

class _EmptyBoxState extends State<EmptyBox> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Stack(alignment: AlignmentDirectional.topEnd, children: [
        Container(
          width: size.width / 1,
          height: size.height / 4,
          margin: EdgeInsets.only(top: size.height / 36),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xff292929),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  widget.img,
                  scale: 1,
                ),
              ),
              SizedBox(
                height: 23,
              ),
              Text(
                widget.descriptions,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xfff5f5f5),
                  fontSize: 13,
                ),
              )
            ],
          ),
        ),
        // Padding(
        //   padding:
        //       Localizations.localeOf(context).languageCode.toString() == "ar"
        //           ? EdgeInsets.fromLTRB(10, 0, 0, 0)
        //           : EdgeInsets.fromLTRB(0, 0, 10, 0),
        //   child: Container(
        //     width: size.width / 2.6,
        //     height: size.height / 18,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(8),
        //       color: Color(0xffe5003a),
        //     ),
        //     child: Center(
        //       child: Text(
        //         "Something is wrong",
        //         textAlign: TextAlign.center,
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontSize: 13,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ]),
    );
  }
}

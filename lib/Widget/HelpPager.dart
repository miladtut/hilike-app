import 'package:flutter/material.dart';

import '../Utils/constants.dart';

class HelpPager extends StatefulWidget {
  const HelpPager({
    Key? key,
    required this.image,
    required this.text,
    required this.title,
    required this.pager,
  }) : super(key: key);
  final String? image, text, title;
  final int pager;

  @override
  _HelpPagerState createState() => _HelpPagerState();
}

class _HelpPagerState extends State<HelpPager> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: size.height / 35,
        ),
        Container(
            height: size.height / 2,
            width: size.width / 1.1,
            child: Image.asset(
              widget.image ?? imgPlaceholder,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.network(
                  imgPlaceholder,
                );
              },
            )),
        Text(
          widget.text ?? "",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w900,
            letterSpacing: 1.10,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.title ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xfff5f5f5),
              fontSize: 13,
              letterSpacing: 0.65,
            ),
          ),
        ),
        SizedBox(
          height: 0.1,
        ),
      ],
    );
  }
}

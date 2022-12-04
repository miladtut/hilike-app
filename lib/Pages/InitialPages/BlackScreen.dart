import 'dart:async';

import 'package:flutter/material.dart';

class BlackScreen extends StatefulWidget {
  @override
  _BlackScreenState createState() => _BlackScreenState();
}

class _BlackScreenState extends State<BlackScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1),
        () => Navigator.pushReplacementNamed(context, "gender"));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        // width: size.width / 3.5,
        // height: size.height / 3.5,

        );
  }
}

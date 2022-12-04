import 'package:flutter/material.dart';

class Loadoingw extends StatefulWidget {
  @override
  _LoadoingwState createState() => _LoadoingwState();
}

class _LoadoingwState extends State<Loadoingw>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 40),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        // color: Colors.transparent,
        // height: 50,
        // width: 50,
        // child: Center(
        //   child: RotationTransition(
        //     turns: Tween(begin: 0.0, end: 15.0).animate(_controller),
        //     child: Image.asset(
        //       "assets/icon/icon.png",
        //       scale: 20,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}

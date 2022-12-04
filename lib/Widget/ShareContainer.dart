import 'package:flutter/material.dart';

class ShareContainer extends StatefulWidget {
  const ShareContainer({
    required this.img,
    Key? key,
  }) : super(key: key);
  final String img;
  @override
  _ShareContainerState createState() => _ShareContainerState();
}

class _ShareContainerState extends State<ShareContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ///
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Color(0xff212121),
        ),
        child: Image.asset(
          widget.img,
          scale: 80,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SupportButton extends StatefulWidget {
  const SupportButton({
    Key? key,
    required this.number,
    required this.text,
    required this.clicknum,
  }) : super(key: key);
  final String text;
  final int number, clicknum;
  @override
  _SupportButtonState createState() => _SupportButtonState();
}

class _SupportButtonState extends State<SupportButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 86,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 29,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: widget.number == widget.clicknum
              ? Color(0xffe5003a)
              : Colors.white,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.number == widget.clicknum
                ? Color(0xffe5003a)
                : Colors.white,
            fontSize: 12,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ContainerText extends StatefulWidget {
  const ContainerText({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  final String title, text;

  @override
  _ContainerTextState createState() => _ContainerTextState();
}

class _ContainerTextState extends State<ContainerText> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
      child: Container(
        width: size.width / 1.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xff292929),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                height: 10,
              ),
              Text(
                widget.text,
                style: TextStyle(
                  color: Color(0xffc4c4c4),
                  fontSize: 13,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

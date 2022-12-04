import 'package:flutter/material.dart';
import 'package:hilike/Models/app.dart';

class Appbar60 extends StatefulWidget {
  final String title;
  const Appbar60({
    required this.title,
    Key? key,
  }) : super(key: key);
  @override
  State<Appbar60> createState() => _Appbar60State();
}

class _Appbar60State extends State<Appbar60> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Localizations.localeOf(context).languageCode.toString() == "ar"
              ? Icons.arrow_back_ios
              : Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 16,
        ),
      ),
      centerTitle: true,
      title: Text(
        widget.title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w900,
          letterSpacing: 1.10,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: Color(0xff292929),
    );
  }
}

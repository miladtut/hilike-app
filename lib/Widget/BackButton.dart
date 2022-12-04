import 'package:flutter/material.dart';

class BackButtoncon extends StatefulWidget {
  const BackButtoncon({
    required this.towelcome,
    required this.register,
    Key? key,
  }) : super(key: key);
  final bool towelcome, register;

  @override
  _BackButtonconState createState() => _BackButtonconState();
}

class _BackButtonconState extends State<BackButtoncon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.towelcome
            ? Navigator.pushReplacementNamed(context, 'welcome')
            : Navigator.pop(context);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: widget.register ? Color(0xcc292929) : Color(0xff292929),
        ),
        child: Center(
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white,
            textDirection:
                Localizations.localeOf(context).languageCode.toString() == "ar"
                    ? TextDirection.ltr
                    : TextDirection.rtl,
            size: 20,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hilike/generated/l10n.dart';

class UserInfoBox extends StatefulWidget {
  final String title;
  final bool? vis, isList;
  final List? langList;

  const UserInfoBox(
      {Key? key, this.title = "", this.vis, this.isList, this.langList})
      : super(key: key);

  @override
  _UserInfoBoxState createState() => _UserInfoBoxState();
}

class _UserInfoBoxState extends State<UserInfoBox> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.title.contains("null") ? false : true,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xff212121),
                blurRadius: 2,
                offset: Offset(1, 5),
              ),
            ],
            color: Color(0xff212121),
            borderRadius: BorderRadius.circular(10),
          ),
          child: widget.isList ?? false
              ? Wrap(
                  runSpacing: 5,
                  children: [
                    Text(
                      S.of(context).language + ": ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xfff5f5f5),
                        fontSize: 13,
                      ),
                    ),
                    for (int i = 0; i < widget.langList!.length; i++)
                      widget.langList!.length > 1
                          ? Text(
                              widget.langList![i]["name"] + " , ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xfff5f5f5),
                                fontSize: 13,
                              ),
                            )
                          : Text(
                              widget.langList![i]["name"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xfff5f5f5),
                                fontSize: 13,
                              ),
                            )
                  ],
                )
              : Text(widget.title,
                  style: TextStyle(
                    color: Color(0xfff5f5f5),
                    fontSize: 12,
                    letterSpacing: 0.60,
                  ))),
    );
  }
}

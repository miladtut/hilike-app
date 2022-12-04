import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

class ProfileInfoItem extends StatefulWidget {
  final int index;
  final String title;
  final bool? vis;

  const ProfileInfoItem({Key? key, this.index = 0, this.title = "", this.vis})
      : super(key: key);

  @override
  _ProfileInfoItemState createState() => _ProfileInfoItemState();
}

class _ProfileInfoItemState extends State<ProfileInfoItem> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.vis ?? true,
      child: SizedBox(
        height: 35,
        child: ItemTags(
          key: Key(widget.index.toString()),
          index: widget.index,
          active: false,
          singleItem: true,
          color: Color(0xff212121),
          textColor: Color(0xfff5f5f5),
          title: widget.title,
          textStyle: TextStyle(
            color: Color(0xfff5f5f5),
            fontSize: 12,
            letterSpacing: 0.60,
          ),
          activeColor: Color(0xff212121),
          combine: ItemTagsCombine.onlyText,
          onPressed: (item) => print(item),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          borderRadius: BorderRadius.circular(10),
          onLongPressed: (item) => print(item),
        ),
      ),
    );
  }
}

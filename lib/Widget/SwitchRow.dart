import 'package:flutter/material.dart';
import 'package:hilike/Networking/Mobx/search_mobx.dart';

class SwitchRow extends StatefulWidget {
  final String title, text;
  final Function(bool)? onChange;
  final bool value;

  const SwitchRow(
      {Key? key,
      required this.text,
      required this.title,
      this.onChange,
      this.value = false})
      : super(key: key);

  @override
  _SwitchRowState createState() => _SwitchRowState();
}

class _SwitchRowState extends State<SwitchRow> {
  void toggleSwitch(bool value) {
    if (widget.onChange != null) widget.onChange!(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Transform.scale(
              scale: 1,
              child: Switch(
                  onChanged: toggleSwitch,
                  value: widget.value,
                  activeColor: Color(0xffe5003a),
                  activeTrackColor: Colors.white,
                  inactiveThumbColor: Color(0xffc4c4c4),
                  inactiveTrackColor: Colors.white),
            ),
          ],
        ),
        Text(
          widget.text,
          style: TextStyle(
            color: Color(0xffC4C4C4),
            fontSize: 13,
            letterSpacing: 0.65,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class RangerRow extends StatefulWidget {
  final String para, title;
  final bool iswhite;
  final SfRangeValues values;
  final Function(SfRangeValues) onChange;

  const RangerRow(
      {Key? key,
      required this.para,
      required this.iswhite,
      required this.title,
      required this.values,
      required this.onChange})
      : super(key: key);

  @override
  _RangerRowState createState() => _RangerRowState();
}

class _RangerRowState extends State<RangerRow> {
  double min = 0.0, max = 1.0;

  @override
  void initState() {
    super.initState();
    min = widget.values.start;
    max = widget.values.end;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w700,
            letterSpacing: 0.75,
          ),
        ),
        SizedBox(
          height: size.height / 80,
        ),
        Container(
          // height: 20,
          child: Stack(
            children: <Widget>[
              Row(children: <Widget>[
                Expanded(
                    flex: widget.iswhite
                        ? widget.values.start.round() - 18
                        : widget.values.start.round(),
                    child: SizedBox()),
                Container(
                  width: widget.iswhite ? 70 : 50,
                  child: Text(
                    "${widget.values.start.round().toString()} ${widget.para}",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      // letterSpacing: 1,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                    flex: (max.toInt() - widget.values.start.round()).toInt(),
                    child: SizedBox()),
              ]),
              Row(children: <Widget>[
                Expanded(
                    flex: widget.iswhite
                        ? widget.values.end.round() - 18
                        : widget.values.end.round(),
                    child: SizedBox()),
                Container(
                  width: widget.values.end.round() == max.toInt() ? 50 : 70,
                  child: Text(
                    widget.values.end.round() == max.toInt()
                        ? S.of(context).seeAll
                        : "${widget.values.end.round().toString()} ${widget.para}",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                    flex: (max.toInt() - widget.values.end.round()).toInt(),
                    child: SizedBox()),
              ])
            ],
          ),
        ),
        Stack(children: [
          Positioned(
            height: 47.7,
            left: 13.82,
            child: Container(
              width: 19,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffc4c4c4),
              ),
            ),
          ),
          Positioned(
            height: 47.7,
            right: 14,
            child: Container(
              width: 19,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffc4c4c4),
              ),
            ),
          ),
          SfRangeSlider(
            activeColor: Color(0xffe5003a),
            inactiveColor: Color(0xffc4c4c4),
            min: min,
            max: max,
            values: widget.values,
            onChanged: (SfRangeValues values) {
              widget.onChange(values);
            },
          ),
        ]),
        SizedBox(
          height: size.height / 40,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hilike/generated/l10n.dart';

class PaymentRow extends StatefulWidget {
  PaymentRow(
      {Key? key,
      required this.text,
      required this.img,
      required this.wid,
      required this.first,
      this.funcation,
      required this.durtaion})
      : super(key: key);
  final String img, text;
  final Widget wid;
  final String durtaion;
  final bool first;
  var funcation;
  @override
  _PaymentRowState createState() => _PaymentRowState();
}

class _PaymentRowState extends State<PaymentRow> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                widget.funcation();
              },
              child: Container(
                width: size.width / 1,
                height: size.height / 11,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff292929),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              width: 45,
                              height: 25,
                              child: Image.asset(
                                widget.img,
                              )),
                          SizedBox(
                            width: 12,
                          ),
                          widget.first
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.text,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.5,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.60,
                                      ),
                                    ),
                                    Container(
                                        width: 150,
                                        height: 18,
                                        child: Image.asset(
                                            "assets/img/paycards.png")),
                                  ],
                                )
                              : Text(
                                  widget.text,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.60,
                                  ),
                                ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            widget.durtaion == "null"
                                ? ""
                                : widget.durtaion == "1"
                                    ? "${widget.durtaion}  ${S.of(context).month}"
                                    : "${widget.durtaion}  ${S.of(context).months}",
                            style: TextStyle(
                              color: Color(0xffc4c4c4),
                              fontSize: 13,
                            ),
                          ),
                          widget.wid,
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height / 100,
            ),
          ],
        ));
  }
}

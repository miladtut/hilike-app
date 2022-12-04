import 'package:flutter/material.dart';
import 'package:hilike/Models/gift.dart';
import 'package:hilike/Utils/constants.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class Gift extends StatefulWidget {
  final bool clicked;
  final GiftModel gift;
  final Function(GiftModel gift)? onClick;

  const Gift({
    Key? key,
    this.clicked = false,
    required this.gift,
    this.onClick,
  }) : super(key: key);

  @override
  _GiftState createState() => _GiftState();
}

class _GiftState extends State<Gift> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (widget.onClick != null) widget.onClick!(widget.gift);
      },
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.clicked
                                ? Color(0xffffb950)
                                : Color(0xfff5f5f5),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    if (!widget.clicked)
                      Center(
                        child: Image.network(
                          widget.gift.image ?? imgPlaceholder,
                          width:
                              widget.clicked ? size.width / 7 : size.width / 8,
                          height:
                              widget.clicked ? size.width / 7 : size.width / 8,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              widget.clicked
                  ? Container(
                      height: 20,
                      // padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.clicked
                              ? Color(0xffffb950)
                              : Color(0xfff5f5f5),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).send,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Roboto',
                              color: Color(0xffffb950),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          (widget.gift.price ?? 0).toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 4),
                        Image.asset("assets/img/gold.png",
                            width: 12, height: 12),
                      ],
                    ),
            ],
          ).paddingAll(5),
          if (widget.clicked)
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    widget.gift.image ?? imgPlaceholder,
                    width: widget.clicked ? size.width / 7 : size.width / 8,
                    height: widget.clicked ? size.width / 7.5 : size.width / 8.5,
                  ),
                  if (widget.clicked)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          (widget.gift.price ?? 0).toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 4),
                        Image.asset("assets/img/gold.png",
                            width: 12, height: 12),
                      ],
                    ),
                  if (widget.clicked) SizedBox(height: 10),
                ],
              ),
            ).paddingBottom(24),
        ],
      ),
    );
  }
}

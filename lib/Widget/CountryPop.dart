import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Networking/Mobx/signup_mobx.dart';
import 'package:hilike/generated/l10n.dart';

import '../extensions.dart';

class CountryPop extends StatefulWidget {
  final String type;
  final withTitle;
  final SignupMobx signupMobx;
  final Function(SignupMobx signupMobx)? onSelect;
  final Function? iconPressed;

  const CountryPop({
    Key? key,
    required this.withTitle,
    required this.type,
    this.iconPressed,
    required this.signupMobx,
    this.onSelect,
  }) : super(key: key);

  @override
  _CountryPopState createState() => _CountryPopState();
}

class _CountryPopState extends State<CountryPop> {
  late SignupMobx signupMobx;

  @override
  void initState() {
    signupMobx = widget.signupMobx;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Observer(
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.withTitle
              ? Text(
                  widget.type == S.of(context).origin
                      ? S.of(context).originCountry
                      : S.of(context).residenceCountry,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.75,
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: size.height / 50,
          ),
          GestureDetector(
            onTap: () {
              pickCountry(
                context,
                type: widget.type,
                signupMobx: signupMobx,
                onSelect: (mobx) {
                  if (widget.onSelect != null) widget.onSelect!(mobx);
                },
              );
            },
            child: Container(
              width: size.width / 1,
              height: size.height / 13.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xcc292929),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (widget.type == S.of(context).origin &&
                              signupMobx.originSearchQuery.isEmpty) ||
                          (widget.type != S.of(context).origin &&
                              signupMobx.residenceSearchQuery.isEmpty)
                      ? widget.withTitle
                          ? Text(
                              "      ${S.of(context).selectYourCountry}",
                              style: TextStyle(
                                color: Color(0xffc4c4c4),
                                fontSize: 13,
                                letterSpacing: 0.65,
                              ),
                            )
                          : Text(
                              "      ${widget.type == S.of(context).origin ? S.of(context).originCountry : S.of(context).residenceCountry}",
                              style: TextStyle(
                                color: Color(0xffc4c4c4),
                                fontSize: 13,
                                letterSpacing: 0.65,
                              ),
                            )
                      : Text(
                          "      ${widget.type == S.of(context).origin ? (signupMobx.originCountry == null ? S.of(context).selectYourCountry : signupMobx.originCountry!.name ?? "") : (signupMobx.residenceCountry == null ? S.of(context).selectYourCountry : signupMobx.residenceCountry!.name ?? "")}",
                          style: TextStyle(
                            color: Color(0xffc4c4c4),
                            fontSize: 13,
                            letterSpacing: 0.65,
                          ),
                        ),
                  widget.type == S.of(context).origin
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                              onTap: () {
                                widget.iconPressed == null
                                    ? print("object")
                                    : widget.iconPressed!();
                              },
                              child: Icon(
                                signupMobx.originCountry == null ||
                                        widget.iconPressed == null
                                    ? Icons.keyboard_arrow_down_sharp
                                    : Icons.dangerous_sharp,
                                color: Color(0xffc4c4c4),
                                size: 30,
                              )),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                              onTap: () {
                                widget.iconPressed == null
                                    ? print("object")
                                    : widget.iconPressed!();
                              },
                              child: Icon(
                                signupMobx.residenceCountry == null ||
                                        widget.iconPressed == null
                                    ? Icons.keyboard_arrow_down_sharp
                                    : Icons.dangerous_sharp,
                                color: Color(0xffc4c4c4),
                                size: 30,
                              )),
                        )
                ],
              ),
            ),
          ),
          SizedBox(height: widget.withTitle ? size.height / 50 : 0.01),
        ],
      ),
    );
  }
}

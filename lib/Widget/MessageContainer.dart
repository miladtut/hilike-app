import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Networking/Mobx/user_mobx.dart';
import 'package:hilike/generated/l10n.dart';

class MessageContainer extends StatefulWidget {
  const MessageContainer(
      {Key? key,
      required this.img,
      required this.name,
      required this.subtype,
      required this.noti,
      this.age,
      this.country,
      required this.lastseen,
      required this.count,
      required this.online,
      required this.text,
      this.location})
      : super(key: key);

  final String? img, name, country, text, location, lastseen;
  final num? subtype, age, noti;
  // vip = 2 , gold =1
  final num? online, count;

  @override
  _MessageContainerState createState() => _MessageContainerState();
}

class _MessageContainerState extends State<MessageContainer> {
  UserMobx userMobx = UserController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(0),
          width: size.width / 1,
          // height: size.height / 6.8,
          padding: widget.subtype == 3
              ? EdgeInsets.symmetric(vertical: 10)
              : EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: widget.subtype == 2
                  ? Color(0xffe5003a)
                  : widget.subtype == 3
                      ? Colors.white
                      : Color(0xff292929),
              width: 1,
            ),
            boxShadow: [
              widget.subtype == 2
                  ? BoxShadow(
                      color: Color(0xfff01536),
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    )
                  : widget.subtype == 3
                      ? BoxShadow(
                          color: Colors.white,
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        )
                      : BoxShadow(
                          color: Color(0xff292929),
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        )
            ],
            color: Color(0xff292929),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(alignment: Alignment.centerRight, children: [
                      Container(
                        width: 47,
                        height: 50,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        decoration: widget.subtype == 3
                            ? BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/img/logo.png"),
                                  fit: BoxFit.fitHeight,
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xff292929),
                                  width: 1,
                                ),
                                color: Color(0xff292929),
                              )
                            : BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(widget.img!),
                                  fit: BoxFit.fitHeight,
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: widget.subtype == 2
                                      ? Color(0xffe5003a)
                                      : widget.subtype == 1
                                          ? Color(0xffffb84f)
                                          : Color(0xff292929),
                                  width: 1,
                                ),
                                color: Color(0xffc4c4c4),
                              ),
                      ),
                      // profileMobx.user!.online ?? false
                      //                 ?

                      widget.subtype == 3 && widget.count! > 0
                          ? Positioned(
                              right: 7,
                              top: 35,
                              // bottom: size.height / 17,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xff292929),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.count.toString(),
                                    style: TextStyle(
                                      color: Color(0xffe5003a),
                                      fontSize: 7,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),

                      widget.subtype != 3 &&
                              widget.count.toString() != "0" &&
                              widget.noti == 1
                          ? Positioned(
                              right: 7,
                              top: 35,
                              // bottom: size.height / 17,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: Color(0xffe5003a),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xff292929),
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.count.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 7,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      widget.online == 1
                          ? Positioned(
                              right: 7,
                              bottom: 38,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Color(0xff3BC148),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xff292929),
                                    width: 1,
                                  ),
                                ),
                              ),
                            )
                          : Container()

                      // : Container(),
                    ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: widget.subtype == 3 ? 9 : 10),
                              width: widget.subtype == 3 ? 48 : 115,
                              child: Text(
                                "${widget.name}   ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.75,
                                ),
                              ),
                            ),
                            widget.subtype == 3
                                ? Image.asset("assets/img/offical.png")
                                : SizedBox(),
                            widget.subtype == 2
                                ? Container(
                                    width: 36.92,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                        color: Color(0xffe5003a),
                                        width: 1,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Vip",
                                        style: TextStyle(
                                          color: Color(0xffe5003a),
                                          fontSize: 9,
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )
                                : widget.subtype == 1
                                    ? Container(
                                        width: 36.92,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          border: Border.all(
                                            color: Color(0xffffb84f),
                                            width: 1,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Gold",
                                            style: TextStyle(
                                              color: Color(0xffffb84f),
                                              fontSize: 9,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      )
                                    : widget.subtype == 3
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.width / 14.8),
                                            child: Container(
                                              width: 36.92,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Official",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 9,
                                                    fontFamily: "Roboto",
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : widget.subtype == 0
                                            ? Container(
                                                width: 20,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  border: Border.all(
                                                    color: Color(0xff292929),
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "",
                                                    style: TextStyle(
                                                      color: Color(0xffffb84f),
                                                      fontSize: 9,
                                                      fontFamily: "Roboto",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(
                                                width: 0.01,
                                              ),
                            Row(
                              children: [
                                SizedBox(
                                  width: widget.subtype == 3
                                      ? size.width / 25
                                      : 15,
                                ),
                                Text(
                                  "${widget.lastseen}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              width: size.width / 1.8,
                              child: Text(
                                widget.text!.contains("http")
                                    ? S.of(context).aUserSentYouGift
                                    : widget.text!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  letterSpacing: 0.60,
                                ),
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              widget.subtype == 3
                  ? Container()
                  : Container(
                      width: size.width / 1.2,
                      height: 0.50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 0.50,
                        ),
                      ),
                    ),
              widget.subtype == 3
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "    ${widget.country}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.5,
                            ),
                          ),
                          Text(
                            Localizations.localeOf(context)
                                        .languageCode
                                        .toString() ==
                                    "ar"
                                ? "    ${widget.location}  كم"
                                : "    ${widget.location}  km",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.5,
                            ),
                          ),
                          Text(
                            Localizations.localeOf(context)
                                        .languageCode
                                        .toString() ==
                                    "ar"
                                ? "    ${widget.age}  سنة"
                                : "    ${widget.age}  years",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        SizedBox(
          height: size.height / 50,
        ),
      ],
    );
  }
}

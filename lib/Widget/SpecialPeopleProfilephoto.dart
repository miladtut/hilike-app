import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Networking/Mobx/user_mobx.dart';
import 'package:hilike/Pages/userpages/pressuser.dart';
import 'package:hilike/Utils/constants.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

import 'customDialog.dart';

class SpecialPeopleProfilephoto extends StatefulWidget {
  final String name, subtype, country;
  final String? img;
  final String distnce;
  final bool isMale;
  final int? userId, age;
  final Function(bool isBlocked) onBackFromPressUser;
  final bool isBlocked;
  final bool? isonline;
  final bool? iscurs, isnew, withPhoto;

  const SpecialPeopleProfilephoto({
    Key? key,
    required this.img,
    this.isonline,
    this.iscurs,
    this.withPhoto,
    this.isnew,
    required this.name,
    required this.distnce,
    required this.country,
    required this.age,
    required this.subtype,
    required this.isMale,
    required this.userId,
    required this.onBackFromPressUser,
    this.isBlocked = false,
  }) : super(key: key);

  @override
  _SpecialPeopleProfilephotoState createState() =>
      _SpecialPeopleProfilephotoState();
}

class _SpecialPeopleProfilephotoState extends State<SpecialPeopleProfilephoto> {
  bool ispressed = false;
  UserMobx userMobx = UserController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () async {
        if (widget.isBlocked) {
          userMobx.userId = widget.userId;
          showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return CustomDialogg(
                title:
                    S.of(context).doYouWantToUnblock + " " + widget.name + " ?",
                negativeButtonText: S.of(context).no,
                positiveButtonText: S.of(context).yes,
                onNegativeClick: () {
                  Navigator.pop(context);
                },
                onPositiveClick: () async {
                  Navigator.pop(context);
                  bool success = await userMobx.removeBlock(context);
                  if (success) widget.onBackFromPressUser(true);
                },
              );
            },
          );
        } else {
          Pressuser(
            userId: widget.userId ?? 0,
            onFinish: (bool isBlocked) {
              widget.onBackFromPressUser(isBlocked);
            },
          ).launch(context);
        }
      },
      child: widget.withPhoto ?? false
          ? Stack(alignment: AlignmentDirectional.bottomCenter, children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff292929),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                width: widget.isnew ?? false
                    ? size.width / 2.15 - 30
                    : size.width / 2.15 - 12,
                height: widget.isnew ?? false
                    ? (size.width / 2 - 25) * 4 / 1
                    : (size.width / 2 - 25) * 4 / 1,
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: CachedNetworkImage(
                    alignment: Alignment.topCenter,
                    imageUrl: widget.img ??
                        (widget.isMale
                            ? imgMalePlaceholder
                            : imgFemalePlaceholder),
                    imageBuilder: (context, imageProvider) => Container(
                      width: widget.isnew ?? false
                          ? size.width / 2 - 65
                          : size.width / 2 - 55,
                      height: widget.isnew ?? false
                          ? (size.width / 2 - 75) * 4 / 3
                          : (size.width / 2 - 65) * 4 / 3,
                      // margin: EdgeInsets.fromLTRB(5, 0, 5, 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          // alignment: Alignment.topCenter,
                          image: imageProvider,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              color: Color(0xffe5003a),
                              strokeWidth: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: size.width / 2.15 - 25,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                              ),
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "${widget.age}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                            maxLines: 2,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          widget.subtype == "Gold"
                              ? Container(
                                  width: 30,
                                  height: 13,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
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
                                        fontSize: 7,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              : widget.subtype == "Vip"
                                  ? Container(
                                      width: 30,
                                      height: 13,
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
                                            fontSize: 7,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      width: 0.1,
                                    ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.country,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                            ),
                            maxLines: 2,
                          ),
                          if (!widget.country.isEmptyOrNull)
                            SizedBox(
                              width: 10,
                            ),
                          Visibility(
                            visible: widget.distnce == "" ? false : true,
                            child: Text(
                              Localizations.localeOf(context)
                                          .languageCode
                                          .toString() ==
                                      "ar"
                                  ? widget.distnce + " ????"
                                  : widget.distnce + " km",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                ),
              ),
              widget.isonline ?? false
                  ? Positioned(
                      right: 20,
                      // bottom: size.width / 6.5,
                      top: widget.iscurs == true ? 40 : 10,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Color(0xff3BC148),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ])
          : Stack(alignment: AlignmentDirectional.bottomCenter, children: [
              Container(
                width: widget.isnew ?? false
                    ? size.width / 2.15 - 30
                    : size.width / 2.15 - 12,
                height: widget.isnew ?? false
                    ? (size.width / 2 - 25) * 4 / 1
                    : (size.width / 2 - 25) * 4 / 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.img ??
                        (widget.isMale
                            ? imgMalePlaceholder
                            : imgFemalePlaceholder),
                    imageBuilder: (context, imageProvider) => Container(
                      width: size.width / 2 - 25,
                      height: (size.width / 2 - 25) * 4 / 3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              color: Color(0xffe5003a),
                              strokeWidth: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: size.width / 2.15 - 10,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3f000000),
                      blurRadius: 30,
                      offset: Offset(0, 0),
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x00929292), Colors.black54],
                  ),
                ),
              ),
              Container(
                width: size.width / 2.15 - 25,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1,
                              ),
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "${widget.age}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                            maxLines: 2,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          widget.subtype == "Gold"
                              ? Container(
                                  width: 30,
                                  height: 13,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
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
                                        fontSize: 7,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              : widget.subtype == "Vip"
                                  ? Container(
                                      width: 30,
                                      height: 13,
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
                                            fontSize: 7,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      width: 0.1,
                                    ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.country,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                            ),
                            maxLines: 2,
                          ),
                          if (!widget.country.isEmptyOrNull)
                            SizedBox(
                              width: 10,
                            ),
                          Visibility(
                            visible: widget.distnce == "" ? false : true,
                            child: Text(
                              Localizations.localeOf(context)
                                          .languageCode
                                          .toString() ==
                                      "ar"
                                  ? widget.distnce + " ????"
                                  : widget.distnce + " km",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                ),
              ),
              widget.isonline ?? false
                  ? Positioned(
                      right: 15,
                      // bottom: size.width / 6.5,
                      top: widget.iscurs == true ? 40 : 10,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Color(0xff3BC148),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ]),
    );
  }
}

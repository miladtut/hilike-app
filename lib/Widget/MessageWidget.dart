import 'package:flutter/material.dart';
import 'package:hilike/Models/app.dart';
import 'package:hilike/Models/message.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Utils/constants.dart';
import 'package:hilike/Utils/time_ago.dart';
import 'package:hilike/Widget/UserAvatar.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final bool isMe, isgift;
  final String locale, secondimg;
  final String? secondplan, mePlan;
  final bool visable;
  final String? lastdate, date;

  const MessageWidget({
    required this.message,
    this.secondplan,
    this.date,
    this.mePlan,
    this.lastdate,
    required this.isMe,
    required this.secondimg,
    required this.visable,
    required this.isgift,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(16);
    final borderRadius = BorderRadius.all(radius);
    return Column(
      children: [
        Visibility(
          visible:
              lastdate == "true" ? true : (lastdate == date ? false : true),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              DateFormat('dd MMMM yyyy').format(message.createdAt) ==
                      DateFormat('dd MMMM yyyy').format(DateTime.now())
                  ? S.of(context).Today
                  : DateFormat('dd MMMM yyyy').format(message.createdAt),
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Roboto",
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  height: 1.3),
            ),
          ),
        ),
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            !isMe && (message.type == -2 || message.type == -1)
                ? UserAvatar(
                    image: secondimg, size: 31, plan: secondplan ?? "s")
                : SizedBox(width: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: isMe ? true : false,
                  child: Center(
                    child: message.status == "sent"
                        ? Image.asset(
                            tik,
                            scale: 1,
                          )
                        : message.status == "delivered"
                            ? Image.asset(
                                tikk,
                                scale: 1,
                              )
                            : message.status == "waiting"
                                ? Image.asset(
                                    pending,
                                    scale: 25,
                                  )
                                : Image.asset(
                                    bluetikk,
                                    scale: 1,
                                  ),
                  ),
                ),
                Localizations.localeOf(context).languageCode.toString() == "ar"
                    ? Container(
                        padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        constraints: BoxConstraints(maxWidth: 230),
                        decoration: BoxDecoration(
                          color: isMe ? Color(0xff292929) : Color(0xff212121),
                          border: Border.all(
                              color:
                                  isMe ? Colors.transparent : Color(0xfff5f5f5),
                              width: 0.6),
                          borderRadius: isMe
                              ? borderRadius.subtract(message.type == -2
                                  ? BorderRadius.only(bottomLeft: radius)
                                  : message.type == 0
                                      ? BorderRadius.only(bottomLeft: radius)
                                      : message.type == -1
                                          ? BorderRadius.zero
                                          : BorderRadius.only(
                                              topLeft: radius,
                                              bottomLeft: radius))
                              : borderRadius.subtract(message.type == -2
                                  ? BorderRadius.only(bottomRight: radius)
                                  : message.type == 0
                                      ? BorderRadius.only(topRight: radius)
                                      : message.type == -1
                                          ? BorderRadius.zero
                                          : BorderRadius.only(
                                              topRight: radius,
                                              bottomRight: radius)),
                        ),
                        child: buildMessage(),
                      )
                    : Container(
                        padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        constraints: BoxConstraints(maxWidth: 230),
                        decoration: BoxDecoration(
                          color: isMe ? Color(0xff292929) : Color(0xff212121),
                          border: Border.all(
                              color:
                                  isMe ? Colors.transparent : Color(0xfff5f5f5),
                              width: 0.6),
                          borderRadius: isMe
                              ? borderRadius.subtract(message.type == -2
                                  ? BorderRadius.only(bottomRight: radius)
                                  : message.type == 0
                                      ? BorderRadius.only(topRight: radius)
                                      : message.type == -1
                                          ? BorderRadius.zero
                                          : BorderRadius.only(
                                              topRight: radius,
                                              bottomRight: radius))
                              : borderRadius.subtract(message.type == -2
                                  ? BorderRadius.only(bottomLeft: radius)
                                  : message.type == 0
                                      ? BorderRadius.only(topLeft: radius)
                                      : message.type == -1
                                          ? BorderRadius.zero
                                          : BorderRadius.only(
                                              topLeft: radius,
                                              bottomLeft: radius)),
                        ),
                        child: buildMessage(),
                      ),
              ],
            ),
            isMe && (message.type == -2 || message.type == -1)
                ? UserAvatar(
                    image: storage.account.profileImage == null
                        ? (isMe ? imgMalePlaceholder : imgFemalePlaceholder)
                        : storage.account.profileImage!.contains("http")
                            ? storage.account.profileImage!
                            : storage.account.profileImage!,
                    size: 31,
                    plan: mePlan)
                : SizedBox(width: 32),
          ],
        ),
      ],
    );
  }

  Widget buildMessage() => Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          isgift
              ? Image.network(
                  message.text,
                  width: 80,
                  height: 80,
                )
              : Text(
                  message.text,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Roboto",
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 1.3),
                ),
          message.type == 0 || message.type == -1
              ? SizedBox(height: 4)
              : SizedBox(height: 16),
          // if (message.type == 0 || message.type == -1)
          Text(
            TimeAgo.chatTimeAgo(message.createdAt.toLocal(), locale: locale),
            style: TextStyle(
              color: Color(0xfff5f5f5),
              fontFamily: "Roboto",
              fontSize: 9,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8)
        ],
      );
}

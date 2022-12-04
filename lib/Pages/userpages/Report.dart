import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Networking/Mobx/user_mobx.dart';
import 'package:hilike/Widget/Appbar60.dart';
import 'package:hilike/extensions.dart';
import 'package:hilike/generated/l10n.dart';

class Report extends StatefulWidget {
  final UserMobx userMobx;

  const Report({Key? key, required this.userMobx}) : super(key: key);

  @override
  ReportState createState() => ReportState();
}

class ReportState extends State<Report> with AfterLayoutMixin {
  late UserMobx userMobx;

  @override
  void initState() {
    super.initState();
    userMobx = widget.userMobx;
  }

  final TextEditingController reasonController = TextEditingController();

  var textDirection;

  @override
  Widget build(BuildContext context) {
    print("allo ${userMobx.selectedReasonIndex}");
    var size = MediaQuery.of(context).size;
    return Observer(
      builder: (_) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Appbar60(
            title: S.of(context).submitReport,
          ),
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Color(0xffe5003a),
            // disabledColor: Colors.blue
          ),
          child: ListView(
            padding: EdgeInsets.fromLTRB(20, 26, 20, 0),
            children: [
              Text(
                S
                    .of(context)
                    .chooseTheReasonForSubmittingReport
                    .replaceAll("\\n", "\n"),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.90,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    for (int i = 0; i < userMobx.reportReasons.length; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${userMobx.reportReasons[i]}",
                            style: TextStyle(
                              color: Color(0xffc4c4c4),
                              fontSize: 13,
                            ),
                          ),
                          new Radio(
                            activeColor: Color(0xffe5003a),
                            value: i,
                            groupValue: userMobx.selectedReasonIndex,
                            onChanged: userMobx.setSelectedReasonIndex,
                          ),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).other,
                          style: TextStyle(
                            color: Color(0xffc4c4c4),
                            fontSize: 13,
                          ),
                        ),
                        new Radio(
                          activeColor: Color(0xffe5003a),
                          value: userMobx.reportReasons.length,
                          groupValue: userMobx.selectedReasonIndex,
                          onChanged: (val) {
                            print("object");
                            userMobx.setSelectedReasonIndex(val);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (userMobx.selectedReasonIndex == userMobx.reportReasons.length)
                Container(
                  width: size.width / 1,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xcc292929),
                  ),
                  child: Center(
                    child: TextFormField(
                      // minLines: 1,
                      maxLines: 4,
                      cursorColor: Color(0xffe5003a),
                      style: TextStyle(color: Colors.white),
                      textDirection: textDirection,
                      onChanged: (val) {
                        RegExp regex = new RegExp("[a-zA-Z]");

                        if (val.length > 0) {
                          if (val.substring(0, 1) != " ") {
                            regex.hasMatch(val.substring(0, 1))
                                ? setState(() {
                                    textDirection = TextDirection.ltr;
                                  })
                                : setState(() {
                                    textDirection = TextDirection.rtl;
                                  });
                          } else if (val.length == 2) {
                            if (val.substring(0, 1) == " " &&
                                val.substring(1, 2) != " ")
                              regex.hasMatch(val.substring(1, 2))
                                  ? setState(() {
                                      textDirection = TextDirection.ltr;
                                    })
                                  : setState(() {
                                      textDirection = TextDirection.rtl;
                                    });
                          } else if (val.length > 2) {
                            regex.hasMatch(val.substring(
                                    val.lastIndexOf(" ") + 1,
                                    val.lastIndexOf(" ") + 2))
                                ? setState(() {
                                    textDirection = TextDirection.ltr;
                                  })
                                : setState(() {
                                    textDirection = TextDirection.rtl;
                                  });
                          }
                        } else if (val.length == 0) {
                          setState(() {});
                        }
                      },
                      controller: reasonController,
                      decoration: InputDecoration(
                        hintText: S.of(context).enterYourMessage,
                        hintStyle: TextStyle(
                          color: Color(0xff949393),
                          fontSize: 13,
                          letterSpacing: 0.65,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              if (userMobx.reportReasons.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    if (userMobx.selectedReasonIndex ==
                            userMobx.reportReasons.length &&
                        reasonController.text.isEmpty) {
                      showTopSnackBar(
                          S.of(context).pleaseEnterReason.replaceAll(".", ""),
                          "assets/img/iii.png");
                    } else {
                      userMobx.reportUser(context,
                          resason: reasonController.text);
                    }
                  },
                  child: Container(
                    // width: size.width/1,
                    height: size.height / 14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffe5003a),
                    ),
                    child: Center(
                      child: Text(
                        S.of(context).send,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.75,
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    userMobx.getReportReasons(context);
  }
}

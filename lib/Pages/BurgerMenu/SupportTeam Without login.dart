import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Networking/Mobx/profile_mobx.dart';
import 'package:hilike/Utils/validation.dart';
import 'package:hilike/Widget/Appbar60.dart';

import 'package:hilike/extensions.dart';
import 'package:hilike/generated/l10n.dart';

class SupportTeamWithoutLogin extends StatefulWidget {
  @override
  _SupportTeamWithoutLoginState createState() =>
      _SupportTeamWithoutLoginState();
}

class _SupportTeamWithoutLoginState extends State<SupportTeamWithoutLogin> {
  ProfileMobx profileMobx = ProfileController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  var textDirection;
  var textDirection2;
  var textDirection3;
  var textDirection4;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Observer(
        builder: (_) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: Appbar60(
                title: S.of(context).contactUs2,
              ),
            ),
            body: ListView(
              padding: EdgeInsets.all(20),
              shrinkWrap: true,
              children: [
                Text(
                  S.of(context).name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.75,
                  ),
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                Container(
                  width: size.width / 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xcc292929),
                  ),
                  child: Center(
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 2,
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
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: S.of(context).username,
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
                SizedBox(
                  height: size.height / 50,
                ),
                Text(
                  S.of(context).email,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.75,
                  ),
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                Container(
                  width: size.width / 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xcc292929),
                  ),
                  child: Center(
                    child: TextFormField(
                      cursorColor: Color(0xffe5003a),
                      style: TextStyle(color: Colors.white),
                      textDirection: textDirection2,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {
                        RegExp regex = new RegExp("[a-zA-Z]");

                        if (val.length > 0) {
                          if (val.substring(0, 1) != " ") {
                            regex.hasMatch(val.substring(0, 1))
                                ? setState(() {
                                    textDirection2 = TextDirection.ltr;
                                  })
                                : setState(() {
                                    textDirection2 = TextDirection.rtl;
                                  });
                          } else if (val.length == 2) {
                            if (val.substring(0, 1) == " " &&
                                val.substring(1, 2) != " ")
                              regex.hasMatch(val.substring(1, 2))
                                  ? setState(() {
                                      textDirection2 = TextDirection.ltr;
                                    })
                                  : setState(() {
                                      textDirection2 = TextDirection.rtl;
                                    });
                          } else if (val.length > 2) {
                            regex.hasMatch(val.substring(
                                    val.lastIndexOf(" ") + 1,
                                    val.lastIndexOf(" ") + 2))
                                ? setState(() {
                                    textDirection2 = TextDirection.ltr;
                                  })
                                : setState(() {
                                    textDirection2 = TextDirection.rtl;
                                  });
                          }
                        } else if (val.length == 0) {
                          setState(() {});
                        }
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: S.of(context).enterSubject,
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
                SizedBox(
                  height: size.height / 50,
                ),
                Text(
                  S.of(context).subject,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.75,
                  ),
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                Container(
                  width: size.width / 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xcc292929),
                  ),
                  child: Center(
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 2,
                      cursorColor: Color(0xffe5003a),
                      style: TextStyle(color: Colors.white),
                      textDirection: textDirection3,
                      onChanged: (val) {
                        RegExp regex = new RegExp("[a-zA-Z]");

                        if (val.length > 0) {
                          if (val.substring(0, 1) != " ") {
                            regex.hasMatch(val.substring(0, 1))
                                ? setState(() {
                                    textDirection3 = TextDirection.ltr;
                                  })
                                : setState(() {
                                    textDirection3 = TextDirection.rtl;
                                  });
                          } else if (val.length == 2) {
                            if (val.substring(0, 1) == " " &&
                                val.substring(1, 2) != " ")
                              regex.hasMatch(val.substring(1, 2))
                                  ? setState(() {
                                      textDirection3 = TextDirection.ltr;
                                    })
                                  : setState(() {
                                      textDirection3 = TextDirection.rtl;
                                    });
                          } else if (val.length > 2) {
                            regex.hasMatch(val.substring(
                                    val.lastIndexOf(" ") + 1,
                                    val.lastIndexOf(" ") + 2))
                                ? setState(() {
                                    textDirection3 = TextDirection.ltr;
                                  })
                                : setState(() {
                                    textDirection3 = TextDirection.rtl;
                                  });
                          }
                        } else if (val.length == 0) {
                          setState(() {});
                        }
                      },
                      controller: subjectController,
                      decoration: InputDecoration(
                        hintText: S.of(context).enterSubject,
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
                SizedBox(
                  height: size.height / 50,
                ),
                Text(
                  S.of(context).smessages,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.75,
                  ),
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                Container(
                  width: size.width / 1,
                  height: size.height / 4.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xcc292929),
                  ),
                  child: TextFormField(
                    minLines: 1,
                    maxLines: 5,
                    cursorColor: Color(0xffe5003a),
                    style: TextStyle(color: Colors.white),
                    controller: messageController,
                    textDirection: textDirection4,
                    onChanged: (val) {
                      RegExp regex = new RegExp("[a-zA-Z]");

                      if (val.length > 0) {
                        if (val.substring(0, 1) != " ") {
                          regex.hasMatch(val.substring(0, 1))
                              ? setState(() {
                                  textDirection4 = TextDirection.ltr;
                                })
                              : setState(() {
                                  textDirection4 = TextDirection.rtl;
                                });
                        } else if (val.length == 2) {
                          if (val.substring(0, 1) == " " &&
                              val.substring(1, 2) != " ")
                            regex.hasMatch(val.substring(1, 2))
                                ? setState(() {
                                    textDirection4 = TextDirection.ltr;
                                  })
                                : setState(() {
                                    textDirection4 = TextDirection.rtl;
                                  });
                        } else if (val.length > 2) {
                          regex.hasMatch(val.substring(val.lastIndexOf(" ") + 1,
                                  val.lastIndexOf(" ") + 2))
                              ? setState(() {
                                  textDirection4 = TextDirection.ltr;
                                })
                              : setState(() {
                                  textDirection4 = TextDirection.rtl;
                                });
                        }
                      } else if (val.length == 0) {
                        setState(() {});
                      }
                    },
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
                SizedBox(
                  height: size.height / 50,
                ),
                GestureDetector(
                  onTap: () {
                    if (subjectController.text.length == 0 ||
                        nameController.text.length == 0 ||
                        emailController.text.length == 0 ||
                        messageController.text.length == 0) {
                      showTopSnackBar(
                          S.of(context).youhavetofilltherequiderfilde,
                          "assets/img/iii.png");
                    } else {
                      if (Validations.validateEmail(
                              emailController.text, context) !=
                          null) {
                        showTopSnackBar(
                            S.of(context).invalidEmail, "assets/img/iii.png");
                      } else {
                        profileMobx
                            .supportticket(
                                context,
                                nameController.text,
                                emailController.text,
                                subjectController.text,
                                messageController.text)
                            .then((value) => profileMobx.isSent == true
                                ? showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: AlertDialog(
                                            backgroundColor: Color(0xff292929),
                                            actionsPadding:
                                                EdgeInsets.all(25.0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0))),
                                            actions: <Widget>[
                                              Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      child: Image.asset(
                                                          "assets/img/Gcheck.png"
                                                          // scale: 2,
                                                          ),
                                                    ),
                                                    SizedBox(
                                                      height: 23,
                                                    ),
                                                    Text(
                                                      S
                                                          .of(context)
                                                          .sucssMessage,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        letterSpacing: 0.65,
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xff80c56e),
                                                        fontFamily: "Roboto",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      S.of(context).Welcome,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Roboto",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ]),
                                      );
                                    })
                                : print("object"));
                      }
                    }
                  },
                  child: Container(
                    height: size.height / 13.8,
                    width: size.width / 1.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffe5003a),
                    ),
                    child: Center(
                      child: Text(
                        S.of(context).send,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.75,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

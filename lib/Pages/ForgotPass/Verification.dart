import 'package:flutter/material.dart';
import 'package:hilike/Networking/Mobx/forgot_password_mobx.dart';
import 'package:hilike/Networking/Mobx/verify_mobx.dart';
import 'package:hilike/Pages/ForgotPass/Verification2.dart';
import 'package:hilike/Widget/BackButton.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

import '../../extensions.dart';
import 'Verification3.dart';

class Verification extends StatefulWidget {
  final String? email;
  final bool isFromSignup;

  Verification({this.email, required this.isFromSignup});

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  FocusNode fn1 = FocusNode();
  FocusNode fn2 = FocusNode();
  FocusNode fn3 = FocusNode();
  FocusNode fn4 = FocusNode();
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();

  String? num1, num2, num3, num4;
  VerifyMobx verifyMobx = VerifyController();
  ForgotPasswordMobx forgotPasswordMobx = ForgotPasswordController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0x1A1A1A),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height / 6,
              ),
              BackButtoncon(
                register: false,
                towelcome: true,
              ),
              SizedBox(
                height: size.height / 15,
              ),
              Text(
                S.of(context).emailVerification.replaceAll("\\n", "\n"),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(
                height: size.height / 25,
              ),
              Text(
                S.of(context).weHaveSentaCodeToYourEmail,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xfff5f5f5),
                  fontSize: 13,
                  letterSpacing: 0.65,
                ),
              ),
              SizedBox(
                height: size.height / 18,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x59000000),
                              blurRadius: 4,
                              offset: Offset(0, 0),
                            ),
                          ],
                          color: Color(0xff292929),
                        ),
                        child: Center(
                          child: TextFormField(
                            cursorColor: Color(0xffe5003a),
                            controller: c1,
                            focusNode: fn1,
                            textAlign: TextAlign.center,
                            onChanged: (val) {
                              num1 = val;
                              if (val.isNotEmpty) {
                                fn1.unfocus();
                                FocusScope.of(context).requestFocus(fn2);
                              }
                            },
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (String term) {
                              fn1.unfocus();
                              FocusScope.of(context).requestFocus(fn2);
                            },
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w900,
                                height: 1),
                            decoration: InputDecoration(
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
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x59000000),
                              blurRadius: 4,
                              offset: Offset(0, 0),
                            ),
                          ],
                          color: Color(0xff292929),
                        ),
                        child: Center(
                          child: TextFormField(
                            cursorColor: Color(0xffe5003a),
                            controller: c2,
                            focusNode: fn2,
                            textAlign: TextAlign.center,
                            onChanged: (val) {
                              num2 = val;
                              if (val.isNotEmpty) {
                                fn2.unfocus();
                                FocusScope.of(context).requestFocus(fn3);
                              }
                            },
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (String term) {
                              fn2.unfocus();
                              FocusScope.of(context).requestFocus(fn3);
                            },
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w900,
                                height: 1),
                            decoration: InputDecoration(
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
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x59000000),
                              blurRadius: 4,
                              offset: Offset(0, 0),
                            ),
                          ],
                          color: Color(0xff292929),
                        ),
                        child: Center(
                          child: TextFormField(
                            cursorColor: Color(0xffe5003a),
                            controller: c3,
                            focusNode: fn3,
                            textAlign: TextAlign.center,
                            onChanged: (val) {
                              num3 = val;
                              if (val.isNotEmpty) {
                                fn3.unfocus();
                                FocusScope.of(context).requestFocus(fn4);
                              }
                            },
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (String term) {
                              fn3.unfocus();
                              FocusScope.of(context).requestFocus(fn4);
                            },
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w900,
                                height: 1),
                            decoration: InputDecoration(
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
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x59000000),
                              blurRadius: 4,
                              offset: Offset(0, 0),
                            ),
                          ],
                          color: Color(0xff292929),
                        ),
                        child: Center(
                          child: TextFormField(
                            cursorColor: Color(0xffe5003a),
                            controller: c4,
                            focusNode: fn4,
                            textAlign: TextAlign.center,
                            onChanged: (val) {
                              num1 = val;
                              if (val.isNotEmpty) {
                                submit(context);
                              }
                            },
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (String term) {
                              submit(context);
                            },
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w900,
                                height: 1),
                            decoration: InputDecoration(
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
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).didNotReceiveEmail,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.65,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (widget.isFromSignup) {
                        verifyMobx.resendCode(context,
                            email: widget.email ?? "");
                      } else {
                        forgotPasswordMobx.forgotPassword(context,
                            email: widget.email ?? "");
                      }
                    },
                    child: Text(
                      S.of(context).resendCode,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff0583f2),
                        fontFamily: 'Roboto',
                        fontSize: 13,
                        letterSpacing: 0.65,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (widget.email == null) {
                    Navigator.pop(context);
                    showTopSnackBar(
                        S.of(context).connectionFailed, "assets/img/iii.png");
                  } else
                    submit(context);
                },
                child: Container(
                  height: size.height / 13,
                  width: size.width / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xffe5003a),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Container(
                          width: 60,
                          child: Center(
                            child: Text(
                              S.of(context).submit,
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
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submit(context) {
    String code = c1.text + c2.text + c3.text + c4.text;
    if (widget.isFromSignup) {
      verifyMobx.verify(context, code: code, email: widget.email ?? "",
          onSuccess: () {
        Verification2(
                email: widget.email ?? "",
                isFromSignup: widget.isFromSignup,
                code: code)
            .launch(context);
      }, onError: () {
        Verification3(
                email: widget.email ?? "", isFromSignup: widget.isFromSignup)
            .launch(context);
      });
    } else {
      forgotPasswordMobx.verifyCode(context, code: code, onSuccess: () {
        Verification2(
                email: widget.email ?? "",
                isFromSignup: widget.isFromSignup,
                code: code)
            .launch(context);
      }, onError: () {
        Verification3(
                email: widget.email ?? "", isFromSignup: widget.isFromSignup)
            .launch(context);
      });
    }
  }
}

import 'package:flutter/material.dart';
import 'package:hilike/Networking/Mobx/forgot_password_mobx.dart';
import 'package:hilike/Networking/Mobx/verify_mobx.dart';
import 'package:hilike/Widget/BackButton.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

import 'Verification.dart';

class Verification3 extends StatefulWidget {
  final String? email;
  final bool isFromSignup;

  Verification3({this.email, required this.isFromSignup});

  @override
  _Verification3State createState() => _Verification3State();
}

class _Verification3State extends State<Verification3> {
  VerifyMobx verifyMobx = VerifyController();
  ForgotPasswordMobx forgotPasswordMobx = ForgotPasswordController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0x1A1A1A),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height / 6,
            ),
            BackButtoncon(
              register: false,
              towelcome: false,
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
            Container(
                height: size.height / 16,
                width: size.width / 1,
                child: Image.asset(
                  "assets/img/cir.png",
                )),
            SizedBox(
              height: size.height / 40,
            ),
            Center(
              child: Text(
                S.of(context).incorrectTryAgainLater,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
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
                      verifyMobx.resendCode(context, email: widget.email ?? "",
                          onSuccess: () {
                        Verification(
                                email: widget.email ?? "",
                                isFromSignup: widget.isFromSignup)
                            .launch(context);
                      });
                    } else {
                      forgotPasswordMobx.forgotPassword(context,
                          email: widget.email ?? "", onSuccess: () {
                        Verification(email: widget.email, isFromSignup: false)
                            .launch(context);
                      });
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
                if (widget.isFromSignup) {
                  verifyMobx.resendCode(context, email: widget.email ?? "",
                      onSuccess: () {
                    Verification(
                            email: widget.email ?? "",
                            isFromSignup: widget.isFromSignup)
                        .launch(context);
                  });
                } else {
                  forgotPasswordMobx.forgotPassword(context,
                      email: widget.email ?? "", onSuccess: () {
                    Verification(email: widget.email, isFromSignup: false)
                        .launch(context);
                  });
                }
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
                        width: 100,
                        child: Center(
                          child: Text(
                            S.of(context).resendCode,
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hilike/Networking/Mobx/forgot_password_mobx.dart';
import 'package:hilike/Utils/validation.dart';
import 'package:hilike/Widget/BackButton.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

import 'Verification.dart';

class Forgotpass extends StatefulWidget {
  @override
  _ForgotpassState createState() => _ForgotpassState();
}

class _ForgotpassState extends State<Forgotpass> {
  ForgotPasswordMobx forgotPasswordMobx = ForgotPasswordController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var textDirection;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0x1A1A1A),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
        children: [
          SizedBox(
            height: size.height / 6,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButtoncon(
                register: false,
                towelcome: false,
              ),
              Container(
                  height: size.height / 8,
                  width: size.width / 1.4,
                  child: Image.asset(
                    "assets/img/H.png",
                  )),
            ],
          ),
          SizedBox(
            height: size.height / 4,
          ),
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "  ${S.of(context).weWillSendNewPasswordToYourEmail}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color(0xfff5f5f5),
                    fontSize: 13,
                    letterSpacing: 0.65,
                  ),
                ),
                SizedBox(
                  height: 17,
                ),
                Container(
                  child: TextFormField(
                    cursorColor: Color(0xffe5003a),
                    controller: emailController,
                    validator: (value) =>
                        Validations.validateEmail(value, context),
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    onFieldSubmitted: (val) {
                      if (formKey.currentState!.validate()) {
                        forgotPasswordMobx.forgotPassword(context, email: val,
                            onSuccess: () {
                          Verification(email: val, isFromSignup: false)
                              .launch(context);
                        });
                      }
                    },
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
                          regex.hasMatch(val.substring(val.lastIndexOf(" ") + 1,
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
                    decoration: InputDecoration(
                      hintText: "${S.of(context).yourMail}",
                      hintStyle: TextStyle(
                        color: Color(0xffc4c4c4),
                        fontSize: 13,
                        letterSpacing: 0.65,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.alternate_email_sharp,
                          color: Color(0xffc4c4c4),
                        ),
                      ),
                      fillColor: Color(0xcc292929),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      forgotPasswordMobx.forgotPassword(context,
                          email: emailController.text, onSuccess: () {
                        Verification(
                                email: emailController.text,
                                isFromSignup: false)
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
                            width: 60,
                            child: Center(
                              child: Text(
                                S.of(context).next,
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
        ],
      ),
    );
  }
}

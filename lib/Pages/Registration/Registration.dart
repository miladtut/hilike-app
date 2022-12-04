import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Models/app.dart';
import 'package:hilike/Networking/Mobx/signup_mobx.dart';
import 'package:hilike/Pages/Registration/Registration2.dart';
import 'package:hilike/Utils/validation.dart';
import 'package:hilike/Widget/BackButton.dart';
import 'package:hilike/Widget/PointRow.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:provider/provider.dart';

import '../../extensions.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  SignupMobx signupMobx = SignupController();
  FocusNode fnUsername = FocusNode();
  FocusNode fnEmail = FocusNode();
  FocusNode fnPassword = FocusNode();
  FocusNode fnConfirmPassword = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var textDirection;
  var textDirection2;
  var textDirection3;
  var textDirection4;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    signupMobx.setLang(Provider.of<AppModel>(context, listen: false).locale);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/cop.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Observer(
          builder: (_) => Scaffold(
            backgroundColor: Color(0x1A1A1A),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height / 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                      child: BackButtoncon(
                        register: true,
                        towelcome: false,
                      ),
                    ),
                    SizedBox(
                      height: size.height / 22,
                    ),
                    PointRow(
                      color1: Color(0xffe5003a),
                      color2: Color(0xffe5003a),
                      line1color: Color(0xffe5003a),
                      line2color: Colors.white,
                      line3color: Colors.white,
                    ),
                    SizedBox(
                      height: size.height / 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).registration,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.90,
                            ),
                          ),
                          SizedBox(
                            height: size.height / 80,
                          ),
                          Text(
                            S.of(context).pleaseEnterYourData,
                            style: TextStyle(
                              color: Color(0xfff5f5f5),
                              fontSize: 13,
                              letterSpacing: 0.65,
                            ),
                          ),
                          SizedBox(
                            height: size.height / 60,
                          ),
                          Container(
                            width: size.width / 1,
                            child: TextFormField(
                              cursorColor: Color(0xffe5003a),
                              focusNode: fnUsername,
                              validator: (value) =>
                                  Validations.validateUsername(value, context),
                              textDirection: textDirection,
                              onChanged: (val) {
                                RegExp regex = new RegExp("[a-zA-Z]");
                                signupMobx.setUsername(val);
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
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String term) {
                                fnUsername.unfocus();
                                FocusScope.of(context).requestFocus(fnEmail);
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                hintText: "${S.of(context).username}",
                                hintStyle: TextStyle(
                                  color: Color(0xffc4c4c4),
                                  fontSize: 13,
                                  letterSpacing: 0.65,
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
                            height: size.height / 50,
                          ),
                          Container(
                            width: size.width / 1,
                            child: TextFormField(
                              cursorColor: Color(0xffe5003a),
                              focusNode: fnEmail,
                              validator: (value) =>
                                  Validations.validateEmail(value, context),
                              textDirection: textDirection2,
                              onChanged: (val) {
                                RegExp regex = new RegExp("[a-zA-Z]");
                                signupMobx.setEmail(val);
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
                                              textDirection2 =
                                                  TextDirection.ltr;
                                            })
                                          : setState(() {
                                              textDirection2 =
                                                  TextDirection.rtl;
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
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String term) {
                                fnEmail.unfocus();
                                FocusScope.of(context).requestFocus(fnPassword);
                              },
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                hintText: "${S.of(context).enterYourMail}",
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
                            height: size.height / 50,
                          ),
                          Container(
                            width: size.width / 1,
                            child: TextFormField(
                              cursorColor: Color(0xffe5003a),
                              focusNode: fnPassword,
                              validator: (value) =>
                                  Validations.validatePassword(value, context),
                              textDirection: textDirection3,
                              onChanged: (val) {
                                RegExp regex = new RegExp("[a-zA-Z]");
                                signupMobx.setPassword(val);
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
                                              textDirection3 =
                                                  TextDirection.ltr;
                                            })
                                          : setState(() {
                                              textDirection3 =
                                                  TextDirection.rtl;
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
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String term) {
                                fnPassword.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(fnConfirmPassword);
                              },
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: signupMobx.hidePassword,
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                hintText: "${S.of(context).enterPassword}",
                                hintStyle: TextStyle(
                                  color: Color(0xffc4c4c4),
                                  fontSize: 13,
                                  letterSpacing: 0.65,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () => signupMobx.setHidePassword(
                                      !signupMobx.hidePassword),
                                  icon: Icon(
                                    signupMobx.hidePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
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
                            height: size.height / 50,
                          ),
                          Container(
                            width: size.width / 1,
                            child: TextFormField(
                              cursorColor: Color(0xffe5003a),
                              focusNode: fnConfirmPassword,
                              validator: (value) =>
                                  Validations.validateConfirmPassword(value,
                                      signupMobx.password ?? "", context),
                              textDirection: textDirection4,
                              onChanged: (val) {
                                RegExp regex = new RegExp("[a-zA-Z]");
                                signupMobx.setConfirmPassword(val);
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
                                              textDirection4 =
                                                  TextDirection.ltr;
                                            })
                                          : setState(() {
                                              textDirection4 =
                                                  TextDirection.rtl;
                                            });
                                  } else if (val.length > 2) {
                                    regex.hasMatch(val.substring(
                                            val.lastIndexOf(" ") + 1,
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
                              textInputAction: TextInputAction.done,
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: signupMobx.hideConfirmPassword,
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                hintText: "${S.of(context).confirmPassword}",
                                hintStyle: TextStyle(
                                  color: Color(0xffc4c4c4),
                                  fontSize: 13,
                                  letterSpacing: 0.65,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () =>
                                      signupMobx.setHideConfirmPassword(
                                          !signupMobx.hideConfirmPassword),
                                  icon: Icon(
                                    signupMobx.hideConfirmPassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
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
                            height: size.height / 35,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: size.width / 25,
                              ),
                              Container(
                                color: Colors.white,
                                width: 14,
                                height: 14,
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: Colors.white,
                                      cardColor: Colors.white),
                                  child: Checkbox(
                                    hoverColor: Colors.white,
                                    value: signupMobx.agree,
                                    onChanged: (value) {
                                      signupMobx.setAgree(!signupMobx.agree);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 11,
                              ),
                              Text(
                                S.of(context).agreeTermsOfUseAndPrivacyPolicy,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 0.65,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height / 25,
                          ),
                          GestureDetector(
                            onTap: () {
                              next();
                            },
                            child: Container(
                              width: size.width / 1,
                              height: size.height / 13.8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xffe5003a),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Container(
                                      width: 50,
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
                          SizedBox(
                            height: size.height / 50,
                          ),
                          Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).alreadyHaveAnAccount,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Roboto',
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0.65,
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, 'login');
                                    },
                                    child: Text(
                                      S.of(context).log_in,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xff0583f2),
                                        fontFamily: 'Roboto',
                                        fontSize: 13,
                                        letterSpacing: 0.65,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )),
                              ])
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void next() {
    if (formKey.currentState!.validate()) {
      if (signupMobx.agree) {
        Registration2(signupMobx: signupMobx).launch(context);
      } else {
        showTopSnackBar(
            S.of(context).youShouldAgreeTermsToFirst, "assets/img/iii.png");
      }
    }
  }
}

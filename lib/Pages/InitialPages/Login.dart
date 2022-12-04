import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Networking/Mobx/login_mobx.dart';
import 'package:hilike/Pages/MainPages/MainMenu.dart';
import 'package:hilike/Utils/validation.dart';
import 'package:hilike/Widget/BackButton.dart';
import 'package:hilike/extensions.dart';
import 'package:hilike/generated/l10n.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginMobx loginMobx = LoginController();
  FocusNode fnEmail = FocusNode();
  FocusNode fnPassword = FocusNode();
  final TextEditingController messageController = TextEditingController();
  var textDirection;
  var textDirection2;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/coop.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Observer(
          builder: (_) => Scaffold(
            // resizeToAvoidBottomInset: true,
            backgroundColor: Color(0x1A1A1A),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
              child: SingleChildScrollView(
                child: Form(
                  key: loginMobx.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height / 8,
                      ),
                      BackButtoncon(
                        register: true,
                        towelcome: true,
                      ),
                      SizedBox(
                        height: size.height / 3.5,
                      ),
                      Text(
                        S.of(context).login,
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
                        height: 9,
                      ),
                      Text(
                        S.of(context).pleaseLoginToUseTheApp,
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
                        width: size.width / 1.1,
                        child: TextFormField(
                          cursorColor: Color(0xffe5003a),
                          textDirection: textDirection,
                          focusNode: fnEmail,
                          // validator: (value) =>
                          //     Validations.validateEmail(value, context),
                          onChanged: (val) {
                            RegExp regex = new RegExp("[a-zA-Z]");
                            loginMobx.setEmail(val);
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
                            fnEmail.unfocus();
                            FocusScope.of(context).requestFocus(fnPassword);
                          },
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText:
                                "${S.of(context).loginWithEmailOrUsername}",
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
                        height: 18,
                      ),
                      Container(
                        width: size.width / 1.1,
                        child: TextFormField(
                          cursorColor: Color(0xffe5003a),
                          focusNode: fnPassword,
                          validator: (value) =>
                              Validations.validatePassword(value, context),
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (String term) {
                            login(context);
                          },
                          textDirection: textDirection2,
                          onChanged: (val) {
                            loginMobx.setPassword(val);
                            RegExp regex = new RegExp("[a-zA-Z]");
                            // print("test ${regex.hasMatch(val)}");
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
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: loginMobx.hidePassword,
                          decoration: InputDecoration(
                            hintText: "${S.of(context).enterPassword}",
                            hintStyle: TextStyle(
                              color: Color(0xffc4c4c4),
                              fontSize: 13,
                              letterSpacing: 0.65,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => loginMobx
                                  .setHidePassword(!loginMobx.hidePassword),
                              icon: Icon(
                                loginMobx.hidePassword
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          RaisedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'forgetpass');
                              },
                              color: Colors.transparent,
                              elevation: 0,
                              child: Text(
                                S.of(context).forgotYourPassword,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Color(0xff0583f2),
                                  fontFamily: 'Roboto',
                                  fontSize: 13,
                                  letterSpacing: 0.65,
                                  fontWeight: FontWeight.normal,
                                ),
                              )),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          login(context);
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
                              S.of(context).signIn,
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
                      SizedBox(
                        height: 17,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).doNotHaveAnAccount,
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
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'register');
                            },
                            child: Text(
                              S.of(context).signup,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff0583f2),
                                fontFamily: 'Roboto',
                                fontSize: 13,
                                letterSpacing: 0.65,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> gettoken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      return token;
    } on Exception catch (e) {
      print("e $e");
      // TODO
    }
  }

  Future<void> login(context) async {
    await gettoken().then((value) => loginMobx.setDeviceToken(value));
    if ((loginMobx.email ?? "").length > 0) {
      loginMobx.login(context,
          onSuccess: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Mainmenu(
                          fromPage: "log",
                        )),
                ModalRoute.withName('/'),
              ));
    } else {
      showTopSnackBar(S.of(context).logver, "assets/img/iii.png");
    }
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hilike/Networking/Mobx/signup_mobx.dart';
import 'package:hilike/Pages/ForgotPass/Verification.dart';
import 'package:hilike/Pages/MainPages/MainMenu.dart';
import 'package:hilike/Utils/validation.dart';
import 'package:hilike/Widget/BackButton.dart';
import 'package:hilike/Widget/FirstTimeDialog.dart';
import 'package:hilike/Widget/PointRow.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class Registration3 extends StatefulWidget {
  final SignupMobx? signupMobx;

  const Registration3({Key? key, this.signupMobx}) : super(key: key);

  @override
  _Registration3State createState() => _Registration3State();
}

class _Registration3State extends State<Registration3> {
  SignupMobx? signupMobx;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    signupMobx = widget.signupMobx;
  }

  var textDirection;

  Future<String?> gettoken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      return token;
    } on Exception catch (e) {
      print("e $e");
      // TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("222 ${signupMobx!.provider_token}");
    print("image :  ${signupMobx!.profileImage}");
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
        child: Scaffold(
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
                    color1: HexColor("#3BC148"),
                    color2: HexColor("#3BC148"),
                    line1color: HexColor("#3BC148"),
                    line2color: HexColor("#3BC148"),
                    line3color: HexColor("#3BC148"),
                  ),
                  SizedBox(
                    height: size.height / 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width / 1,
                          child: TextFormField(
                            cursorColor: Color(0xffe5003a),
                            validator: (value) =>
                                Validations.emptyValidation(value, context),
                            onChanged: (val) {
                              RegExp regex = new RegExp("[a-zA-Z]");
                              signupMobx!.setNickname(val);
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
                            textDirection: textDirection,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (String term) {
                              register();
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "${S.of(context).nickname}",
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
                          height: size.height / 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            register();
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
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        S.of(context).registration,
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
                          height: size.height / 30,
                        ),
                        Row(
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
                                Navigator.pop(context);
                                Navigator.pop(context);
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
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      await gettoken().then((value) => signupMobx!.setdevicetoken(value));
      signupMobx!.signup(context, onSuccess: () {
        signupMobx!.confirmPassword == null
            ? signupMobx!
                .socialLoginnew(
                    context, signupMobx!.provider_token!, signupMobx!.provider!,
                    onSuccess: () async =>
                        // Navigator.pushReplacementNamed(context, 'mainmenu'))
                        await Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Mainmenu()),
                          ModalRoute.withName('/'),
                        ))
                .then((value) => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FirstTimeDialog();
                    }))
            : Verification(email: signupMobx!.email ?? "", isFromSignup: true)
                .launch(context, isNewTask: true);
      });
    }
  }
}

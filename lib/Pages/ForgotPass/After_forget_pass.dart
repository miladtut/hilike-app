import 'package:flutter/material.dart';
import 'package:hilike/Networking/Mobx/forgot_password_mobx.dart';
import 'package:hilike/Pages/MainPages/MainMenu.dart';
import 'package:hilike/Utils/validation.dart';
import 'package:hilike/Widget/BackButton.dart';
import 'package:hilike/generated/l10n.dart';

class AfterPass extends StatefulWidget {
  final String code;

  AfterPass({required this.code});

  @override
  _AfterPassState createState() => _AfterPassState();
}

class _AfterPassState extends State<AfterPass> {
  bool _isHidden = true;
  bool _isConfirmHidden = true;
  FocusNode fnPassword = FocusNode();
  FocusNode fnConfirmPassword = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String password = "";
  ForgotPasswordMobx forgotPasswordMobx = ForgotPasswordController();

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _toggleConfirmPasswordView() {
    setState(() {
      _isConfirmHidden = !_isConfirmHidden;
    });
  }

  var textDirection;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0x1A1A1A),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
          child: Form(
            key: formKey,
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
                  S.of(context).createNewPassword.replaceAll("\\n", "\n"),
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
                  S.of(context).youCanCreateNewPassword.replaceAll("\\n", "\n"),
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xfff5f5f5),
                    fontSize: 13,
                    letterSpacing: 0.65,
                  ),
                ),
                SizedBox(
                  height: size.height / 25,
                ),
                Container(
                  child: TextFormField(
                    cursorColor: Color(0xffe5003a),
                    focusNode: fnPassword,
                    validator: (value) =>
                        Validations.validatePassword(value, context),
                    onChanged: (val) {
                      RegExp regex = new RegExp("[a-zA-Z]");
                      password = val;
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
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (String term) {
                      fnPassword.unfocus();
                      FocusScope.of(context).requestFocus(fnConfirmPassword);
                    },
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _isHidden,
                    textDirection: textDirection,
                    decoration: InputDecoration(
                      hintText: "${S.of(context).newPassword}",
                      hintStyle: TextStyle(
                        color: Color(0xffc4c4c4),
                        fontSize: 13,
                        letterSpacing: 0.65,
                      ),
                      suffixIcon: IconButton(
                        onPressed: _togglePasswordView,
                        icon: Icon(
                          _isHidden
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
                  height: size.height / 32,
                ),
                Container(
                  child: TextFormField(
                    cursorColor: Color(0xffe5003a),
                    focusNode: fnConfirmPassword,
                    validator: (value) => Validations.validateConfirmPassword(
                        value, password, context),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (String term) {
                      submit(context);
                    },
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _isConfirmHidden,
                    decoration: InputDecoration(
                      hintText: "${S.of(context).confirmPassword}",
                      hintStyle: TextStyle(
                        color: Color(0xffc4c4c4),
                        fontSize: 13,
                        letterSpacing: 0.65,
                      ),
                      suffixIcon: IconButton(
                        onPressed: _toggleConfirmPasswordView,
                        icon: Icon(
                          _isConfirmHidden
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
                  height: size.height / 24,
                ),
                GestureDetector(
                  onTap: () {
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
        ),
      ),
    );
  }

  void submit(BuildContext context) {
    if (formKey.currentState!.validate()) {
      forgotPasswordMobx.resetPassword(context,
          password: password, code: widget.code, onSuccess: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Mainmenu(fromPage: "log")),
          ModalRoute.withName('/'),
        );
      });
    }
  }
}

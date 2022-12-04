import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Networking/Mobx/settings_mobx.dart';
import 'package:hilike/Utils/validation.dart';
import 'package:hilike/Widget/Navigation.dart';
import 'package:hilike/generated/l10n.dart';

class Changepassword extends StatefulWidget {
  @override
  _ChangepasswordState createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  SettingsMobx settingsMobx = SettingsController();
  FocusNode fnEmail = FocusNode();
  FocusNode fnUsername = FocusNode();
  FocusNode fnCurrentPassword = FocusNode();
  FocusNode fnNewPassword = FocusNode();
  FocusNode fnConfirmNewPassword = FocusNode();
  var textDirection;
  var textDirection2;
  var textDirection3;
  var textDirection4;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final arguments = ModalRoute.of(context)!.settings.arguments as String;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Observer(
        builder: (_) => Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: AppBar(
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Localizations.localeOf(context).languageCode.toString() ==
                          "ar"
                      ? Icons.arrow_back_ios
                      : Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              centerTitle: true,
              title: Text(
                S.of(context).changePassword,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.10,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: Color(0xff292929),
              flexibleSpace: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height / 8.5,
                  ),
                  GestureDetector(
                    onTap: () async {
                      settingsMobx.setEmail(arguments);
                      var success = await settingsMobx.changePassword(context);
                      if (success) Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      width: 109,
                      height: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white,
                          width: 0.50,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).apply,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
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
          body: Form(
            key: settingsMobx.formKey,
            child: ListView(
              padding: EdgeInsets.fromLTRB(20, 29, 20, 0),
              shrinkWrap: true,
              children: [
                /*
                Container(
                  width: size.width / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xcc292929),
                  ),
                  child: TextFormField(
                    focusNode: fnUsername,
                    validator: (value) =>
                        Validations.emptyValidation(value, context),
                    onChanged: (val) {
                      settingsMobx.setUsername(val);
                    },
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (String term) {
                      fnUsername.unfocus();
                      FocusScope.of(context).requestFocus(fnEmail);
                    },
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "    ${S.of(context).username}...",
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
    */
                Container(
                    width: size.width / 1.1,
                    height: size.height / 14,
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width / 30,
                    ),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xcc292929),
                    ),
                    child: Text(
                      arguments,
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(
                  height: size.height / 50,
                ),
                Container(
                  width: size.width / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xcc292929),
                  ),
                  child: TextFormField(
                    cursorColor: Color(0xffe5003a),
                    focusNode: fnCurrentPassword,
                    validator: (value) =>
                        Validations.validatePassword(value, context),
                    textDirection: textDirection2,
                    onChanged: (val) {
                      RegExp regex = new RegExp("[a-zA-Z]");
                      settingsMobx.setCurrentPassword(val);
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
                          regex.hasMatch(val.substring(val.lastIndexOf(" ") + 1,
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
                      fnCurrentPassword.unfocus();
                      FocusScope.of(context).requestFocus(fnNewPassword);
                    },
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: settingsMobx.hideCurrentPassword,
                    decoration: InputDecoration(
                      hintText: "${S.of(context).currentPassword}",
                      hintStyle: TextStyle(
                        color: Color(0xffc4c4c4),
                        fontSize: 13,
                        letterSpacing: 0.65,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          settingsMobx.setHideCurrentPassword(
                              !settingsMobx.hideCurrentPassword);
                        },
                        icon: Icon(
                          settingsMobx.hideCurrentPassword
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
                  width: size.width / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xcc292929),
                  ),
                  child: TextFormField(
                    cursorColor: Color(0xffe5003a),
                    focusNode: fnNewPassword,
                    validator: (value) =>
                        Validations.validatePassword(value, context),
                    textDirection: textDirection3,
                    onChanged: (val) {
                      RegExp regex = new RegExp("[a-zA-Z]");
                      settingsMobx.setNewPassword(val);
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
                          regex.hasMatch(val.substring(val.lastIndexOf(" ") + 1,
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
                      fnNewPassword.unfocus();
                      FocusScope.of(context).requestFocus(fnConfirmNewPassword);
                    },
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: settingsMobx.hideNewPassword,
                    decoration: InputDecoration(
                      hintText: "${S.of(context).newPassword}",
                      hintStyle: TextStyle(
                        color: Color(0xffc4c4c4),
                        fontSize: 13,
                        letterSpacing: 0.65,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          settingsMobx.setHideNewPassword(
                              !settingsMobx.hideNewPassword);
                        },
                        icon: Icon(
                          settingsMobx.hideNewPassword
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
                  width: size.width / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xcc292929),
                  ),
                  child: TextFormField(
                    cursorColor: Color(0xffe5003a),
                    focusNode: fnConfirmNewPassword,
                    validator: (value) => Validations.validateConfirmPassword(
                        value, settingsMobx.newPassword ?? "", context),
                    textDirection: textDirection4,
                    onChanged: (val) {
                      RegExp regex = new RegExp("[a-zA-Z]");
                      settingsMobx.setConfirmNewPassword(val);
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
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (String term) async {
                      var success = await settingsMobx.changePassword(context);
                      if (success) Navigator.pop(context);
                    },
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: settingsMobx.hideConfirmNewPassword,
                    decoration: InputDecoration(
                      hintText: "${S.of(context).retypeNewPassword}",
                      hintStyle: TextStyle(
                        color: Color(0xffc4c4c4),
                        fontSize: 13,
                        letterSpacing: 0.65,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          settingsMobx.setHideConfirmNewPassword(
                              !settingsMobx.hideConfirmNewPassword);
                        },
                        icon: Icon(
                          settingsMobx.hideConfirmNewPassword
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
              ],
            ),
          ),
          bottomNavigationBar: NavigationRow(
            currentIndex: 5,
          ),
        ),
      ),
    );
  }
}

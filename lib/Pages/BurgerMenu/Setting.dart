import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Models/account.dart';
import 'package:hilike/Models/app.dart';
import 'package:hilike/Networking/Mobx/settings_mobx.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Widget/Appbar60.dart';
import 'package:hilike/Widget/Navigation.dart';
import 'package:hilike/Widget/SwitchRow.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> with AfterLayoutMixin {
  SettingsMobx settingsMobx = SettingsController();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as int;

    Size size = MediaQuery.of(context).size;
    var appModel = Provider.of<AppModel>(context, listen: false);
    return Observer(
      builder: (_) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Appbar60(
            title: S.of(context).setting,
          ),
        ),
        body: ListView(
            padding: EdgeInsets.fromLTRB(20, 26, 20, 0),
            shrinkWrap: true,
            children: [
              SwitchRow(
                title: S.of(context).location,
                text: settingsMobx.locationEnabled
                    ? S.of(context).enabled
                    : S.of(context).disabled,
                value: settingsMobx.share_location == 1 ? true : false,
                onChange: (val) {
                  settingsMobx.setLocationEnabled(context,
                      val: val, fromLocal: false);

                  settingsMobx.share_location == 1
                      ? settingsMobx.setShareLocation(0)
                      : settingsMobx.setShareLocation(1);
                  setState(() {});
                },
              ),
              SizedBox(
                height: size.height / 40,
              ),
              SwitchRow(
                title: S.of(context).showMyAccount,
                text: settingsMobx.accountShowed
                    ? S.of(context).myAccountIsVisibleToEveryone
                    : S.of(context).myAccountIsNotVisibleToEveryone,
                value: settingsMobx.show_account == 1 ? true : false,
                onChange: (val) {
                  settingsMobx.setAccountShowed(context,
                      val: val, fromLocal: false);
                  settingsMobx.show_account == 1
                      ? settingsMobx.setShowAccount(0)
                      : settingsMobx.setShowAccount(1);
                  setState(() {});
                },
              ),
              SizedBox(
                height: arguments == 1 ? 0 : size.height / 25,
              ),
              arguments == 1
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          'changePass',
                          arguments: settingsMobx.email!,
                        );
                      },
                      child: Container(
                        height: size.height / 13.8,
                        width: size.width / 1.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Color(0xfff5f5f5),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            S.of(context).changePassword,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.75,
                            ),
                          ),
                        ),
                      )),
              SizedBox(
                height: size.height / 25,
              ),
              Text(
                S.of(context).notification,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.90,
                ),
              ),
              SizedBox(
                height: size.height / 50,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'editP',
                    );
                  },
                  child: Container(
                    height: size.height / 13.8,
                    width: size.width / 1.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Color(0xfff5f5f5),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        S.of(context).edit,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.75,
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: size.height / 25,
              ),
              Text(
                S.of(context).language,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.90,
                ),
              ),
              SizedBox(
                height: size.height / 50,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await settingsMobx.switchLanguage(context, lang: 'en');
                      settingsMobx.doneChaning == "success"
                          ? await appModel.changeLanguage("en", context)
                          : print("none");

                      setState(() {});
                    },
                    child: Container(
                      width: 51,
                      height: 51,
                      decoration: BoxDecoration(
                        color: appModel.locale == 'ar'
                            ? Color(0x1A1A1A)
                            : Color(0xffe5003a),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: appModel.locale == 'ar'
                              ? Colors.white
                              : Color(0xffe5003a),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "EN",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.50,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await settingsMobx.switchLanguage(context, lang: 'ar');
                      settingsMobx.doneChaning == "success"
                          ? await appModel.changeLanguage("ar", context)
                          : print("none");
                      setState(() {});
                    },
                    child: Container(
                      width: 51,
                      height: 51,
                      decoration: BoxDecoration(
                        color: appModel.locale == 'ar'
                            ? Color(0xffe5003a)
                            : Color(0x1A1A1A),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: appModel.locale == 'ar'
                              ? Color(0xffe5003a)
                              : Colors.white,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "AR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
        bottomNavigationBar: NavigationRow(
          currentIndex: 5,
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // settingsMobx.setLocationEnabled(context,
    //     val: storage.account.locationEnabled ?? true, fromLocal: true);
    // settingsMobx.setAccountShowed(context,
    //     val: storage.account.accountShowed ?? true, fromLocal: true);
    settingsMobx.settingValues(context).then((value) => setState(() {}));
  }
}

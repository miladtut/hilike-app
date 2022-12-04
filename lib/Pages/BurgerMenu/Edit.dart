import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Networking/Mobx/menu_mobx.dart';
import 'package:hilike/Utils/constants.dart';
import 'package:hilike/Widget/Appbar60.dart';
import 'package:hilike/Widget/Navigation.dart';
import 'package:hilike/Widget/SwitchRow.dart';
import 'package:hilike/generated/l10n.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> with AfterLayoutMixin {
  MenuMobx menuMobx = MenuController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(menuMobx.messages);
    return Observer(
      builder: (_) => Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Appbar60(
              title: S.of(context).editNotification,
            ),
          ),
          body: ListView(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              shrinkWrap: true,
              children: [
                SwitchRow(
                  title: S.of(context).messages,
                  text: S.of(context).enableNotificationsForIncomingMessages,
                  onChange: (val) async {
                    menuMobx
                        .editNotificationStatus(context, "messages")
                        .then((value) => setState(() {
                              menuMobx.setMessages(val == true ? "1" : "0");
                            }));
                  },
                  value: menuMobx.messages == "1" ? true : false,
                ),
                SizedBox(
                  height: 15,
                ),
                SwitchRow(
                  title: S.of(context).likes,
                  text: S.of(context).turnOnAlertsWhenYouAreAddedToFavorites,
                  value: menuMobx.likes == "1" ? true : false,
                  onChange: (val) async {
                    menuMobx
                        .editNotificationStatus(context, "likes")
                        .then((value) => setState(() {
                              menuMobx.setLikes(val == true ? "1" : "0");
                            }));
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                SwitchRow(
                  title: S.of(context).MessageSounds,
                  text:
                      S.of(context).enableNotificationsForIncomingMessageSounds,
                  value: menuMobx.nearby == "1" ? true : false,
                  onChange: (val) async {
                    messageSound = val;
                    menuMobx
                        .editNotificationStatus(context, "nearby")
                        .then((value) => setState(() {
                              menuMobx.setNearby(val == true ? "1" : "0");
                            }));
                  },
                ),
              ]),
          bottomNavigationBar: NavigationRow(
            currentIndex: 5,
          )),
    );
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    await menuMobx.getEditNotificationStatus(context);
    setState(() {});
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hilike/Models/app.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Utils/constants.dart';

import '../extensions.dart';

class LocalNotificationService {
  static RemoteMessage? msg;
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? message) async {
      if (message != null) {
        //   print("********1 :${message}");
        //   print("********2 :${msg!.data}");
        //   if (msg!.data["plan_id"] == "5") {
        //     Navigator.pushNamed(App.materialKey!.currentContext!, "Steam",
        //         arguments: [0, storage.account.plan]);
        //   } else if (msg!.data["chat_thread"] == null) {
        //     Navigator.pushNamed(App.materialKey!.currentContext!, 'liked');
        //   } else {
        //     Navigator.pushNamed(App.materialKey!.currentContext!, 'chat',
        //         arguments: [
        //           msg!.data["nickname"],
        //           msg!.data["image"].toString().contains("http")
        //               ? msg!.data["image"].toString()
        //               : msg!.data["plan_id"] == "4"
        //                   ? logo
        //                   : storage.account.isMale == true
        //                       ? imgFemalePlaceholder
        //                       : imgMalePlaceholder,
        //           msg!.data["user_id"],
        //           msg!.data["chat_thread"],
        //           0,
        //           msg!.data["plan_id"] == "2"
        //               ? "Gold"
        //               : msg!.data["plan_id"] == "3"
        //                   ? "Vip"
        //                   : msg!.data["plan_id"] == "4"
        //                       ? "admin"
        //                       : "free",
        //           0
        //         ]);
        //   }
      }
    });
  }

  static void display(
    RemoteMessage message,
  ) async {
    try {
      // final MyController controller = Get.find<MyController>();
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      // controller.deccrement();
      final NotificationDetails notificationDetails = NotificationDetails(
        android:
            AndroidNotificationDetails("easyapproach", "easyapproach channel",
                // "this is our channel",
                importance: Importance.max,
                enableVibration: true,
                enableLights: true,
                showWhen: true,
                showProgress: true,
                // largeIcon:  AndroidBitmap.,
                icon: "@mipmap/launcher_icon",
                priority: Priority.max,
                // sound: RawResourceAndroidNotificationSound("notification"),
                playSound: true),
      );
      // msg = message;
      // await _notificationsPlugin.show(
      //   id,
      //   message.notification!.title,
      //   message.notification!.body,
      //   notificationDetails,
      //   payload: message.data["msg"],
      // );

      print("sound: ${message.notification!.android!.sound}");
      showTopSnackBarNotification(message.notification!.body!,
          message.notification!.title!, message.data);
    } on Exception catch (e) {
      print(e);
    }
  }
}

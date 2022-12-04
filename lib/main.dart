import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hilike/Models/chat_listner.dart';
import 'package:hilike/Utils/constants.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:hilike/Widget/Navigation.dart';
import 'Networking/Firebase/FirebaseApi.dart';
import 'Networking/Mobx/profile_mobx.dart';
import 'Networking/Mobx/user_mobx.dart';
import 'Networking/local_notification_service.dart';
import 'Pages/BurgerMenu/Blocked.dart';
import 'Pages/BurgerMenu/Edit.dart';
import 'Pages/BurgerMenu/Setting.dart';
import 'Pages/BurgerMenu/SupportTeam Without login.dart';
import 'Pages/Chat/Chat.dart';
import 'Pages/InitialPages/BlackScreen.dart';
import 'Pages/InitialPages/Help.dart';
import 'Pages/Payment/Gift1.dart';
import 'Pages/Payment/Gift2.dart';
import 'Pages/Payment/GiftSeeall.dart';
import 'Pages/Payment/Paymentmethods.dart';
import 'Pages/Payment/Upgrade.dart';
import 'Pages/Registration/Registration.dart';
import 'Pages/userpages/Report.dart';
import 'Pages/InitialPages/splashscreen.dart';
import 'Pages/userpages/UserSeeAll.dart';
import 'Pages/userpages/pressedphoto.dart';
import 'Pages/userpages/pressuser.dart';
import 'extensions.dart';
import 'package:provider/provider.dart';
import 'Models/app.dart';
import 'Pages/BurgerMenu/AboutUs.dart';
import 'Pages/BurgerMenu/ChangePassword.dart';
import 'Pages/BurgerMenu/Menu.dart';
import 'Pages/BurgerMenu/MyLikes.dart';
import 'Pages/BurgerMenu/SupportTeam.dart';
import 'Pages/BurgerMenu/UsagePolicy.dart';
import 'Pages/ForgotPass/After_forget_pass.dart';
import 'Pages/ForgotPass/Forgot_pass.dart';
import 'Pages/ForgotPass/Verification.dart';
import 'Pages/ForgotPass/Verification2.dart';
import 'Pages/ForgotPass/Verification3.dart';
import 'Pages/InitialPages/Choose_gender.dart';
import 'Pages/InitialPages/Login.dart';
import 'Pages/InitialPages/Welcome.dart';
import 'Pages/MainPages/LikedYou.dart';
import 'Pages/MainPages/MainMenu.dart';
import 'Pages/MainPages/Messages.dart';
import 'Pages/MainPages/Profile.dart';
import 'Pages/Registration/Registration2.dart';
import 'Pages/Registration/Registration3.dart';
import 'Pages/userpages/EditProfile.dart';
import 'Pages/userpages/SearchResults.dart';
import 'Pages/userpages/StandartFilters.dart';
import 'Storage/Storage.dart';
import 'generated/l10n.dart' as ss;
import 'package:flutter/cupertino.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print(message.data.toString());
  print(message.notification!.title);
  FirebaseApi.updateMessageStatussss(message.data["messagedoc"], "delivered");
  if (Platform.isIOS) {
    FirebaseApi.badgeMessageCount()
        .then((value) => FlutterAppBadger.updateBadgeCount(value));
  }
  // await FirebaseApi.updateMessageCounter();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  storage.getPreferences().then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final _app = AppModel();
  final navigatorKey = GlobalKey<NavigatorState>();
  ChatListner chatListner = ChatListner();

  @override
  void initState() {
    if (Platform.isIOS) {
      FirebaseApi.badgeMessageCount()
          .then((value) => FlutterAppBadger.updateBadgeCount(value));
    }
    // FirebaseApi.badgeMessageCount().then((value) => FlutterAppBadger.updateBadgeCount(value));
    // print("done :${FirebaseApi.badgeMessageCount()}");
    // print("done :${FirebaseApi.x}");

    FirebaseMessaging.instance
        .requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        )
        .then((value) => print(value.authorizationStatus));
    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (Platform.isIOS) {
        FirebaseApi.badgeMessageCount()
            .then((value) => FlutterAppBadger.updateBadgeCount(value));
      }
      if (message != null) {
        // final routeFromMessage = message.data["route"];
        FirebaseApi.updateMessageStatussss(
            message.data["messagedoc"], "delivered");
        // FirebaseApi.updateMessageCounter();
        print("there is new msg3");
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) async {
      if (Platform.isIOS) {
        FirebaseApi.badgeMessageCount()
            .then((value) => FlutterAppBadger.updateBadgeCount(value));
      }
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
        print(message.data);
        // controller.increment();
      }

      // FirebaseApi.updateAllMessageStatus();
      if (message.data["chat_thread"] != chatListner.openChatThread ||
          message.data["chat_thread"] == null) {
        print("isopen: ${chatListner.isOpen}");
        LocalNotificationService.display(message);
      } else {
        print("withnoView");
        messageSound
            ? AudioPlayer()
                .play("https://hilike-chat.com/public/notification.mp3")
            : print("withnoView");
      }
      await FirebaseApi.updateMessageStatussss(
          message.data["messagedoc"], "delivered");
      // await FirebaseApi.updateMessageCounter();
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      if (message.data["plan_id"] == "5") {
        Navigator.pushNamed(App.materialKey!.currentContext!, "Steam",
            arguments: [0, storage.account.plan]);
      } else if (message.data["chat_thread"] == null) {
        Navigator.pushNamed(App.materialKey!.currentContext!, 'liked');
      } else {
        Navigator.pushNamed(App.materialKey!.currentContext!, 'chat',
            arguments: [
              message.data["nickname"],
              message.data["image"].toString().contains("http")
                  ? message.data["image"].toString()
                  : message.data["plan_id"] == "4"
                      ? logo
                      : storage.account.isMale == true
                          ? imgFemalePlaceholder
                          : imgMalePlaceholder,
              message.data["user_id"],
              message.data["chat_thread"],
              0,
              message.data["plan_id"] == "2"
                  ? "Gold"
                  : message.data["plan_id"] == "3"
                      ? "Vip"
                      : message.data["plan_id"] == "4"
                          ? "admin"
                          : "free",
              0
            ]);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<AppModel>(context).getConfig12();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => chatListner,
        ),
      ],
      child: Consumer<AppModel>(
        builder: (context, value, child) {
          Provider.of<AppModel>(context).getConfig();
          return MaterialApp(
            navigatorKey: App.materialKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                backgroundColor: Color(0xff292929),
                scaffoldBackgroundColor: const Color(0xff1a1a1a),
                appBarTheme: AppBarTheme.of(context).copyWith(
                  backwardsCompatibility: false,
                  systemOverlayStyle:
                      SystemUiOverlayStyle(statusBarColor: Color(0xff292929)),
                )),
            locale: Locale(Provider.of<AppModel>(context).locale),
            localizationsDelegates: const [
              ss.S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            supportedLocales: ss.S.delegate.supportedLocales,
            initialRoute: '/',
            routes: {
              '/': (context) => Splash(),
              'gender': (context) => ChooseGender(),
              'usage policy': (context) => Usagepolicy(),
              'help': (context) => Help(),
              'welcome': (context) => Welcome(),
              'p&p': (context) => SupportTeamWithoutLogin(),
              'login': (context) => Login(),
              'register': (context) => Registration(),
              'register2': (context) => Registration2(),
              'register3': (context) => Registration3(),
              'forgetpass': (context) => Forgotpass(),
              'verification': (context) => Verification(isFromSignup: true),
              'verification2': (context) =>
                  Verification2(isFromSignup: true, code: ""),
              'verification3': (context) => Verification3(isFromSignup: true),
              'afterpass': (context) => AfterPass(code: ""),
              'useeall': (context) => Userseeall(from: ComesFrom.Vip),
              'edit': (context) =>
                  EditProfile(profileMobx: ProfileController()),
              'Bmenu': (context) => Menu(),
              'Steam': (context) => SupportTeam(),
              'upgrade': (context) => Upgrade(),
              // 'webview': (context) => WebViewContainer(),
              'black': (context) => BlackScreen(),
              'pay': (context) => PaymentMethod(),
              'gseeall': (context) => GiftSeeall(),
              'chat': (context) => Chat(),
              'liked': (context) => Likedyou(),
              'messages': (context) => Messages(),
              'profile': (context) => Profile(),
              'mainmenu': (context) => Mainmenu(),
              'menu': (context) => Menu(),
              'blocked': (context) => Blocked(),
              'mylikes': (context) => MyLikes(),
              'setting': (context) => Setting(),

              'us': (context) => Aboutus(),
              'policy': (context) => Usagepolicy(),
              'changePass': (context) => Changepassword(),
              'editP': (context) => Edit(),
              'search': (context) => StandartFilters(),
              'searchR': (context) => Searchresults(),
              'report': (context) => Report(
                    userMobx: UserController(),
                  ),
              'Puser': (context) => Pressuser(userId: 0),
              'Pphoto': (context) => Pressedphoto(userMobx: UserController()),
              'G1': (context) => Gifts1(),
              'G2': (context) => Gifts2(),
            },
          );
        },
      ),
    );
  }
}

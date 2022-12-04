import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hilike/Models/gift.dart';
import 'package:hilike/Models/gift_category.dart';
import 'package:hilike/Pages/InitialPages/Welcome.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Widget/CustomDialogBan.dart';
import 'package:hilike/Widget/looding.dart';
import 'package:hilike/extensions.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/src/extensions/widget_extensions.dart';
import 'package:quiver/iterables.dart';

import '../../Utils/constants.dart';
import 'login_mobx.dart';

part 'gifts_mobx.g.dart';

class GiftsController = GiftsMobx with _$GiftsController;

abstract class GiftsMobx with Store {
  ObservableList<GiftModel> gifts = ObservableList<GiftModel>.of([]);
  ObservableList<GiftCategoryModel> giftCategories =
      ObservableList<GiftCategoryModel>.of([]);
  ObservableList<GiftCategoryPartitioned> giftCategoryPartitioned =
      ObservableList<GiftCategoryPartitioned>.of([]);

  @observable
  bool expanded = false;
  @observable
  int currentPage = 0;
  @observable
  int selectedCategory = 0;
  @observable
  GiftModel? clickedGift;
  @observable
  bool online = false;
  @action
  void setExpanded(val) {
    expanded = val;
  }

  @observable
  bool is_blocked = false;
  @action
  void setIsBlocked(val) {
    is_blocked = val;
  }

  @observable
  bool show_unblock = false;
  @action
  void setShowUnblock(val) {
    show_unblock = val;
  }

  @action
  void setOnline(val) {
    online = val;
  }

  @action
  void setCurrentPage(val) {
    currentPage = val;
  }

  @action
  void setClickedGift(val) {
    clickedGift = val;
  }

  @action
  void setSelectedCategory(val) {
    selectedCategory = val;
  }

  @action
  Future<void> getMyGifts(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "my_received_gifts";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n headers: ${headers.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url, headers: headers);
      if (isNavOpen == false) {
        isNavOpen = true;
        Navigator.pop(context);
      }
      Navigator.pop(context);
      log("${url.toString()} \n status code: ${response.statusCode} \n response: ${response.body}");
      Map<String, dynamic> jsonResponse = {};
      try {
        jsonResponse = json.decode(response.body);
      } on FormatException catch (e) {
        log("${url.toString()}: parsing json error");
        showTopSnackBar(S.of(context).somethingIsWrong, "assets/img/iii.png");
        log(e.message);
        return;
      }
      if (jsonResponse['status'] == "ban") {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBan(
                text: jsonResponse["message"],
                text2: jsonResponse["expired_at"] ?? "",
              );
            });
        Future.delayed(Duration(seconds: 8), () {
          LoginController().logout(context, onSuccess: () async {
            await FirebaseAuth.instance.signOut();

            storage.clear();
            Welcome().launch(context, isNewTask: true);
          });
        });
      }
      if (jsonResponse['gifts'] != null) {
        for (var item in jsonResponse['gifts']) {
          GiftModel gift = GiftModel.fromJson(item);
          gifts.add(gift);
        }
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> getGiftCategories(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "gifts_with_categories";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n headers: ${headers.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url, headers: headers);
      if (isNavOpen == false) {
        Navigator.pop(context);
        isNavOpen = true;
      }
      Navigator.pop(context);
      log("${url.toString()} \n status code: ${response.statusCode} \n response: ${response.body}");
      Map<String, dynamic> jsonResponse = {};
      try {
        //final String response = await rootBundle.loadString('assets/DemoData/gifts.json');
        jsonResponse = json.decode(response.body);
      } on FormatException catch (e) {
        log("${url.toString()}: parsing json error");
        showTopSnackBar(S.of(context).somethingIsWrong, "assets/img/iii.png");
        log(e.message);
        return;
      }
      if (jsonResponse['status'] == "ban") {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBan(
                text: jsonResponse["message"],
                text2: jsonResponse["expired_at"] ?? "",
              );
            });
        Future.delayed(Duration(seconds: 8), () {
          LoginController().logout(context, onSuccess: () async {
            await FirebaseAuth.instance.signOut();

            storage.clear();
            Welcome().launch(context, isNewTask: true);
          });
        });
      }
      if (jsonResponse['categories'] != null) {
        giftCategories.clear();
        for (var item in jsonResponse['categories']) {
          GiftCategoryModel giftCategory = GiftCategoryModel.fromJson(item);
          giftCategories.add(giftCategory);
          giftCategoryPartitioned.add(GiftCategoryPartitioned(
            id: giftCategory.id,
            name: giftCategory.name,
            giftGroups: partition((giftCategory.gifts ?? []).toList(), 8),
          ));
        }
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> isOnline(BuildContext context, String id) async {
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return Loadoingw();
    //     });

    setShowUnblock(false);
    setIsBlocked(false);

    String api = "is_online/$id";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n headers: ${headers.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url, headers: headers);
      // Navigator.pop(context);
      log("${url.toString()} \n status code: ${response.statusCode} \n response: ${response.body}");
      Map<String, dynamic> jsonResponse = {};
      try {
        //final String response = await rootBundle.loadString('assets/DemoData/gifts.json');
        jsonResponse = json.decode(response.body);
      } on FormatException catch (e) {
        log("${url.toString()}: parsing json error");
        showTopSnackBar(S.of(context).somethingIsWrong, "assets/img/iii.png");
        log(e.message);
        return;
      }

      if (jsonResponse['status'] == "ban") {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBan(
                text: jsonResponse["message"],
                text2: jsonResponse["expired_at"] ?? "",
              );
            });
        Future.delayed(Duration(seconds: 8), () {
          LoginController().logout(context, onSuccess: () async {
            await FirebaseAuth.instance.signOut();

            storage.clear();
            Welcome().launch(context, isNewTask: true);
          });
        });
      }
      if (response.statusCode > 199 && response.statusCode < 300) {
        jsonResponse['online'] == 1 ? setOnline(true) : setOnline(false);
        jsonResponse['is_blocked'] == 1
            ? setIsBlocked(true)
            : setIsBlocked(false);
        jsonResponse['show_unblock'] == 1
            ? setShowUnblock(true)
            : setShowUnblock(false);
        print(show_unblock);
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }
}

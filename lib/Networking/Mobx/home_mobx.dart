import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Models/account.dart';
import 'package:hilike/Pages/ForgotPass/Verification.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Widget/looding.dart';
import 'package:hilike/extensions.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart' as nb;

import '../../Utils/constants.dart';

part 'home_mobx.g.dart';

class HomeController = HomeMobx with _$HomeController;

abstract class HomeMobx with Store {
  ObservableList<AccountModel> vipUsers = ObservableList<AccountModel>.of([]);
  ObservableList<AccountModel> specialUsers =
      ObservableList<AccountModel>.of([]);
  ObservableList<AccountModel> suggestedUsers =
      ObservableList<AccountModel>.of([]);
  ObservableList<AccountModel> newUsers = ObservableList<AccountModel>.of([]);
  ObservableList<AccountModel> likedYouUsers =
      ObservableList<AccountModel>.of([]);
  @observable
  int? profileProgress;
  @observable
  String? message;
  @observable
  bool? isban;
  @observable
  String? expired;
  @action
  void setMessage(val) {
    message = val;
  }

  @observable
  String? welcomeMessage;
  @action
  void setWelcomeMessage(val) {
    welcomeMessage = val;
  }

  @action
  void setIsban(val) {
    isban = val;
  }

  @action
  void setExpired(val) {
    expired = val;
  }

  @action
  Future<void> getEditNotificationStatus(BuildContext context) async {
    String api = "edit_notifications";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n headers: ${headers.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url, headers: headers);

      log("${url.toString()} \n status code: ${response.statusCode} \n response: ${response.body}");
      Map<String, dynamic> jsonResponse = {};
      try {
        jsonResponse = json.decode(response.body);
      } on FormatException catch (e) {
        log("${url.toString()}: parsing json error");
        log(e.message);
        return;
      }
      if (jsonResponse['messages'] != null) {
        messageSound = jsonResponse['nearby'].toString() == "1";
      }
    } finally {}
  }

  @action
  Future<void> getHome(BuildContext context, {double lat = 0.0, double long = 0.0}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "home?lat=" + '$lat' + '&long=' + '$long';
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
      if (jsonResponse["status"] == "ban") {
        setIsban(true);
        setMessage(jsonResponse["message"]);
        setExpired(jsonResponse["expired_at"] ?? "");
      } else {
        setIsban(false);
        if (jsonResponse['vip'] != null) {
          vipUsers.clear();
          for (var item in jsonResponse['vip']) {
            AccountModel user = AccountModel().fromJson(item);
            vipUsers.add(user);
          }
        }
        if (jsonResponse['special_people'] != null) {
          specialUsers.clear();
          for (var item in jsonResponse['special_people']) {
            AccountModel user = AccountModel().fromJson(item);
            specialUsers.add(user);
          }
        }
        if (jsonResponse['interested_in'] != null) {
          suggestedUsers.clear();
          for (var item in jsonResponse['interested_in']) {
            AccountModel user = AccountModel().fromJson(item);
            suggestedUsers.add(user);
          }
        }
        if (jsonResponse['new_people'] != null) {
          newUsers.clear();
          for (var item in jsonResponse['new_people']) {
            AccountModel user = AccountModel().fromJson(item);
            newUsers.add(user);
          }
        }
        if (jsonResponse['liked_you'] != null) {
          likedYouUsers.clear();
          for (var item in jsonResponse['liked_you']) {
            AccountModel user = AccountModel().fromJson(item);
            likedYouUsers.add(user);
          }
        }
        if (jsonResponse['welcome_message'] != null) {
          setWelcomeMessage(jsonResponse['welcome_message']);
        } else {
          setWelcomeMessage("");
        }
        if (jsonResponse['error'] != null && response.statusCode == 401) {
          nb.toast("Unauthenticated");
          storage.clear();
          Navigator.of(context).pushNamedAndRemoveUntil(
              'login', (Route<dynamic> route) => false);
        }
        profileProgress = jsonResponse['profile_progress'];
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }
}

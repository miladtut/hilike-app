import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Models/account.dart';
import 'package:hilike/Pages/InitialPages/Welcome.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Widget/CustomDialogBan.dart';
import 'package:hilike/Widget/looding.dart';
import 'package:hilike/extensions.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart' as nb;

import '../../Utils/constants.dart';
import 'login_mobx.dart';

part 'see_all_mobx.g.dart';

class SeeAllController = SeeAllMobx with _$SeeAllController;

abstract class SeeAllMobx with Store {
  ObservableList<AccountModel> users = ObservableList<AccountModel>.of([]);

  @action
  Future<void> getVip(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "see_all_vip";
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
      if (jsonResponse['vip'] != null) {
        for (var item in jsonResponse['vip']) {
          AccountModel user = AccountModel().fromJson(item);
          users.add(user);
        }
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
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> getSpecialPeople(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "see_all_special_people";
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
      if (jsonResponse['special_people'] != null) {
        for (var item in jsonResponse['special_people']) {
          AccountModel user = AccountModel().fromJson(item);
          users.add(user);
        }
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
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> getNewPeople(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "see_all_new_people";
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
      if (jsonResponse['new_people'] != null) {
        for (var item in jsonResponse['new_people']) {
          AccountModel user = AccountModel().fromJson(item);
          users.add(user);
        }
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
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> getLikedYou(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "liked_you";
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
      if (jsonResponse['users'] != null) {
        for (var item in jsonResponse['users']) {
          AccountModel user = AccountModel().fromJson(item);
          users.add(user);
        }
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
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }
}

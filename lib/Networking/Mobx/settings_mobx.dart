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
import 'package:nb_utils/src/extensions/widget_extensions.dart';

import '../../Utils/constants.dart';
import 'login_mobx.dart';

part 'settings_mobx.g.dart';

class SettingsController = SettingsMobx with _$SettingsController;

abstract class SettingsMobx with Store {
  @observable
  bool locationEnabled = true;
  @observable
  bool accountShowed = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @observable
  String? email;
  @observable
  String? username;
  @observable
  String? currentPassword;
  @observable
  String? newPassword;
  @observable
  String? confirmNewPassword;
  @observable
  bool hideCurrentPassword = true;
  @observable
  bool hideNewPassword = true;
  @observable
  bool hideConfirmNewPassword = true;
  @observable
  int? share_location;
  @observable
  int? show_account;

  @observable
  String? doneChaning;

  @action
  void setIsChanged(val) {
    doneChaning = val;
  }

  @action
  void setShareLocation(val) {
    share_location = val;
  }

  @action
  void setShowAccount(val) {
    show_account = val;
  }

  @action
  Future<void> setLocationEnabled(BuildContext context,
      {bool val = true, bool fromLocal = true}) async {
    if (fromLocal) {
      locationEnabled = val;
    } else {
      bool success = await enableLocation(context, enable: val);
      if (success) {
        AccountModel account = storage.account;
        account.locationEnabled = val;
        storage.account = account;
        locationEnabled = val;
      }
    }
  }

  @action
  Future<void> setAccountShowed(BuildContext context,
      {bool val = true, bool fromLocal = true}) async {
    if (fromLocal) {
      accountShowed = val;
    } else {
      bool success = await showAccount(context, enable: val);
      if (success) {
        AccountModel account = storage.account;
        account.accountShowed = val;
        storage.account = account;
        accountShowed = val;
      }
    }
  }

  @action
  void setEmail(val) {
    email = val;
  }

  @action
  void setUsername(val) {
    username = val;
  }

  @action
  void setCurrentPassword(val) {
    currentPassword = val;
  }

  @action
  void setNewPassword(val) {
    newPassword = val;
  }

  @action
  void setConfirmNewPassword(val) {
    confirmNewPassword = val;
  }

  @action
  void setHideCurrentPassword(val) {
    hideCurrentPassword = val;
  }

  @action
  void setHideNewPassword(val) {
    hideNewPassword = val;
  }

  @action
  void setHideConfirmNewPassword(val) {
    hideConfirmNewPassword = val;
  }

  @action
  Future<void> settingValues(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "get_location";
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
      if (response.statusCode > 199 && response.statusCode < 300) {
        setShowAccount(jsonResponse['show_account']);
        setShareLocation(jsonResponse['share_location']);
        setEmail(jsonResponse['email']);
        print(email);
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
  Future<bool> enableLocation(BuildContext context,
      {bool enable = true}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "enable_location/${enable ? 'on' : 'off'}";
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

      if (response.statusCode > 199 && response.statusCode < 300) {
        return true;
      }
      showTopSnackBar(S.of(context).somethingIsWrong, "assets/img/iii.png");
      log(response.body);
      return false;
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return false;
    }
  }

  @action
  Future<bool> showAccount(BuildContext context, {bool enable = true}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "show_account/${enable ? 'on' : 'off'}";
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

      if (response.statusCode > 199 && response.statusCode < 300) {
        return true;
      }
      showTopSnackBar(S.of(context).somethingIsWrong, "assets/img/iii.png");
      log(response.body);
      return false;
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return false;
    }
  }

  @action
  Future<void> switchLanguage(BuildContext context,
      {String lang = "ar"}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "switch_language/$lang";
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
      if (response.statusCode > 199 && response.statusCode < 300) {
        setIsChanged(jsonResponse['status']);
        print("res is ${jsonResponse['status']}");
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<bool> changePassword(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return false;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "change_password";
    String method = "POST";

    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    Map<String, dynamic> body = {
      'email': email,
      // 'username': username,
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': confirmNewPassword,
    };

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n body: ${body.toString()} \n headers: ${headers.toString()}");
    try {
      final client = http.Client();
      var response = await client.post(url, body: body, headers: headers);
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
        return false;
      }
      if (response.statusCode > 199 && response.statusCode < 300) {
        if (jsonResponse['status'] != null &&
            jsonResponse['status'] != "success") {
          showTopSnackBar(jsonResponse['error'], "assets/img/iii.png");
          return false;
        }
        return true;
      }
      showTopSnackBar(S.of(context).somethingIsWrong, "assets/img/iii.png");
      log(response.body);
      return false;
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return false;
    }
  }
}

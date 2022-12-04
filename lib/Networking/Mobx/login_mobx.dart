import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Models/account.dart';
import 'package:hilike/Networking/Firebase/FirebaseApi.dart';
import 'package:hilike/Pages/ForgotPass/Verification.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Widget/looding.dart';
import 'package:hilike/extensions.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart' as nb;

import '../../Utils/constants.dart';

part 'login_mobx.g.dart';

class LoginController = LoginMobx with _$LoginController;

abstract class LoginMobx with Store {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @observable
  String? email;
  @observable
  String? device_token;
  @observable
  String? password;
  @observable
  bool hidePassword = true;

  @action
  void setEmail(val) {
    email = val;
  }

  @action
  void setPassword(val) {
    password = val;
  }

  @action
  void setDeviceToken(val) {
    device_token = val;
  }

  @action
  void setHidePassword(val) {
    hidePassword = val;
  }

  @action
  Future<void> login(BuildContext context, {Function? onSuccess}) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "auth/login";
    String method = "POST";
    //String token = "Bearer ${storage.account.apiToken}";
    Map<String, dynamic> body = {
      'email': email,
      'password': password,
      "device_token": device_token,
      'language':
          Localizations.localeOf(context).languageCode.toString() == "ar"
              ? 'ar'
              : "en"
    };

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n body: ${body.toString()}");
    try {
      final client = http.Client();
      var response = await client.post(url, body: body);
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
      if (jsonResponse['data'] != null) {
        AccountModel user =
            AccountModel().fromJson(jsonResponse['data']['user']);
        user.apiToken = jsonResponse['data']['token'];
        user.isLoggedIn = true;
        storage.account = user;

        if (onSuccess != null) {
          await onSuccess();
        }
      } else if (jsonResponse['status'] != null &&
          jsonResponse['status'] == "error") {
        showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
      } else if (jsonResponse['status'] == "ban") {
        showTopSnackBar(
            jsonResponse['message'] +
                "\n \n" +
                (jsonResponse['expired_at'] ?? ""),
            "assets/img/iii.png");
      } else if (jsonResponse['status'] == "block") {
        showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
      } else if (jsonResponse['status'] == "verify") {
        showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
        Verification(email: email, isFromSignup: true).launch(context);
      } else if (jsonResponse['status'] != null &&
          jsonResponse['status'] == "verify") {
        Verification(email: email, isFromSignup: true).launch(context);
      } else {
        showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> logout(BuildContext context, {Function? onSuccess}) async {
    showDialog(
        context: context,
        routeSettings: RouteSettings(name: "Loadoing"),
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "auth/logout";
    String method = "POST";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n headers: ${headers.toString()}");
    try {
      await FirebaseApi.deleteToken();
      await FirebaseAuth.instance.signOut();
      final client = http.Client();
      var response = await client.post(url, headers: headers);
      Navigator.pop(context);
      log("${url.toString()} \n status code: ${response.statusCode} \n response: ${response.body}");
      Map<String, dynamic> jsonResponse = {};
      try {
        jsonResponse = json.decode(response.body);
      } on FormatException catch (e) {
        log("${url.toString()}: parsing json error");
        showTopSnackBar(S.of(context).somethingIsWrong, "assets/img/iii.png");
        log(e.message);
        if (onSuccess != null) {
          await onSuccess();
          showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
        }
        return;
      }
      if (jsonResponse['status'] != null) {
        if (jsonResponse['status'] != "success") {
          showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
        }
      } else {
        showTopSnackBar("Something went wrong (${response.statusCode})",
            "assets/img/iii.png");
      }
      if (onSuccess != null) {
        await onSuccess();
        showTopSnackBar(jsonResponse['message'], "assets/img/check.png");
      }
    } on SocketException {
      Navigator.pop(context, "Loadoing");
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      if (onSuccess != null) {
        await onSuccess();
        showTopSnackBar(S.of(context).Signedout, "assets/img/iii.png");
      }
      return;
    }
  }
}

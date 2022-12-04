import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Models/account.dart';
import 'package:hilike/Pages/ForgotPass/Verification.dart';
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

part 'forgot_password_mobx.g.dart';

class ForgotPasswordController = ForgotPasswordMobx
    with _$ForgotPasswordController;

abstract class ForgotPasswordMobx with Store {
  @action
  Future<void> forgotPassword(
    BuildContext context, {
    required String email,
    Function? onSuccess,
  }) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "auth/forgot";
    String method = "POST";
    //String token = "Bearer ${storage.account.apiToken}";
    Map<String, dynamic> body = {
      'email': email,
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
      if (jsonResponse['status'] != null) {
        if (jsonResponse['status'] != 'success')
          showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
        if (onSuccess != null && jsonResponse['status'] == "success") {
          onSuccess();
        }
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> resetPassword(BuildContext context,
      {required String password,
      required String code,
      Function? onSuccess}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "auth/reset";
    String method = "POST";
    //String token = "Bearer ${storage.account.apiToken}";
    Map<String, dynamic> body = {
      'password': password,
      'password_confirmation': password,
      'token': code,
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
      if (jsonResponse['data'] != null) {
        AccountModel user =
            AccountModel().fromJson(jsonResponse['data']['user']);
        user.apiToken = jsonResponse['data']['token'];
        user.isLoggedIn = true;
        storage.account = user;
        if (onSuccess != null) onSuccess();
      } else if (jsonResponse['status'] != null &&
          jsonResponse['status'] != "success") {
        showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> verifyCode(BuildContext context,
      {String code = '0', Function? onSuccess, Function? onError}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "auth/reset/" + code;
    String method = "Get";
    // String token = "Bearer ${storage.account.apiToken}";
    // Map<String, dynamic> body = {};

    final Uri url = Uri.parse(baseUrl + api);
    //log("$method -> ${url.toString()} \n token: $token \n body: ${body.toString()}");
    log("$method -> ${url.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url);
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
      if (jsonResponse['status'] != null &&
          jsonResponse['status'] == "success") {
        if (onSuccess != null) onSuccess();
      } else if (jsonResponse['status'] != null &&
          jsonResponse['status'] != "success") {
        showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
        if (onError != null) onError();
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }
}

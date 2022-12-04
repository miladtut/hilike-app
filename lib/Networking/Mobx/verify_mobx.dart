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

part 'verify_mobx.g.dart';

class VerifyController = VerifyMobx with _$VerifyController;

abstract class VerifyMobx with Store {
  @action
  Future<void> verify(
    BuildContext context, {
    required String code,
    required String email,
    Function? onSuccess,
    Function? onError,
  }) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "auth/verify";
    String method = "POST";
    //String token = "Bearer ${storage.account.apiToken}";
    Map<String, dynamic> body = {
      'email': email,
      'code': code,
    };

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n body: ${body.toString()}");
    try {
      final client = http.Client();
      var response = await client.post(url, body: body);
      Navigator.pop(context);
      if (isNavOpen == false) {
        Navigator.pop(context);
        isNavOpen = true;
      }
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

  @action
  Future<void> resendCode(BuildContext context,
      {required String email, Function? onSuccess}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "auth/resend_code";
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
      if (isNavOpen == false) {
        Navigator.pop(context);
        isNavOpen = true;
      }
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
      if (jsonResponse['status'] != null) {
        if (jsonResponse['status'] != 'success')
          showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
        if (onSuccess != null && jsonResponse['status'] == "success")
          onSuccess();
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }
}

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Models/onboarding.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Widget/looding.dart';
import 'package:hilike/extensions.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart' as nb;

import '../../Utils/constants.dart';

part 'on_boarding_mobx.g.dart';

class OnBoardingController = OnBoardingMobx with _$OnBoardingController;

abstract class OnBoardingMobx with Store {
  @observable
  List<OnBoardingModel> list = [];

  @action
  clearList() {
    list.clear();
  }

  @action
  Future<void> getOnBoarding(BuildContext context, String lang) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "onboarding/" + lang;
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
      var jsonResponse = [];
      try {
        jsonResponse = json.decode(response.body);
      } on FormatException catch (e) {
        log("${url.toString()}: parsing json error");
        showTopSnackBar(S.of(context).somethingIsWrong, "assets/img/iii.png");
        log(e.message);
        return;
      }
      List<OnBoardingModel> list = [];
      for (var item in jsonResponse) {
        OnBoardingModel onBoarding = OnBoardingModel.fromJson(item);
        list.add(onBoarding);
      }
      this.list = list;
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }
}

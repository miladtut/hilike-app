import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Models/coins.dart';
import 'package:hilike/Models/plan.dart';
import 'package:hilike/Models/plan_package.dart';
import 'package:hilike/Pages/Payment/WebviewPage.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Widget/looding.dart';
import 'package:hilike/extensions.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart' as nb;

import '../../Utils/constants.dart';

part 'plans_mobx.g.dart';

class PlansController = PlansMobx with _$PlansController;

abstract class PlansMobx with Store {
  ObservableList<PlanModel> plans = ObservableList<PlanModel>.of([]);
  ObservableList<CoinsModel> coins = ObservableList<CoinsModel>.of([]);
  @observable
  int pageIndex = 0;
  @observable
  String isfreeTrial = "5";
  @observable
  int selectedIndex = 0;
  @observable
  int? balance = 0;
  @observable
  String? purl = "";
  @observable
  bool? freeTrialRes = false;

  @observable
  var ApplePay;

  @observable
  bool? reqestApi = false;
  @action
  setReqestApi(val) {
    reqestApi = val;
  }

  @observable
  bool? canpay;
  @action
  setCanPay(val) {
    canpay = val;
  }

  @action
  setApplePay(val) {
    ApplePay = val;
  }

  @action
  setPageIndex(val) {
    pageIndex = val;
  }

  @action
  setFreeTrialval(val) {
    isfreeTrial = val;
  }

  @action
  setFreeTrialonRes(val) {
    freeTrialRes = val;
  }

  @action
  setSelectedIndex(val) {
    selectedIndex = val;
  }

  @action
  Future<void> getPlans(BuildContext context) async {
    // showLoading(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });
    Loadoingw();
    String api = "plans";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};
    /*String token = "Bearer ${storage.account.apiToken}";
    var headers = {
      'Authorization': token,
      'Accept': 'application/json'
    };*/

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()}");
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
      if (jsonResponse['plans'] != null) {
        setFreeTrialval(jsonResponse['free_trial'].toString());
        plans.clear();
        for (var item in jsonResponse['plans']) {
          PlanModel plan = PlanModel.fromJson(item);
          if (!plan.name!.contains("Free")) {
            plans.add(plan);
          }
        }
      }
      /* plans.clear();
      List<PlanPackageModel> packages = [
        PlanPackageModel(id: 1, months: 3, price: 240),
        PlanPackageModel(id: 1, months: 6, price: 420),
      ];
      PlanModel planGold =
          PlanModel(id: 1, price: 100, name: "Gold", packages: packages);
      PlanModel planVip =
      PlanModel(id: 1, price: 100, name: "Vip", packages: packages);
      plans.add(planGold);
      plans.add(planVip);*/

    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> getCoins(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "get_coins";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()}");
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
      if (jsonResponse['coins'] != null) {
        coins.clear();
        for (var item in jsonResponse['coins']) {
          CoinsModel coin = CoinsModel.fromJson(item);
          coins.add(coin);
        }
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> freeTrial(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "free_trial/2";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()}");
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
      if (jsonResponse['status'] != null) {
        setFreeTrialonRes(
            jsonResponse['status'].toString() == "success" ? true : false);
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> sendGift(BuildContext context, int giftId, String userId) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "send_gift/$giftId/$userId";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()}");
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
      if (jsonResponse['coins'] != null) {
        coins.clear();
        for (var item in jsonResponse['coins']) {
          CoinsModel coin = CoinsModel.fromJson(item);
          coins.add(coin);
        }
      }
      if (jsonResponse['status'] != null) {
        jsonResponse['status'] == "success"
            ? setCanPay(true)
            : setCanPay(false);
        coins.clear();
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> getMyBalance(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "get_balance";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()}");
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

      if (jsonResponse['balance'] != null) {
        balance = jsonResponse['balance'];
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> paymentStreb(
      BuildContext context, String id, String methodpay) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "coin_payment_form/$id/$methodpay";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()}");
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

      if (jsonResponse['url'] != null) {
        purl = jsonResponse['url'].toString().replaceAll("\$", "");
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> paymentStrebplan(
      BuildContext context, String id, String methodpay) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "plan_payment_form/$id/$methodpay";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()}");
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

      if (jsonResponse['url'] != null) {
        purl = jsonResponse['url'].toString().replaceAll("\$", "");
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> applePay(
    BuildContext context,
    String id,
  ) async {
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return Loadoingw();
    //     });
    // });

    String api = "is_apple_pay/$id";
    String method = "GET";
    var headers = {'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url, headers: headers);
      // Navigator.pop(context);
      log("${url.toString()} \n status code: ${response.statusCode} \n response: ${response.body}");
      Map<String, dynamic> jsonResponse = {};
      try {
        if (response.statusCode > 199 && response.statusCode < 300)
          setApplePay(response.body);
        // Navigator.pop(context);
      } on FormatException catch (e) {
        log("${url.toString()}: parsing json error");
        showTopSnackBar(S.of(context).somethingIsWrong, "assets/img/iii.png");
        log(e.message);
        return;
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> paymentStrebplanwithPackage(
      BuildContext context, String id, String methodpay, int pid) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "plan_payment_form/$id/$methodpay?package_id=$pid";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url, headers: headers);
      Navigator.pop(context);
      if (isNavOpen == false) {
        isNavOpen = true;

        Navigator.pop(context);
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

      if (jsonResponse['url'] != null) {
        purl = jsonResponse['url'].toString().replaceAll("\$", "");
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }
}

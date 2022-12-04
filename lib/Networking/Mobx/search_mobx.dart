import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Models/account.dart';
import 'package:hilike/Models/country.dart';
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

part 'search_mobx.g.dart';

class SearchController = SearchMobx with _$SearchController;

abstract class SearchMobx with Store {
  ObservableList<AccountModel> vipUsers = ObservableList<AccountModel>.of([]);
  ObservableList<AccountModel> searchFeedsUsers =
      ObservableList<AccountModel>.of([]);
  @observable
  String? query;
  @observable
  int? nearby;
  @observable
  int? online;
  @observable
  int? withImage;
  @observable
  int? sameCountry;
  @observable
  int? minDistance;
  @observable
  int? maxDistance;
  @observable
  int? minAge;
  @observable
  int? maxAge;
  @observable
  int? lastVisit;
  @observable
  CountryModel? originCountry;
  @observable
  CountryModel? residenceCountry;
  @observable
  int? filterMinAge;
  @observable
  int? filterMaxAge;
  @observable
  int? filterMinDistance;
  @observable
  int? filterMaxDistance;
  @observable
  int? filterMinLastVisit;
  @observable
  int? filterMaxLastVisit;
  @observable
  bool? vip;
  @observable
  int limit = 10;
  @observable
  int? offset;
  @observable
  bool loading = false;
  @observable
  bool? likedYou;
  @observable
  String? message;
  @observable
  bool? isban;
  @observable
  String? expired;

  @observable
  int? numberSearch;
  @action
  void setNumberSearch(val) {
    numberSearch = val;
  }

  @action
  void setMessage(val) {
    message = val;
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
  void setQuery(String val) {
    query = val;
  }

  @action
  void setNearby(int val) {
    nearby = val;
  }

  @action
  void setOnline(int val) {
    online = val;
  }

  @action
  void setWithImage(int val) {
    withImage = val;
  }

  @action
  void setSameCountry(int val) {
    sameCountry = val;
  }

  @action
  void setMinDistance(int val) {
    minDistance = val;
  }

  @action
  void setMaxDistance(int val) {
    maxDistance = val;
  }

  @action
  void setMinAge(int val) {
    minAge = val;
  }

  @action
  void setMaxAge(int val) {
    maxAge = val;
  }

  @action
  void setFilterMinAge(int val) {
    filterMinAge = val;
  }

  @action
  void setFilterMaxAge(int val) {
    filterMaxAge = val;
  }

  @action
  void setFilterMinDistance(int val) {
    filterMinDistance = val;
  }

  @action
  void setFilterMaxDistance(int val) {
    filterMaxDistance = val;
  }

  @action
  void setFilterMinLastVisit(int val) {
    filterMinLastVisit = val;
  }

  @action
  void setFilterMaxLastVisit(int val) {
    filterMaxLastVisit = val;
  }

  @action
  void setLastVisit(int val) {
    lastVisit = val;
  }

  @action
  void setOriginCountry(val) {
    originCountry = val;
  }

  @action
  void setResidenceCountry(val) {
    residenceCountry = val;
  }

  @action
  void setVip(val) {
    vip = val;
  }

  @action
  void setOffset(val) {
    offset = val;
  }

  @action
  void clearVip() {
    vipUsers.clear();
  }

  @action
  void clearFeed() {
    searchFeedsUsers.clear();
  }

  @action
  void setLikedYou(val) {
    likedYou = val;
  }

  @action
  void resetFilter() {
    query = null;
    nearby = null;
    online = null;
    withImage = null;
    sameCountry = null;
    minDistance = null;
    maxDistance = null;
    minAge = null;
    maxAge = null;
    lastVisit = null;
    filterMinAge = null;
    filterMaxAge = null;
    filterMinDistance = null;
    filterMaxDistance = null;
    filterMinLastVisit = null;
    filterMaxLastVisit = null;
    originCountry = null;
    residenceCountry = null;
    vip = null;
    offset = null;
    likedYou = null;
  }

  @action
  Future<void> search(BuildContext context, {Function? onSuccess}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });
    String api = "search_results?";
    if (!query.isEmptyOrNull) api += "q=$query&";
    if (nearby != null) api += "nearby=$nearby&";
    if (online != null) api += "online=$online&";
    if (withImage != null) api += "with_image=$withImage&";
    if (sameCountry != null) api += "same_country=$sameCountry&";
    if (minDistance != null) api += "min_distance=$minDistance&";
    if (maxDistance != null) api += "max_distance=$maxDistance&";
    if (minAge != null) api += "min_age=$minAge&";
    if (maxAge != null) api += "max_age=$maxAge&";
    if (lastVisit != null) api += "last_visit=$lastVisit&";
    if (originCountry != null) api += "origin_country=${originCountry!.name}&";
    if (residenceCountry != null)
      api += "residence_country=${residenceCountry!.name}&";
    if (vip != null && vip!) api += "vip=1&";
    api += "limit=$limit&";
    if (offset != null) api += "offset=$offset&";
    if (likedYou != null && likedYou!) api += "liked_you=1&";

    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n headers: ${headers.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url, headers: headers);
      // Navigator.pop(context);
      loading = false;
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
        if (jsonResponse['data'] != null &&
            jsonResponse['data']['vip'] != null) {
          vipUsers.clear();
          for (var item in jsonResponse['data']['vip']) {
            AccountModel user = AccountModel().fromJson(item);
            vipUsers.add(user);
          }
        }
        if (jsonResponse['data'] != null &&
            jsonResponse['data']['search_feeds'] != null) {
          for (var item in jsonResponse['data']['search_feeds']) {
            AccountModel user = AccountModel().fromJson(item);
            searchFeedsUsers.add(user);
          }
          if (isNavOpen == false) {
            isNavOpen = true;

            Navigator.pop(context);
          }
          Navigator.pop(context);
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
        if (jsonResponse['data'] != null && onSuccess != null) onSuccess();
        if (response.statusCode > 199 && response.statusCode < 300) {
          List x = jsonResponse['data']['search_feeds'] ?? [];
          setNumberSearch(x.length);
          print("Search feed num : $numberSearch");
        }
      }

      // Navigator.pop(context);
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> getFilter(BuildContext context, {Function? onSuccess}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "standard_filters";

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
      if (jsonResponse['data'] != null && jsonResponse['data']['age'] != null) {
        filterMinAge = jsonResponse['data']['age']['min'];
        filterMaxAge = jsonResponse['data']['age']['max'];
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
      if (jsonResponse['data'] != null &&
          jsonResponse['data']['distance'] != null) {
        filterMinDistance = jsonResponse['data']['distance']['min'];
        filterMaxDistance = jsonResponse['data']['distance']['max'];
      }
      if (jsonResponse['data'] != null &&
          jsonResponse['data']['last_visit'] != null) {
        filterMinLastVisit = jsonResponse['data']['last_visit']['min'];
        filterMaxLastVisit = jsonResponse['data']['last_visit']['max'];
      }

      if (jsonResponse['data'] != null && onSuccess != null) onSuccess();
    } on SocketException {
      Navigator.pop(context);

      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }
}

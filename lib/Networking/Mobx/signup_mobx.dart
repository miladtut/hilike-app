import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Models/account.dart';
import 'package:hilike/Models/app.dart';
import 'package:hilike/Models/country.dart';
import 'package:hilike/Pages/ForgotPass/Verification.dart';
import 'package:hilike/Pages/Registration/Registration2.dart';
import 'package:hilike/Widget/looding.dart';
import 'package:hilike/extensions.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:hilike/Storage/Storage.dart';

import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../Utils/constants.dart';

part 'signup_mobx.g.dart';

class SignupController = SignupMobx with _$SignupController;

abstract class SignupMobx with Store {
  @observable
  String? username;
  @observable
  String? provider;
  @observable
  String? provider_token;
  @observable
  String? device_token;
  @observable
  String? email;
  @observable
  String? password;
  @observable
  String? confirmPassword;
  @observable
  var profileImage;
  @observable
  String? dob;
  @observable
  CountryModel? originCountry;
  @observable
  CountryModel? residenceCountry;
  @observable
  bool isMale = true;
  @observable
  String? nickname;
  @observable
  bool hidePassword = true;
  @observable
  bool hideConfirmPassword = true;
  @observable
  bool agree = false;
  @observable
  double? latitude;
  @observable
  double? longitude;
  ObservableList<CountryModel> originCountries =
      ObservableList<CountryModel>.of([]);
  ObservableList<CountryModel> residenceCountries =
      ObservableList<CountryModel>.of([]);
  @observable
  String originSearchQuery = "";
  @observable
  String residenceSearchQuery = "";
  @observable
  String? lang;
  Dio dio = new Dio();

  @action
  void setEmail(val) {
    email = val;
  }

  @action
  void setdevicetoken(val) {
    device_token = val;
  }

  @action
  void setProvider(val) {
    provider = val;
  }

  @action
  void setProvidertoken(val) {
    provider_token = val;
  }

  @action
  void setUsername(val) {
    username = val;
  }

  @action
  void setPassword(val) {
    password = val;
  }

  @action
  void setConfirmPassword(val) {
    confirmPassword = val;
  }

  @action
  void setHidePassword(val) {
    hidePassword = val;
  }

  @action
  void setHideConfirmPassword(val) {
    hideConfirmPassword = val;
  }

  @action
  void setProfileImage(val) {
    profileImage = val;
  }

  @action
  void setDob(val) {
    dob = val;
  }

  @action
  void setOriginCountry(val) {
    originCountry = val;
    clearOriginCountries();
  }

  @action
  void setResidenceCountry(val) {
    residenceCountry = val;
    clearResidenceCountries();
  }

  @action
  void setIsMale(val) {
    isMale = val;
  }

  @action
  void setNickname(val) {
    nickname = val;
  }

  @action
  void setAgree(val) {
    agree = val;
  }

  @action
  void setLatitude(val) {
    latitude = val;
  }

  @action
  void setLongitude(val) {
    longitude = val;
  }

  @action
  void setOriginSearchQuery(val) {
    originSearchQuery = val;
    if (originSearchQuery.isNotEmpty) getOriginCountries();
  }

  @action
  void setResidenceSearchQuery(val) {
    residenceSearchQuery = val;
    if (residenceSearchQuery.isNotEmpty) getResidenceCountries();
  }

  @action
  void setLang(val) {
    lang = val;
  }

  @action
  void clearOriginCountries() {
    originCountries.clear();
  }

  @action
  void clearResidenceCountries() {
    residenceCountries.clear();
  }

  @action
  Future<void> signup(BuildContext context, {Function? onSuccess}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "auth/register";
    String method = "POST";

    //String token = "Bearer ${storage.account.apiToken}";

    if (profileImage == null) {
      print("if_profileImage: $profileImage");

      Map<String, dynamic> body = {
        'name': username ?? "",
        'device_token': device_token ?? "",
        'provider': provider ?? "",
        'provider_token': provider_token ?? "",
        'email': email ?? "",
        'password': password ?? "",
        'password_confirmation': confirmPassword ?? "",
        'dob': dob,
        'origin_latitude':
            '${originCountry == null ? 0 : originCountry!.latitude ?? 0}',
        'origin_longitude':
            '${originCountry == null ? 0 : originCountry!.longitude ?? 0}',
        'origin_country_name':
            originCountry == null ? "" : originCountry!.name ?? "",
        'residence_latitude':
            '${residenceCountry == null ? 0 : residenceCountry!.latitude ?? 0}',
        'residence_longitude':
            '${residenceCountry == null ? 0 : residenceCountry!.longitude ?? 0}',
        'residence_country_name':
            residenceCountry == null ? "" : residenceCountry!.name ?? "",
        'gender': isMale ? 'male' : 'female',
        'nickname': nickname,
        'agree': agree ? '1' : '0',
        'latitude': '${0.0}',
        'longitude': '${0.0}',
        'language': Provider.of<AppModel>(context, listen: false).locale,
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
    } else {
      print("else_profileImage: $profileImage");
      final String url = baseUrl + api;
      FormData formData = FormData.fromMap({
        "profile_image": await MultipartFile.fromFile(profileImage!,
            filename: basename(profileImage!)),
        'name': username ?? "",
        'provider': provider ?? "",
        'provider_token': provider_token ?? "",
        'device_token': device_token ?? "",
        'email': email ?? "",
        'password': password ?? "",
        'password_confirmation': confirmPassword ?? "",
        'dob': dob,
        'origin_latitude':
            '${originCountry == null ? 0 : originCountry!.latitude ?? 0}',
        'origin_longitude':
            '${originCountry == null ? 0 : originCountry!.longitude ?? 0}',
        'origin_country_name':
            originCountry == null ? "" : originCountry!.name ?? "",
        'residence_latitude':
            '${residenceCountry == null ? 0 : residenceCountry!.latitude ?? 0}',
        'residence_longitude':
            '${residenceCountry == null ? 0 : residenceCountry!.longitude ?? 0}',
        'residence_country_name':
            residenceCountry == null ? "" : residenceCountry!.name ?? "",
        'gender': isMale ? 'male' : 'female',
        'nickname': nickname,
        'agree': agree ? '1' : '0',
        'latitude': '${0.0}',
        'longitude': '${0.0}',
        'language': Provider.of<AppModel>(context, listen: false).locale,
      });

      var response = await dio.post(
        url,
        data: formData,
        onSendProgress: (int sent, int total) {
          String percentage = (sent / total * 100).toStringAsFixed(2);
          String progress = "$sent" +
              " Bytes of " "$total Bytes - " +
              percentage +
              " % uploaded";
          print(progress);
        },
      );
      Navigator.pop(context);
      if (response.statusCode! > 199 && response.statusCode! < 300) {
        print(response.toString());
        Map<String, dynamic> jsonResponse = {};
        try {
          jsonResponse = json.decode(response.toString());
        } on FormatException catch (e) {
          log("${url.toString()}: parsing json error");
          showTopSnackBar(S.of(context).somethingIsWrong, "assets/img/iii.png");
          log(e.message);
          return;
        }
        if (jsonResponse['data'] != null) {
          if (onSuccess != null) onSuccess();
        } else if (jsonResponse['status'] != null &&
            jsonResponse['status'] != "success") {
          showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
        }
      } else {
        print("Error $url. status code: ${response.statusCode}");
      }
    }
  }

  @action
  Future<void> getOriginCountries() async {
    String method = "GET";
    final Uri url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$originSearchQuery&types=country&language=$lang&key=$GoogleApiKey");
    log("$method -> ${url.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url);
      log("${url.toString()} \n status code: ${response.statusCode} \n response: ${response.body}");
      Map<String, dynamic> jsonResponse = {};
      try {
        jsonResponse = json.decode(response.body);
      } on FormatException catch (e) {
        log("${url.toString()}: parsing json error");
        log(e.message);
        return;
      }
      if (jsonResponse['results'] != null) {
        originCountries.clear();
        List<CountryModel> countries = [];
        for (var result in jsonResponse['results']) {
          CountryModel country = CountryModel(
            id: result['place_id'],
            name: result['name'],
            latitude: result['geometry']['location']['lat'],
            longitude: result['geometry']['location']['lng'],
          );
          countries.add(country);
        }
        originCountries.addAll(countries);
      }
    } on SocketException {
      return;
    }
  }

  @action
  Future<void> getResidenceCountries() async {
    String method = "GET";
    final Uri url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$residenceSearchQuery&types=country&language=$lang&key=$GoogleApiKey");
    log("$method -> ${url.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url);
      log("${url.toString()} \n status code: ${response.statusCode} \n response: ${response.body}");
      Map<String, dynamic> jsonResponse = {};
      try {
        jsonResponse = json.decode(response.body);
      } on FormatException catch (e) {
        log("${url.toString()}: parsing json error");
        log(e.message);
        return;
      }
      if (jsonResponse['results'] != null) {
        residenceCountries.clear();
        List<CountryModel> countries = [];
        for (var result in jsonResponse['results']) {
          CountryModel country = CountryModel(
            id: result['place_id'],
            name: result['name'],
            latitude: result['geometry']['location']['lat'],
            longitude: result['geometry']['location']['lng'],
          );
          countries.add(country);
        }
        residenceCountries.addAll(countries);
      }
    } on SocketException {
      return;
    }
  }

  Future<String?> gettoken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      return token;
    } on Exception catch (e) {
      print("e $e");
      // TODO
    }
  }

  @action
  Future<void> socialLoginnew(
      BuildContext context, String token, String provider,
      {Function? onSuccess}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });
    String? dtokn = await gettoken();

    String api = "auth/social_login/$provider";
    String method = "POST";
    //String token = "Bearer ${storage.account.apiToken}";
    Map<String, dynamic> body = {
      'access_token': token,
      'device_token': dtokn ?? "",
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
      void next() {
        Registration2(
          signupMobx: SignupController(),
          username: username,
          email: email,
          provider: provider,
          provider_token: provider_token,
        ).launch(context);
      }

      if (jsonResponse['status'] == "ban") {
        showTopSnackBar(
            jsonResponse['message'] +
                "\n \n" +
                (jsonResponse['expired_at'] ?? ""),
            "assets/img/iii.png");
      }
      if (jsonResponse['status'] != null) {
        jsonResponse['status'] == "not_found" ? next() : print("object");
        setProvider(provider);
        setProvidertoken(token);
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
        // showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
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
  Future<void> socialLogin(
    BuildContext context,
    String token,
    String provider,
  ) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "auth/social_login/$provider";
    String method = "POST";
    // String token = "Bearer ${storage.account.apiToken}";
    // var headers = {'Authorization': token, 'Accept': 'application/json'};

    Map<String, dynamic> body = {
      'access_token': token,
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
      void next() {
        Registration2(
          signupMobx: SignupController(),
          username: username,
          email: email,
          provider: provider,
          provider_token: provider_token,
        ).launch(context);
      }

      if (jsonResponse['status'] != null) {
        jsonResponse['status'] == "not_found" ? next() : print("object");
        setProvider(provider);
        setProvidertoken(token);
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }
}

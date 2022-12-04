import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Models/account.dart';
import 'package:hilike/Models/country.dart';
import 'package:hilike/Models/id_name.dart';
import 'package:hilike/Models/user_image.dart';
import 'package:hilike/Pages/InitialPages/Welcome.dart';
import 'package:hilike/Pages/MainPages/MainMenu.dart';
import 'package:hilike/Pages/MainPages/Profile.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Widget/CustomDialogBan.dart';
import 'package:hilike/Widget/looding.dart';
import 'package:hilike/extensions.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:path/path.dart';

import '../../Utils/constants.dart';
import 'login_mobx.dart';

part 'profile_mobx.g.dart';

class ProfileController = ProfileMobx with _$ProfileController;

abstract class ProfileMobx with Store {
  @observable
  AccountModel? user;
  ObservableList<IdNameModel> religions = ObservableList<IdNameModel>.of([]);
  ObservableList<IdNameModel> languagesList =
      ObservableList<IdNameModel>.of([]);
  ObservableList<IdNameModel> jobs = ObservableList<IdNameModel>.of([]);
  ObservableList<IdNameModel> socialTypes = ObservableList<IdNameModel>.of([]);
  ObservableList<IdNameModel> marriageTypes =
      ObservableList<IdNameModel>.of([]);
  ObservableList<IdNameModel> educations = ObservableList<IdNameModel>.of([]);
  ObservableList<IdNameModel> smoke = ObservableList<IdNameModel>.of([]);
  ObservableList<IdNameModel> childrens = ObservableList<IdNameModel>.of([]);
  ObservableList<IdNameModel> drink = ObservableList<IdNameModel>.of([]);
  ObservableList<IdNameModel> skinColors = ObservableList<IdNameModel>.of([]);
  ObservableList<IdNameModel> bodyShapes = ObservableList<IdNameModel>.of([]);
  ObservableList<IdNameModel> languages = ObservableList<IdNameModel>.of([]);
  ObservableList<IdNameModel> nativeLangList =
      ObservableList<IdNameModel>.of([]);
  ObservableList<UserImageModel>? images =
      ObservableList<UserImageModel>.of([]);

  @observable
  String? religionSearchQuery;
  @observable
  String? childrenSearchQuery;

  @observable
  String? jobsSearchQuery;
  @observable
  String? socialTypesSearchQuery;
  @observable
  String? marriageTypesSearchQuery;
  @observable
  String? educationSearchQuery;
  @observable
  String? skinColorsSearchQuery;
  @observable
  String? bodyShapesSearchQuery;
  @observable
  String? smokeSearchQuery;
  @observable
  String? drinkSearchQuery;
  @observable
  String? languageSearchQuery;
  @observable
  String? about;
  @observable
  String? lookingFor;

  @observable
  IdNameModel? religion;
  @observable
  IdNameModel? job;
  @observable
  IdNameModel? socialType;
  @observable
  IdNameModel? marriageType;
  @observable
  IdNameModel? education;
  @observable
  IdNameModel? smoking;
  @observable
  IdNameModel? skinColor;
  @observable
  IdNameModel? bodyShape;
  @observable
  IdNameModel? drinking;
  @observable
  IdNameModel? language;
  @observable
  CountryModel? originCountry;
  @observable
  CountryModel? residenceCountry;
  @observable
  String? dob;
  @observable
  IdNameModel? children;

  @observable
  int? height;
  @observable
  String? nickname;
  @observable
  String? message;
  @observable
  bool? isban;
  @observable
  bool? isSent;
  @observable
  String? expired;
  @observable
  String? langS;
  @observable
  bool agree = false;
  @observable
  List nativeLangIdList = [];
  @action
  void setAgree(val) {
    agree = val;
  }

  @action
  void setLangs(val) {
    langS = val;
  }

  @action
  void addLangIdToList(val) {
    nativeLangIdList.add(val);
  }

  @action
  void addLangToList(val) {
    nativeLangList.add(val);
  }

  @action
  void setMessage(val) {
    message = val;
  }

  @action
  void setisSent(val) {
    isSent = val;
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
  void setUser(val) {
    user = val;
  }

  @action
  void setReligionSearchQuery(val) {
    religionSearchQuery = val;
  }

  @action
  void setChildrenSearchQuery(val) {
    childrenSearchQuery = val;
  }

  @action
  void setJobsSearchQuery(val) {
    jobsSearchQuery = val;
  }

  @action
  void setSocialTypesSearchQuery(val) {
    socialTypesSearchQuery = val;
  }

  @action
  void setMarriageTypesSearchQuery(val) {
    marriageTypesSearchQuery = val;
  }

  @action
  void setEducationSearchQuery(val) {
    educationSearchQuery = val;
  }

  @action
  void setSkinColorsSearchQuery(val) {
    skinColorsSearchQuery = val;
  }

  @action
  void setBodyShapesSearchQuery(val) {
    bodyShapesSearchQuery = val;
  }

  @action
  void setDrinkingSearchQuery(val) {
    drinkSearchQuery = val;
  }

  @action
  void setSmokingSearchQuery(val) {
    smokeSearchQuery = val;
  }

  @action
  void setLanguageSearchQuery(val) {
    languageSearchQuery = val;
  }

  @action
  void setReligion(val) {
    religion = val;
  }

  @action
  void setJob(val) {
    job = val;
  }

  @action
  void setSocialType(val) {
    socialType = val;
  }

  @action
  void setMarriageType(val) {
    marriageType = val;
  }

  @action
  void setEducation(val) {
    education = val;
  }

  @action
  void setSkinColor(val) {
    skinColor = val;
  }

  @action
  void setBodyShape(val) {
    bodyShape = val;
  }

  @action
  void setDrinking(val) {
    drinking = val;
  }

  @action
  void setLanguage(val) {
    language = val;
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
  void setDob(val) {
    dob = val;
  }

  @action
  void setChildren(val) {
    children = val;
  }

  @action
  void setSmoking(val) {
    smoking = val;
  }

  @action
  void setHeight(val) {
    height = val;
  }

  @action
  void setNickname(val) {
    nickname = val;
  }

  @action
  void setImages(List<UserImageModel> arr) {
    (images ?? []).clear();
    (images ?? []).addAll(arr);
  }

  @action
  void addImage(UserImageModel val) {
    (images ?? []).add(val);
  }

  @action
  void removeImage(UserImageModel val) {
    (images ?? []).remove(val);
  }

  @action
  void setAbout(val) {
    about = val;
  }

  @action
  void setLookingFor(val) {
    lookingFor = val;
  }

  @action
  void reset() {
    nativeLangIdList.clear();
    nativeLangList.clear();
    languagesList = ObservableList<IdNameModel>.of([]);
    religions = ObservableList<IdNameModel>.of([]);
    jobs = ObservableList<IdNameModel>.of([]);
    socialTypes = ObservableList<IdNameModel>.of([]);
    marriageTypes = ObservableList<IdNameModel>.of([]);
    educations = ObservableList<IdNameModel>.of([]);
    skinColors = ObservableList<IdNameModel>.of([]);
    bodyShapes = ObservableList<IdNameModel>.of([]);
    childrens = ObservableList<IdNameModel>.of([]);
    languages = ObservableList<IdNameModel>.of([]);
    smoke = ObservableList<IdNameModel>.of([]);
    drink = ObservableList<IdNameModel>.of([]);
    religionSearchQuery = null;
    jobsSearchQuery = null;
    socialTypesSearchQuery = null;
    marriageTypesSearchQuery = null;
    educationSearchQuery = null;
    skinColorsSearchQuery = null;
    bodyShapesSearchQuery = null;
    childrenSearchQuery = null;
    smokeSearchQuery = null;
    drinkSearchQuery = null;
    languageSearchQuery = null;
    religion = null;
    job = null;
    socialType = null;
    marriageType = null;
    education = null;
    skinColor = null;
    bodyShape = null;
    language = null;
    originCountry = null;
    residenceCountry = null;
    dob = null;
    children = null;
    smoking = null;
    height = null;
    nickname = null;
  }

  @action
  Future<void> getMyProfile(BuildContext context,
      {bool fromChat = false}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });
    String api = "my_profile";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n headers: ${headers.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url, headers: headers);
      Navigator.pop(context);
      if (isNavOpen == false && fromChat == false) {
        isNavOpen = true;

        print("isNavOpen $isNavOpen");
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
      if (jsonResponse["status"] == "ban") {
        setIsban(true);
        setMessage(jsonResponse["message"]);
        setExpired(jsonResponse["expired_at"] ?? "");
      } else {
        setIsban(false);
        if (jsonResponse['main_data'] != null) {
          jsonResponse.addAll(jsonResponse['main_data']);
          user = AccountModel().fromJson(jsonResponse);
        }
      }
      //   if (jsonResponse['images'] != null) {
      //   jsonResponse.addAll(jsonResponse['images']);
      //   user = AccountModel().fromJson(jsonResponse);
      // }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> getEditProfileData(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "edit_profile";
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
      print("isNavOpen $isNavOpen");
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
      nativeLangList.clear();
      nativeLangIdList.clear();
      languagesList.clear();
      languages.clear();
      religions.clear();
      jobs.clear();
      socialTypes.clear();
      marriageTypes.clear();
      educations.clear();
      skinColors.clear();
      bodyShapes.clear();
      smoke.clear();
      drink.clear();
      childrens.clear();

      if (jsonResponse['other_info']['native_language'] != null) {
        for (var item in jsonResponse['other_info']['native_language']) {
          languages.add(IdNameModel.fromJson(item));
        }
      }
      if (jsonResponse['religions'] != null) {
        for (var item in jsonResponse['religions']) {
          religions.add(IdNameModel.fromJson(item));
        }
      }
      if (jsonResponse['jobs'] != null) {
        for (var item in jsonResponse['jobs']) {
          jobs.add(IdNameModel.fromJson(item));
        }
      }

      if (jsonResponse['smoking'] != null) {
        for (var item in jsonResponse['smoking']) {
          smoke.add(IdNameModel.fromJson(item));
        }
      }
      if (jsonResponse['drinking'] != null) {
        for (var item in jsonResponse['drinking']) {
          drink.add(IdNameModel.fromJson(item));
        }
      }
      if (jsonResponse['children'] != null) {
        for (var item in jsonResponse['children']) {
          childrens.add(IdNameModel.fromJson(item));
        }
      }
      if (jsonResponse['languages'] != null) {
        for (var item in jsonResponse['languages']) {
          languagesList.add(IdNameModel.fromJson(item));
        }
      }
      if (jsonResponse['social_types'] != null) {
        for (var item in jsonResponse['social_types']) {
          socialTypes.add(IdNameModel.fromJson(item));
        }
      }
      if (jsonResponse['marriage_types'] != null) {
        for (var item in jsonResponse['marriage_types']) {
          marriageTypes.add(IdNameModel.fromJson(item));
        }
      }
      if (jsonResponse['education'] != null) {
        for (var item in jsonResponse['education']) {
          educations.add(IdNameModel.fromJson(item));
        }
      }
      if (jsonResponse['skin_colors'] != null) {
        for (var item in jsonResponse['skin_colors']) {
          skinColors.add(IdNameModel.fromJson(item));
        }
      }
      if (jsonResponse['body_shapes'] != null) {
        for (var item in jsonResponse['body_shapes']) {
          bodyShapes.add(IdNameModel.fromJson(item));
        }
      }
      // languages.clear();
      // languages.add(IdNameModel(id: 1, name: 'en'));
      // languages.add(IdNameModel(id: 2, name: 'ar'));
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
  Future<bool> updateProfile(BuildContext context,
      {String? profileImage, List<int?>? removedImages}) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });
    setLangs("");
    for (int? id in removedImages ?? []) {
      await deleteImage(context, id ?? 0);
    }

    String api = "update_profile";
    String method = "POST";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {
      'Authorization': token,
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    if (nativeLangIdList.length > 0) {
      setLangs("");
      nativeLangIdList.forEach((element) {
        langS = element.toString() + "," + langS!;
      });
    }

    Map<String, dynamic> body = {
      'nickname': nickname ?? user!.nickname,
      'about': about ?? user!.otherInfo!.about,
      'looking_for': lookingFor ?? user!.otherInfo!.lookingFor,
      'age': dob ?? user!.otherInfo!.dob,
      'origin_country_name': originCountry == null
          ? user!.otherInfo!.originCountry
          : originCountry!.name,
      'residence_country_name': residenceCountry == null
          ? user!.otherInfo!.residenceCountry
          : residenceCountry!.name,
      'religion_id': religion == null ? null : religion!.id,
      'social_type_id': socialType == null ? null : socialType!.id,
      'marriage_type_id': marriageType == null ? null : marriageType!.id,
      'education_id': education == null ? null : education!.id,
      'job_id': job == null ? null : job!.id,
      'children_id': children == null ? null : children!.id,
      'smoking_id': smoking == null ? null : smoking!.id,
      'drinking_id': drinking == null ? null : drinking!.id,
      'native_language': langS != "" ? langS : null,
      'height': height == null ? user!.otherInfo!.height : height,
      'skin_color_id': skinColor == null ? null : skinColor!.id,
      'body_id': bodyShape == null ? null : bodyShape!.id,
      'origin_latitude': originCountry == null ? null : originCountry!.latitude,
      'origin_longitude':
          originCountry == null ? null : originCountry!.longitude,
      'residence_latitude':
          residenceCountry == null ? null : residenceCountry!.latitude,
      'residence_longitude':
          residenceCountry == null ? null : residenceCountry!.longitude,
    };
    if (!profileImage.isEmptyOrNull) {
      body.addAll({
        "profile_image": await MultipartFile.fromFile(profileImage!,
            filename: basename(profileImage)),
      });
    }
    if (images != null && images!.isNotEmpty) {
      for (int i = 0; i < images!.length; i++) {
        UserImageModel image = images![i];
        if (image.isLocal ?? false) {
          body.addAll({
            "other_images[$i]": await MultipartFile.fromFile(image.image!,
                filename: basename(image.image!)),
          });
        }
      }
    }
    try {
      final String url = baseUrl + api;
      log("$method -> ${url.toString()} \n headers: ${headers} \n body: ${body}");
      var dio = Dio();
      dio.options = BaseOptions(headers: headers);
      FormData formData = FormData.fromMap(body);
      Response response = await dio.post(
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
      if (isNavOpen == false) {
        isNavOpen = true;

        Navigator.pop(context);
      }
      Navigator.pop(context);

      if (response.statusCode == 200) {
        nativeLangIdList.clear();
        nativeLangList.clear();
        print(response.toString());
        return true;
      } else {
        print("Error $url. status code: ${response.statusCode}");
        showTopSnackBar(
            S.of(context).failedUpdateProfile, "assets/img/iii.png");
        return false;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        print(e.response?.statusCode);
      } else {
        print(e.message);
        print(e.response.toString());
      }
      return false;
    }
  }

  Future<void> deleteImage(BuildContext context, int id) async {
    String api = "delete_image/$id";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n headers: ${headers.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url, headers: headers);
      log("${url.toString()} \n status code: ${response.statusCode} \n response: ${response.body}");
    } on SocketException {
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> supportticket(BuildContext context, String name, String email,
      String subject, String message) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "contact_message";
    String method = "POST";

    // String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Accept': 'application/json'};

    Map<String, dynamic> body = {
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
    };

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n body: ${body.toString()} \n headers: ${headers.toString()}");
    try {
      final client = http.Client();
      var response = await client.post(url, body: body, headers: headers);
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
      if (response.statusCode > 199 && response.statusCode < 300) {
        if (jsonResponse['status'] != null) {
          if (jsonResponse['status'] == 'success') {
            setisSent(true);
            print("show : $isSent");
            return;
          }
          showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
        }
        // Navigator.pop(context);
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (BuildContext context) => Mainmenu()),
        //   ModalRoute.withName('/'),
        // );
        return;
      }
      showTopSnackBar(S.of(context).somethingIsWrong, "assets/img/iii.png");
      log(response.body);
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
    }
  }
}

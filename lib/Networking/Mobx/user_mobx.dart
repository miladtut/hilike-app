import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hilike/Models/account.dart';
import 'package:hilike/Models/categories.dart';
import 'package:hilike/Models/chat.dart';
import 'package:hilike/Models/message.dart';
import 'package:hilike/Networking/Firebase/FirebaseApi.dart';
import 'package:hilike/Pages/InitialPages/Welcome.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Widget/CustomDialogBan.dart';
import 'package:hilike/Widget/looding.dart';
import 'package:hilike/extensions.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/src/extensions/widget_extensions.dart';
import 'package:path/path.dart';

import '../../Utils/constants.dart';
import 'login_mobx.dart';

part 'user_mobx.g.dart';

class UserController = UserMobx with _$UserController;

abstract class UserMobx with Store {
  @observable
  AccountModel? user;
  @observable
  String? uploadlink;
  @observable
  num? imageId;
  @observable
  bool? isLoading;
  @observable
  int? userId;
  @observable
  int? pageViewIndex;
  @observable
  bool? isLiked;
  ObservableList<String> reportReasons = ObservableList<String>.of([]);
  @observable
  int selectedReasonIndex = -1;
  @observable
  String? thread = "no";
  @observable
  String? search = "";
  ObservableList<Categories> catlist = ObservableList<Categories>.of([]);
  ObservableList<Chat> chatlist = ObservableList<Chat>.of([]);
  ObservableList<Chat> firechatlist = ObservableList<Chat>.of([]);
  ObservableList<Chat> searchchatlist = ObservableList<Chat>.of([]);

  @observable
  num? countApi;

  @observable
  bool? geebApi;

  @observable
  int x = 0;

  @observable
  int notification = 0;
  @observable
  String? message;
  @observable
  bool? isban;
  @observable
  String? expired;
  @action
  void setMessage(val) {
    message = val;
  }

  @observable
  bool? Isdone;
  @action
  void setIsdone(val) {
    Isdone = val;
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
  void setx(val) {
    x = val;
  }

  @action
  void setNotification(val) {
    notification = val;
  }

  @action
  void setApival(val) {
    geebApi = val;
  }

  @action
  void setApinum(val) {
    countApi = val;
  }

  @action
  void setUser(val) {
    user = val;
  }

  @action
  void setSearchval(val) {
    search = val;
  }

  @action
  void setload(val) {
    isLoading = val;
  }

  @action
  void setUserId(val) {
    userId = val;
  }

  @action
  void setUploadedlink(val) {
    uploadlink = val;
  }

  @action
  void setUploadednum(val) {
    imageId = val;
  }

  @action
  void setPageViewIndex(val) {
    pageViewIndex = val;
  }

  @action
  void setSelectedReasonIndex(val) {
    selectedReasonIndex = val;
  }

  @action
  Future<void> setIsLiked(BuildContext context, val, bool isLocal) async {
    if (isLocal) {
      isLiked = val;
    } else if (isLiked ?? user!.isLiked ?? false) {
      bool success = await removeLike(context);
      if (success) isLiked = val;
    } else {
      bool success = await addLike(context);
      if (success) isLiked = val;
    }
  }

  @action
  Future<void> getUserProfile(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "user_profile/$userId";
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
      if (jsonResponse['main_data'] != null) {
        jsonResponse.addAll(jsonResponse['main_data']);
        user = AccountModel().fromJson(jsonResponse);
      }
      setIsLiked(context, (jsonResponse['is_liked'] ?? 0) == 1, true);
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<bool> addLike(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "add_like/${user!.id ?? 0}";
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
        return false;
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
      if (response.statusCode != 200 ||
          (jsonResponse["status"] != null &&
              jsonResponse["status"] != "success")) {
        if (jsonResponse['message'] != null) {
          showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
        }
        return false;
      }
      return true;
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return false;
    }
  }

  @action
  Future<bool> removeLike(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "remove_like/${user!.id ?? 0}";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n headers: ${headers.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url, headers: headers);
      if (isNavOpen == false) {
        Navigator.pop(context);
        isNavOpen = true;
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
      if (response.statusCode != 200 ||
          (jsonResponse["status"] != null &&
              jsonResponse["status"] != "success")) {
        if (jsonResponse['message'] != null) {
          showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
        }
        return false;
      }
      return true;
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return false;
    }
  }

  @action
  Future<bool> addBlock(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "add_block/${userId ?? 0}";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n headers: ${headers.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url, headers: headers);
      if (isNavOpen == false) {
        Navigator.pop(context);
        isNavOpen = true;
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
      if (response.statusCode != 200 ||
          (jsonResponse["status"] != null &&
              jsonResponse["status"] != "success")) {
        if (jsonResponse['message'] != null) {
          showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
        }
        return false;
      }
      return true;
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return false;
    }
  }

  @action
  Future<bool> removeBlockInChat(BuildContext context, String id) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "remove_block/$id";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n headers: ${headers.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url, headers: headers);
      if (isNavOpen == false) {
        Navigator.pop(context);
        isNavOpen = true;
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
      if (response.statusCode > 199 &&
          response.statusCode < 300 &&
          jsonResponse['message'] != null) {
        setIsdone(true);
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
      if (response.statusCode != 200 ||
          (jsonResponse["status"] != null &&
              jsonResponse["status"] != "success")) {
        if (jsonResponse['message'] != null) {
          showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
        }
        return false;
      }
      return true;
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return false;
    }
  }

  @action
  Future<bool> removeBlock(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "remove_block/${userId ?? 0}";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n headers: ${headers.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url, headers: headers);
      if (isNavOpen == false) {
        Navigator.pop(context);
        isNavOpen = true;
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
      if (response.statusCode != 200 ||
          (jsonResponse["status"] != null &&
              jsonResponse["status"] != "success")) {
        if (jsonResponse['message'] != null) {
          showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
        }
        return false;
      }
      return true;
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return false;
    }
  }

  @action
  Future<void> getChatThread(
    BuildContext context,
    String id,
  ) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "check_for_thread/$id";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n headers: ${headers.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url, headers: headers);
      if (isNavOpen == false) {
        Navigator.pop(context);
        isNavOpen = true;
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
      if (jsonResponse['thread_exists'] == true) {
        thread = jsonResponse['thread'];
        print("object$thread");
        if (jsonResponse['thread_exists'] == false)
          createChatThread(context, storage.account.id.toString(), id, storage.account.id.toString() + "s" + id.toString());
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> getFireThreads(int uid) async{
    await FirebaseApi.getFireThreads(uid);
  }

  @action
  Future<void> chooseChatCat(
    BuildContext context,
    String id,
  ) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "choose_chat_cat/$id/s${storage.account.id}";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n headers: ${headers.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url, headers: headers);
      if (isNavOpen == false) {
        Navigator.pop(context);
        isNavOpen = true;
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
      if (jsonResponse['status'] == true) {}
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> getCatlist(
    BuildContext context,
  ) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "get_support_categories";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n headers: ${headers.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url, headers: headers);
      if (isNavOpen == false) {
        Navigator.pop(context);
        isNavOpen = true;
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
      if (response.statusCode == 200) {
        // catlist = jsonResponse['categories'];
        // print("object$thread");

        if (jsonResponse['categories'] != null) {
          List getData(Map<String, dynamic> data) {
            return data['categories'];
          }

          catlist.clear();
          (getData(jsonResponse)).map((item) async {
            catlist.add(Categories.fromJson(item));
          }).toList();
        }
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> uploadChatImage(
    BuildContext context,
    var image,
  ) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "upload_chat_image";
    String method = "POST";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {
      'Authorization': token,
      'Accept': 'application/json',
    };

    Map<String, dynamic> body = {
      'image': await MultipartFile.fromFile(image, filename: basename(image))
    };

    final String url = baseUrl + api;
    log("$method -> ${url.toString()} \n body: ${body.toString()} \n headers: ${headers.toString()}");
    try {
      log("$method -> ${url.toString()} \n headers: ${headers.toString()} \n body: ${body.toString()}");
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
      Navigator.pop(context);
      if (isNavOpen == false) {
        Navigator.pop(context);
        isNavOpen = true;
      }
      if (response.statusCode == 200) {
        setUploadedlink(response.data['image']);

        setUploadednum(response.data['name']);
      } else {
        print("Error $url. status code: ${response.statusCode}");
        showTopSnackBar(
            S.of(context).failedUpdateProfile, "assets/img/iii.png");
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        print(e.response?.statusCode);
      } else {
        print(e.message);
        print(e.response.toString());
      }
    }
  }

  @action
  createChatThread(BuildContext context, String myid, String decid, String threadid) async{
    await FirebaseApi.createThread({
      "sender_id":myid,
      "receiver_id":decid,
    });
  }

  @action
  Future<void> getChatList(BuildContext context, {Function? onRecive}) async {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Loadoingw();
          });
    });

    String api = "get_user_threads";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n headers: ${headers.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url, headers: headers);
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
        if (jsonResponse['chats'] != null) {
          if (isNavOpen == false) {
            Navigator.pop(context);
            isNavOpen = true;
          }
          Navigator.pop(context);
          setApinum(jsonResponse['count']);
          setNotification(jsonResponse['notification']);
          chatlist.clear();
          List getData(Map<String, dynamic> data) {
            return data['chats'];
          }

          print("number is $countApi");
          // chatlist.clear();

          (getData(jsonResponse)).map((item) async {
            // chatlist.clear();

            Chat tt = Chat.fromJson(item);
            Stream<List<Message>> tyty =
                FirebaseApi.getMessages(chatThread: tt.threadId!);
            tyty.listen((event) async {
              print('thrid is ${tt.threadId!}');
              await FirebaseApi.count(tt.threadId!).then((value) {
                tt.count = value;
                print('count is $value');
                onRecive!();
              });
              List<Message>? messagesss = event;
              // if (messagesss.length > 0) {
              // print('${messagesss[0].text}  eventeventeventeventevent');
              tt.messages?.add(messagesss[0].text);
              tt.updatedAt = messagesss[0].createdAt;
              // } else {
              //   tt.updatedAt = DateTime.now();
              // }

              if (!chatlist.contains(tt)) {
                chatlist.add(tt);
              } else {
                chatlist[chatlist
                        .indexWhere((element) => element.userId == tt.userId)]
                    .messages
                    ?.add(messagesss[0].text);
                if (onRecive != null) onRecive();
              }
              chatlist.sort((a, b) {
                var adate = a.updatedAt!; //before -> var adate = a.expiry;
                var bdate = b.updatedAt!; //before -> var bdate = b.expiry;
                return bdate.compareTo(adate);
                //to get the order other way just switch `adate & bdate`
              });
            });
          }).toList();

          setload(false);
        }
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }


  @action
  Future<void> getReportReasons(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "get_report_reasons";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n headers: ${headers.toString()}");
    try {
      final client = http.Client();
      var response = await client.get(url, headers: headers);
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
      if (jsonResponse['report_reasons'] != null) {
        reportReasons.clear();
        for (String item in jsonResponse['report_reasons']) {
          reportReasons.add(item);
        }
      } else if (response.statusCode != 200 ||
          (jsonResponse["status"] != null &&
              jsonResponse["status"] != "success")) {
        if (jsonResponse['message'] != null) {
          showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
        }
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> searchMessage(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Loadoingw();
        });

    String api = "search_chats/$search";
    String method = "GET";
    String token = "Bearer ${storage.account.apiToken}";
    var headers = {'Authorization': token, 'Accept': 'application/json'};

    final Uri url = Uri.parse(baseUrl + api);
    log("$method -> ${url.toString()} \n headers: ${headers.toString()}");
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
      if (jsonResponse['chats'] != null) {
        List getData(Map<String, dynamic> data) {
          return data['chats'];
        }

        searchchatlist.clear();
        (getData(jsonResponse)).map((item) async {
          Chat tt = Chat.fromJson(item);
          Stream<List<Message>> tyty =
              FirebaseApi.getMessages(chatThread: tt.threadId!);
          tyty.listen((event) async {
            print('thrid is ${tt.threadId!}');
            await FirebaseApi.count(tt.threadId!).then((value) {
              tt.count = value;
              print('count is $value');
            });

            List<Message>? messagesss = event;
            print('${messagesss[0].text}  eventeventeventeventevent');
            // Chat.fromJson(item).messages?.add(event.text);
            tt.messages?.add(messagesss[0].text);
            tt.updatedAt = messagesss[0].createdAt;

            if (!searchchatlist.contains(tt)) {
              searchchatlist.add(tt);
            } else {
              searchchatlist[searchchatlist
                      .indexWhere((element) => element.userId == tt.userId)]
                  .messages
                  ?.add(messagesss[0].text);
            }
            searchchatlist.sort((a, b) {
              var adate = a.updatedAt!; //before -> var adate = a.expiry;
              var bdate = b.updatedAt!; //before -> var bdate = b.expiry;
              return bdate.compareTo(
                  adate); //to get the order other way just switch `adate & bdate`
            });
          }).onDone(() {});
          // onError((error) {
          //   print(error);
          // });
        }).toList();

        // for (int i = 0; i < chatlist.length; i++)
        //   StreamBuilder<List<Message>>(
        //       stream: FirebaseApi.getMessages(
        //           chatThread: chatlist[i].threadId!), //get my id  + userid
        //       builder: (context, snapshot) {
        //         switch (snapshot.connectionState) {
        //           case ConnectionState.waiting:
        //             return Container();
        //           default:
        //             if (snapshot.hasError) {
        //               //showTopSnackBar(S.of(context).somethingIsWrong,
        //               //    "assets/img/iii.png");
        //               return Container();
        //             } else {
        //               List<Message>? messages = snapshot.data;
        //               msg.add(messages![0].text);

        //               return Container();
        //             }
        //         }
        //       });

        setload(false);
      }
    } on SocketException {
      Navigator.pop(context);
      showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      return;
    }
  }

  @action
  Future<void> reportUser(BuildContext context, {String? resason}) async {
    if (reportReasons.isNotEmpty && selectedReasonIndex != -1) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Loadoingw();
          });

      String api = "report_user";
      String method = "POST";

      String token = "Bearer ${storage.account.apiToken}";
      var headers = {'Authorization': token, 'Accept': 'application/json'};

      Map<String, dynamic> body = {
        'to_user': '$userId',
        'reason': resason == "" ? reportReasons[selectedReasonIndex] : resason,
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
          if (jsonResponse['status'] != null &&
              jsonResponse['message'] != null) {
            if (jsonResponse['status'] == 'success') {
              Navigator.of(context).pop();
              showTopSnackBar(S.of(context).reportdone, "assets/img/check.png");
              setSelectedReasonIndex(-1);
              return;
            }
            showTopSnackBar(jsonResponse['message'], "assets/img/iii.png");
          }
          Navigator.of(context).pop();
          return;
        }
        showTopSnackBar(S.of(context).somethingIsWrong, "assets/img/iii.png");
        log(response.body);
      } on SocketException {
        Navigator.pop(context);
        showTopSnackBar(S.of(context).connectionFailed, "assets/img/iii.png");
      }
    } else {
      showTopSnackBar(S.of(context).pleaseSelectReason, "assets/img/iii.png");
    }
  }
}

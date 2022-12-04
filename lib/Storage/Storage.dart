import 'dart:async';
import 'dart:convert';

import 'package:hilike/Models/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Storage storage = Storage._private();

class Storage {
  Storage._private();
  var image;
  var pos;
  bool? tryToGetLoacation;
  bool? showBox;

  SharedPreferences? _prefs;
  Future<SharedPreferences>? prefsFuture;

  AccountModel get account => _prefs!.containsKey("account")
      ? AccountModel().fromJson(json.decode(_prefs!.getString('account') ?? ""))
      : AccountModel();

  set account(AccountModel field) =>
      _prefs!.setString('account', jsonEncode(field.toJson()));

  clear() {
    _prefs!.clear();
  }

  Future<void> getPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }
}

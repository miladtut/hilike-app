import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hilike/Models/gift.dart';
import 'package:hilike/Models/gift_category.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/extensions.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:quiver/iterables.dart';

import '../../Utils/constants.dart';

part 'chat_mobx.g.dart';

class ChatController = ChatMobx with _$ChatController;

abstract class ChatMobx with Store {
 
  @observable
  bool loading = false;
  
  @action
  void setLoading(val) {
    loading = val;
  }
}

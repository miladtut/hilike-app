import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

const String baseUrl =
    // "http://10.0.2.2:8000/api/";
    "https://hilike.american-tech.tech/public/api/";
    // "https://hilike-chat.com/vroad/public/api/";
const imageUrl =
    "https://hilike.american-tech.tech/public/images/";
    // "https://hilike-chat.com/public/images/";
const imgPlaceholder =
    "https://hilike-chat.com/public/logo.jpg";
    // "https://i.pinimg.com/736x/1e/d6/63/1ed6630606041ca4715d438628d319ca.jpg";
const imgMalePlaceholder = "${imageUrl}avatar_male.png";
const imgFemalePlaceholder = "${imageUrl}avatar_female.png";
const logo = "https://hilike-chat.com/public/logo.jpg";
const imgSupport = "${imageUrl}sss.png";
const GoogleApiKey = "AIzaSyAytTV8-PABFIxsOz8A86VirmvhAKObOtw";
const tik = "assets/img/tik.png";
const tikk = "assets/img/tikk.png";
const bluetikk = "assets/img/bluetikk.png";
const pending = "assets/img/pending.png";
const Color redH = Color(0xffe5003a);

var messageSound;

// Future<ByteData> loadAsset() async {
//   return await rootBundle.load('assets/notification.mp3');
// }

// var filesound;
// Future<void> soundNoti() async {
//   final file =
//       new File('${(await getTemporaryDirectory()).path}/notification.mp3');
//   // await file.writeAsBytes((await loadAsset()).buffer.asUint8List());

//   filesound = file.path;
// }

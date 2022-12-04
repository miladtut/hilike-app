import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:hilike/Models/app.dart';
import 'package:hilike/Networking/Mobx/plans_mobx.dart';
import 'package:hilike/Pages/MainPages/MainMenu.dart';
import 'package:hilike/Widget/paymentconfirem.dart';

class WebViewContainer extends StatefulWidget {
  final url;
  String title, dis;
  WebViewContainer(this.url, this.title, this.dis);
  @override
  createState() => _WebViewContainerState(this.url);
}

class _WebViewContainerState extends State<WebViewContainer> {
  PlansMobx plansMobx = PlansController();

  var _url;
  final _key = UniqueKey();
  _WebViewContainerState(this._url);
  @override
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  late StreamSubscription<String> _onUrlChanged;
  @override
  void dispose() {
    _onUrlChanged.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _onUrlChanged =
        flutterWebviewPlugin.onUrlChanged.listen((String url) async {
      if (url.contains('completed')) {
        print("url  wow $url");
        Navigator.pop(context);

        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return PaymentConf(
                free: false,
                status: true,
                fromCoins: widget.dis == "null" ? true : false);
          },
        );

        Future.delayed(Duration(seconds: 8), () {
          if (widget.dis != "null") {
            Navigator.pushAndRemoveUntil(
              App.materialKey!.currentContext!,
              MaterialPageRoute(builder: (BuildContext context) => Mainmenu()),
              ModalRoute.withName('/'),
            );
          } else {
            Navigator.pop(
              App.materialKey!.currentContext!,
            );
            Navigator.pop(
              App.materialKey!.currentContext!,
            );
            Navigator.pop(
              App.materialKey!.currentContext!,
            );
          }
        });
      }
      if (url.contains('failed')) {
        print("url not wow $url");

        Navigator.pop(context);
        showDialog(
          context: context,
          // barrierDismissible: false,
          builder: (BuildContext context) {
            return PaymentConf(
                free: false,
                status: false,
                fromCoins: widget.dis == "null" ? true : false);
          },
        );
        Future.delayed(Duration(seconds: 4), () {
          Navigator.pop(
            App.materialKey!.currentContext!,
          );
        });
      }
    });
    //   showDialog(
    //     barrierDismissible: true,
    //     context: context,
    //     builder: (BuildContext context) {
    //       return PaymentConf(status: true);
    //     },
    //   );
    //   Future.delayed(Duration(seconds: 10), () {
    //     Navigator.of(context).pop(false);
    //     Navigator.pop(context);
    //   });
    // }

    // if (mounted) {
    //   setState(() {
    //     print('onUrlChanged: $url');
    //   });
    // }
    // });
    // flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {
    //   print('sss2${wvs.url}');
    // });
  }

  Widget build(BuildContext context) {
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {
      print('${wvs.url}');
    });
    print(" $_url");
    return WebviewScaffold(
      url: _url,
      withZoom: true,
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff1a1a1a),
        title: new Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w900,
            letterSpacing: 1.10,
          ),
        ),
      ),
    );
  }
}

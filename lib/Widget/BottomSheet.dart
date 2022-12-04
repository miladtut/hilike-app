import 'package:flutter/material.dart';
import 'package:hilike/Networking/Mobx/user_mobx.dart';
import 'package:hilike/Pages/userpages/Report.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

import 'customDialog.dart';

class BottomSheetview extends StatelessWidget {
  final UserMobx userMobx;
  final Function? onFinish;

  const BottomSheetview({Key? key, required this.userMobx, this.onFinish})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        color: Color(0xff292929),
        height: size.height / 2.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // GestureDetector(
            //   onTap: () {
            //     Navigator.pushNamed(context, "share");
            //   },
            //   child: Container(
            //     width: size.width / 1.15,
            //     height: size.height / 13.5,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(15),
            //       border: Border.all(
            //         color: Color(0xff4f4f4f),
            //         width: 1,
            //       ),
            //     ),
            //     child: Center(
            //       child: Text(
            //         "Share to ...",
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 15,
            //           fontFamily: "Roboto",
            //           fontWeight: FontWeight.w700,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext ctx) {
                    return CustomDialogg(
                      title: S.of(context).doYouWantToBlock +
                          " " +
                          (userMobx.user!.nickname ?? "") +
                          " ?",
                      negativeButtonText: S.of(context).no,
                      positiveButtonText: S.of(context).yes,
                      onNegativeClick: () {
                        Navigator.pop(context);
                      },
                      onPositiveClick: () async {
                        Navigator.pop(context);
                        bool success = await userMobx.addBlock(context);
                        if (success && onFinish != null) onFinish!();
                      },
                    );
                  },
                );
              },
              child: Container(
                width: size.width / 1.15,
                height: size.height / 13.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color(0xff4f4f4f),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    S.of(context).block,
                    style: TextStyle(
                      color: Color(0xffe5003a),
                      fontSize: 15,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Report(userMobx: userMobx).launch(context);
              },
              child: Container(
                width: size.width / 1.15,
                height: size.height / 13.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color(0xff4f4f4f),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    S.of(context).submitReport,
                    style: TextStyle(
                      color: Color(0xffe5003a),
                      fontSize: 15,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: size.width / 1.15,
                height: size.height / 13.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color(0xff4f4f4f),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    S.of(context).cancel,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class UpgradeWidget extends StatelessWidget {
  final int pageIndex;
  final String name;
  final List<String> descriptionList;
  final Color color;
  final int pagesCount;

  const UpgradeWidget({
    Key? key,
    required this.pageIndex,
    required this.name,
    required this.color,
    required this.descriptionList,
    required this.pagesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        width: size.width / 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xff292929),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 17, 0, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 100,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/img/vip.png"),
                              ),
                            ),
                            child: Text(
                              name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.80,
                              ),
                            ).paddingTop(25),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Text(
                            name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.80,
                            ),
                          ).paddingSymmetric(horizontal: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (String item in descriptionList)
                    Padding(
                      padding: Localizations.localeOf(context)
                                  .languageCode
                                  .toString() ==
                              "ar"
                          ? EdgeInsets.fromLTRB(0, 16, 0, 0)
                          : EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: color,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            item,
                            style: TextStyle(
                              color: Color(0xfff5f5f5),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(height: 25),
              Container(
                height: 16,
                child: Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: pagesCount,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xff5c5c5c),
                            width: 1.0,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: index == pageIndex
                                  ? Colors.white
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ).paddingAll(2.5);
                    },
                  ),
                ),
              ).paddingBottom(16),
            ],
          ),
        ),
      ),
    );
  }
}

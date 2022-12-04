import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hilike/Networking/Mobx/profile_mobx.dart';
import 'package:hilike/Networking/Mobx/signup_mobx.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

import 'Models/app.dart';
import 'Models/country.dart';
import 'Models/id_name.dart';
import 'Utils/constants.dart';
import 'generated/l10n.dart';

bool? isNavOpen;
void showLoading(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) {
        return Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    color: Colors.transparent,
                    height: 50,
                    width: 50,
                    child: Center(
                      child: Image.asset(
                        "assets/icon/icon.png",
                      ),
                    ), // RefreshProgressIndicator()
                  )),
            ),
          ],
        );
      },
      barrierDismissible: false);
}

void showTopSnackBar(String message, String image) {
  Flushbar(
    message: message,
    titleColor: Color(0xffC4C4C4),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.elasticOut,
    backgroundColor: Color(0xff292929),
    boxShadows: [
      BoxShadow(color: Colors.black, offset: Offset(0.0, 2.0), blurRadius: 3.0)
    ],
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    isDismissible: false,
    duration: Duration(seconds: 4),
    mainButton: GestureDetector(
      onTap: () {
        Navigator.pop(App.materialKey!.currentContext!);
      },
      child: Container(
        height: 55,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Image.asset(
          image,
        ),
      ),
    ),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ).show(App.materialKey!.currentContext!);
}

void showTopSnackBarNotification(String message, String title, var data) {
  Flushbar(
    onTap: (flushbar) {
      if (data["plan_id"] == "5") {
        Navigator.pushNamed(App.materialKey!.currentContext!, "Steam",
            arguments: [0, storage.account.plan]);
      } else if (data["chat_thread"] == null) {
        Navigator.pushNamed(App.materialKey!.currentContext!, 'liked');
      } else {
        Navigator.pushNamed(App.materialKey!.currentContext!, 'chat',
            arguments: [
              data["nickname"],
              data["image"].toString().contains("http")
                  ? data["image"].toString()
                  : data["plan_id"] == "4"
                      ? logo
                      : storage.account.isMale == true
                          ? imgFemalePlaceholder
                          : imgMalePlaceholder,
              data["user_id"],
              data["chat_thread"],
              0,
              data["plan_id"] == "2"
                  ? "Gold"
                  : data["plan_id"] == "3"
                      ? "Vip"
                      : data["plan_id"] == "4"
                          ? "admin"
                          : "free",
              0
            ]);
      }
    },
    message: message,
    title: title,
    titleColor: Color(0xffC4C4C4),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.elasticOut,
    backgroundColor: Color(0xff292929),
    boxShadows: [
      BoxShadow(color: Colors.black, offset: Offset(0.0, 2.0), blurRadius: 3.0)
    ],
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    isDismissible: false,
    onStatusChanged: (stat) {
      if (stat == FlushbarStatus.IS_APPEARING ||
          stat == FlushbarStatus.IS_HIDING ||
          stat == FlushbarStatus.SHOWING) {
        isNavOpen = false;
      } else {
        isNavOpen = true;
      }
    },
    duration: Duration(seconds: 4),
    mainButton: GestureDetector(
      onTap: () {
        data["plan_id"] == "5"
            ? Navigator.pushNamed(App.materialKey!.currentContext!, "Steam",
                arguments: [0, storage.account.plan])
            : Navigator.pushNamed(App.materialKey!.currentContext!, 'chat',
                arguments: [
                    data["nickname"],
                    data["image"].toString().contains("http")
                        ? data["image"].toString()
                        : data["plan_id"] == "4"
                            ? logo
                            : storage.account.isMale == true
                                ? imgFemalePlaceholder
                                : imgMalePlaceholder,
                    data["user_id"],
                    data["chat_thread"],
                    0,
                    data["plan_id"] == "2"
                        ? "Gold"
                        : data["plan_id"] == "3"
                            ? "Vip"
                            : data["plan_id"] == "4"
                                ? "admin"
                                : "free",
                    0
                  ]);
      },
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Image.asset(
          "assets/icon/icon.png",
        ),
      ),
    ),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ).show(App.materialKey!.currentContext!);
}

void showTopSnackBartest(String message, String image) {
  Flushbar(
    message: message,
    titleColor: Color(0xffC4C4C4),
    flushbarPosition: FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.FLOATING,
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.elasticOut,
    backgroundColor: Color(0xff292929),
    boxShadows: [
      BoxShadow(color: Colors.black, offset: Offset(0.0, 2.0), blurRadius: 3.0)
    ],
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    isDismissible: false,
    duration: Duration(seconds: 4),
    mainButton: GestureDetector(
      onTap: () {
        Navigator.pop(App.materialKey!.currentContext!);
      },
      child: Container(
        height: 55,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Image.asset(
          image,
        ),
      ),
    ),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ).show(App.materialKey!.currentContext!);
}

enum ComesFrom { Vip, SpecialPeople, NewPeople, LikedYou, searchVip }

Future<String> pickDate(context) async {
  DateTime? picked = await showDatePicker(
    context: context,
    locale: Locale.fromSubtags(
        languageCode: Provider.of<AppModel>(context, listen: false).locale),
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: Color(0xffe5003a),
          accentColor: Color(0xffe5003a),
          colorScheme: ColorScheme.light(primary: Color(0xffe5003a)),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child!,
      );
    },
  );
  if (picked != null) {
    return DateFormat('yyyy-MM-dd').format(picked).toString();
  }
  return "";
}

void pickCountry(BuildContext context,
    {required String type,
    required SignupMobx signupMobx,
    Function(SignupMobx signupMobx)? onSelect}) {
  Size size = MediaQuery.of(context).size;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xcc292929),
        actionsPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        actions: <Widget>[
          Container(
            width: size.width * 3 / 2,
            child: SizedBox(
              width: size.width / 2,
              child: TextFormField(
                cursorColor: Color(0xffe5003a),
                onChanged: (val) {
                  type == S.of(context).origin
                      ? signupMobx.setOriginSearchQuery(val)
                      : signupMobx.setResidenceSearchQuery(val);
                },
                textInputAction: TextInputAction.done,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: type == S.of(context).origin
                      ? S.of(context).EnterOriginCountry
                      : S.of(context).EnterResidenceCountry,
                  hintStyle: TextStyle(
                    color: Color(0xffc4c4c4),
                    fontSize: 13,
                    letterSpacing: 0.65,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: size.width * 3 / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: size.width / 1.5,
                    height: 1,
                    color: Color(0xffc4c4c4),
                  ),
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  height: size.height / 4,
                  child: Observer(
                    builder: (_) => ListView.builder(
                      shrinkWrap: true,
                      itemCount: type == S.of(context).origin
                          ? signupMobx.originCountries.length
                          : signupMobx.residenceCountries.length,
                      itemBuilder: (ctx, index) {
                        CountryModel country = type == S.of(context).origin
                            ? signupMobx.originCountries[index]
                            : signupMobx.residenceCountries[index];
                        return GestureDetector(
                          child: Text(
                            country.name ?? "",
                            style: TextStyle(
                              color: Color(0xffc4c4c4),
                              fontSize: 13,
                              letterSpacing: 0.65,
                            ),
                          ).paddingSymmetric(vertical: 8),
                          onTap: () {
                            type == S.of(context).origin
                                ? signupMobx.setOriginCountry(country)
                                : signupMobx.setResidenceCountry(country);
                            if (onSelect != null) onSelect(signupMobx);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}

void selectLang(
  BuildContext context, {
  required String text,
  required List<IdNameModel> list,
  required ProfileMobx profileMobx,
}) {
  final _items = profileMobx.languagesList
      .map((languages) =>
          MultiSelectItem<IdNameModel>(languages, languages.name!))
      .toList();

  List ss = profileMobx.languages;
  List selected = [];
  Size size = MediaQuery.of(context).size;
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      // print("2222 ${profileMobx.languagesList}");
      return Theme(
        data: Theme.of(context).copyWith(
          focusColor: Color(0xffc4c4c4),
          dividerColor: Color(0xffc4c4c4),
        ),
        child: MultiSelectDialog(
          height: size.height / 2,
          cancelText: Text(
            S.of(context).cancel,
            style: TextStyle(
              color: Color(0xffc4c4c4),
              fontSize: 13,
              letterSpacing: 0.65,
            ),
          ),
          confirmText: Text(
            S.of(context).done,
            style: TextStyle(
              color: Color(0xffc4c4c4),
              fontSize: 13,
              letterSpacing: 0.65,
            ),
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Color(0xffc4c4c4),
              fontSize: 13,
              letterSpacing: 0.65,
            ),
          ),
          searchTextStyle: TextStyle(
            color: Color(0xffc4c4c4),
            fontSize: 14,
          ),
          closeSearchIcon: Icon(
            Icons.close_rounded,
            size: 16,
            color: Color(0xffc4c4c4),
          ),
          searchHint: "${S.of(context).search_}",
          searchIcon: Icon(
            Icons.search,
            size: 20,
            color: Color(0xffc4c4c4),
          ),
          searchHintStyle: TextStyle(
            color: Color(0xffc4c4c4),
            fontSize: 13,
          ),
          itemsTextStyle: TextStyle(
            color: Color(0xffc4c4c4),
            fontSize: 13,
            letterSpacing: 0.65,
          ),
          unselectedColor: Color(0xffc4c4c4),
          selectedItemsTextStyle: TextStyle(
            color: Color(0xffc4c4c4),
            fontSize: 13,
            letterSpacing: 0.65,
          ),
          backgroundColor: Color(0xcc292929),
          items: _items,
          initialValue: profileMobx.nativeLangList,
          onConfirm: (values) {
            selected.clear();
            profileMobx.nativeLangIdList.clear();
            profileMobx.nativeLangList.clear();

            values.forEach((element) {
              if (selected.contains(element)) {
              } else {
                selected.add(element);
              }
            });

            selected.forEach((element) {
              profileMobx.addLangToList(element as IdNameModel);
              profileMobx.addLangIdToList((element as IdNameModel).id);
              print("test = ${profileMobx.nativeLangIdList}");
            });
          },
        ),
      );
    },
  );
}

void selectIdName(
  BuildContext context, {
  required String text,
  required List<IdNameModel> list,
  required ProfileMobx profileMobx,
  required IdNameType type,
  bool? isLanguage,
}) {
  Size size = MediaQuery.of(context).size;
  setSearchQuery(type: type, profileMobx: profileMobx, val: '');
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return Observer(
        builder: (_) => AlertDialog(
          backgroundColor: Color(0xcc292929),
          actionsPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width / 2,
                  child: TextFormField(
                    cursorColor: Color(0xffe5003a),
                    onChanged: (val) {
                      setSearchQuery(
                          type: type, profileMobx: profileMobx, val: val);
                    },
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: text,
                      hintStyle: TextStyle(
                        color: Color(0xffc4c4c4),
                        fontSize: 13,
                        letterSpacing: 0.65,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Color(0xffc4c4c4),
                  size: 30,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: size.width / 1.5,
                    height: 1,
                    color: Color(0xffc4c4c4),
                  ),
                ),
                // SizedBox(
                //   height: size.height / 50,
                // ),
                Container(
                  height: size.height / 4,
                  width: size.width / 1.5,
                  child: ListView(
                    padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                    children: list.map((IdNameModel m) {
                      return getSearchQuery(
                                      type: type, profileMobx: profileMobx) ==
                                  null ||
                              getSearchQuery(
                                      type: type, profileMobx: profileMobx)!
                                  .isEmpty
                          ? GestureDetector(
                              child: Text(
                                isLanguage ?? false
                                    ? (m.name == 'ar'
                                        ? S.of(context).arabic
                                        : S.of(context).english)
                                    : m.name ?? "",
                                style: TextStyle(
                                  color: Color(0xffc4c4c4),
                                  fontSize: 13,
                                  letterSpacing: 0.65,
                                ),
                              ).paddingSymmetric(vertical: 8),
                              onTap: () {
                                setValue(type, m, profileMobx);
                                Navigator.of(context).pop();
                              },
                            )
                          : m.name!.toLowerCase().contains(getSearchQuery(
                                      type: type, profileMobx: profileMobx)!
                                  .toLowerCase())
                              ? GestureDetector(
                                  child: Text(
                                    isLanguage ?? false
                                        ? (m.name == 'ar'
                                            ? S.of(context).arabic
                                            : S.of(context).english)
                                        : m.name ?? "",
                                    style: TextStyle(
                                      color: Color(0xffc4c4c4),
                                      fontSize: 13,
                                      letterSpacing: 0.65,
                                    ),
                                  ).paddingSymmetric(vertical: 8),
                                  onTap: () {
                                    setValue(type, m, profileMobx);
                                    Navigator.of(context).pop();
                                  },
                                )
                              : Container();
                    }).toList(),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}

void setSearchQuery(
    {required IdNameType type,
    required String val,
    required ProfileMobx profileMobx}) {
  switch (type) {
    case IdNameType.children:
      profileMobx.setChildrenSearchQuery(val);
      break;
    case IdNameType.religion:
      profileMobx.setReligionSearchQuery(val);
      break;
    case IdNameType.job:
      profileMobx.setJobsSearchQuery(val);
      break;
    case IdNameType.socialType:
      profileMobx.setSocialTypesSearchQuery(val);
      break;
    case IdNameType.marriageType:
      profileMobx.setMarriageTypesSearchQuery(val);
      break;
    case IdNameType.education:
      profileMobx.setEducationSearchQuery(val);
      break;
    case IdNameType.skinColor:
      profileMobx.setSkinColorsSearchQuery(val);
      break;
    case IdNameType.bodyShape:
      profileMobx.setBodyShapesSearchQuery(val);
      break;
    case IdNameType.language:
      profileMobx.setLanguageSearchQuery(val);
      break;
    case IdNameType.smokeing:
      profileMobx.setLanguageSearchQuery(val);
      break;
    case IdNameType.drinking:
      profileMobx.setLanguageSearchQuery(val);
      break;
  }
}

void setValue(IdNameType type, IdNameModel val, ProfileMobx profileMobx) {
  switch (type) {
    case IdNameType.children:
      profileMobx.setChildren(val);
      break;
    case IdNameType.religion:
      profileMobx.setReligion(val);
      break;
    case IdNameType.job:
      profileMobx.setJob(val);
      break;
    case IdNameType.socialType:
      profileMobx.setSocialType(val);
      break;
    case IdNameType.marriageType:
      profileMobx.setMarriageType(val);
      break;
    case IdNameType.education:
      profileMobx.setEducation(val);
      break;
    case IdNameType.skinColor:
      profileMobx.setSkinColor(val);
      break;
    case IdNameType.bodyShape:
      profileMobx.setBodyShape(val);
      break;
    case IdNameType.language:
      profileMobx.setLanguage(val);
      break;
    case IdNameType.smokeing:
      profileMobx.setSmoking(val);
      break;
    case IdNameType.drinking:
      profileMobx.setDrinking(val);
      break;
  }
}

String? getSearchQuery(
    {required IdNameType type, required ProfileMobx profileMobx}) {
  switch (type) {
    case IdNameType.children:
      return profileMobx.childrenSearchQuery ?? null;
    case IdNameType.religion:
      return profileMobx.religionSearchQuery ?? null;
    case IdNameType.job:
      return profileMobx.jobsSearchQuery ?? null;
    case IdNameType.socialType:
      return profileMobx.socialTypesSearchQuery ?? null;
    case IdNameType.marriageType:
      return profileMobx.marriageTypesSearchQuery ?? null;
    case IdNameType.education:
      return profileMobx.educationSearchQuery ?? null;
    case IdNameType.skinColor:
      return profileMobx.skinColorsSearchQuery ?? null;
    case IdNameType.bodyShape:
      return profileMobx.bodyShapesSearchQuery ?? null;
    case IdNameType.language:
      return profileMobx.languageSearchQuery ?? null;
    case IdNameType.smokeing:
      return profileMobx.smokeSearchQuery ?? null;

    case IdNameType.drinking:
      return profileMobx.drinkSearchQuery ?? null;
  }
}

enum IdNameType {
  children,
  religion,
  job,
  smokeing,
  drinking,
  socialType,
  marriageType,
  education,
  skinColor,
  bodyShape,
  language
}

void dialogTextField(
  BuildContext context, {
  required String text,
  required ProfileMobx profileMobx,
  required DialogTextFieldType type,
  required String currentValue,
  required TextInputType textInputType,
}) {
  TextEditingController controller = TextEditingController();
  controller.text = currentValue;
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return Observer(
        builder: (_) => AlertDialog(
          backgroundColor: Color(0xcc292929),
          actionsPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                    child: Text(
                  text + " :",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ))
              ],
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SizedBox(
                    // height: 40,
                    child: TextFormField(
                      cursorColor: Color(0xffe5003a),
                      controller: controller,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.done,
                      keyboardType: textInputType,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: text,
                        hintStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          letterSpacing: 0.65,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white,
                          width: 0.50,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).cancel,
                          style: TextStyle(
                            color: Color(0xffc4c4c4),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      switch (type) {
                        case DialogTextFieldType.height:
                          profileMobx.setHeight(controller.text.toInt());
                          break;
                        case DialogTextFieldType.nickname:
                          profileMobx.setNickname(controller.text);
                          break;
                      }
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white,
                          width: 0.50,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).done,
                          style: TextStyle(
                            color: Color(0xffc4c4c4),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

enum DialogTextFieldType { height, nickname }

void smokingDialog(
  BuildContext context, {
  required ProfileMobx profileMobx,
}) {
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      Size size = MediaQuery.of(context).size;

      return Observer(
        builder: (_) => AlertDialog(
          backgroundColor: Color(0xcc292929),
          actionsPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    S.of(context).smoking,
                    style: TextStyle(
                      color: Color(0xffc4c4c4),
                      fontSize: 13,
                      letterSpacing: 0.65,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Color(0xffc4c4c4),
                  size: 30,
                )
              ],
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: Container(
                  width: size.width / 1.5,
                  height: 1,
                  color: Color(0xffc4c4c4),
                ),
              ),
              // SizedBox(
              //   height: size.height / 50,
              // ),
              Container(
                  height: size.height / 6,
                  width: size.width / 1.5,
                  child: ListView(
                      padding: EdgeInsets.all(10),
                      shrinkWrap: true,
                      children: [
                        GestureDetector(
                          child: Text(
                            S.of(context).yes,
                            style: TextStyle(
                              color: Color(0xffc4c4c4),
                              fontSize: 13,
                              letterSpacing: 0.65,
                            ),
                          ).paddingSymmetric(vertical: 8),
                          onTap: () {
                            profileMobx.setSmoking(true);
                            Navigator.of(context).pop();
                          },
                        ),
                        GestureDetector(
                          child: Text(
                            S.of(context).no,
                            style: TextStyle(
                              color: Color(0xffc4c4c4),
                              fontSize: 13,
                              letterSpacing: 0.65,
                            ),
                          ).paddingSymmetric(vertical: 8),
                          onTap: () {
                            profileMobx.setSmoking(false);
                            Navigator.of(context).pop();
                          },
                        )
                      ])),
            ]),

            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisSize: MainAxisSize.max,
            //       children: [
            //         Text(
            //           S.of(context).smoking,
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 18,
            //           ),
            //         ),
            //       ],
            //     ),
            //     Expanded(child: Container()),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisSize: MainAxisSize.max,
            //       children: [
            //         Transform.scale(
            //           alignment: Alignment.center,
            //           scale: 0.8,
            //           child: CupertinoSwitch(
            //             value: profileMobx.smoking != null
            //                 ? (profileMobx.smoking!)
            //                 : profileMobx.user!.otherInfo != null
            //                     ? (profileMobx.user!.otherInfo!.smoking ??
            //                         false)
            //                     : false,
            //             onChanged: (value) {
            //               profileMobx.setSmoking(value);
            //             },
            //           ).paddingTop(16),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
          ],
        ),
      );
    },
  );
}

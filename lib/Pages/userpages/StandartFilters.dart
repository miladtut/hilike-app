import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hilike/Networking/Mobx/search_mobx.dart';
import 'package:hilike/Networking/Mobx/signup_mobx.dart';
import 'package:hilike/Pages/userpages/SearchResults.dart';
import 'package:hilike/Utils/user_location.dart';
import 'package:hilike/Widget/CountryPop.dart';
import 'package:hilike/Widget/Navigation.dart';
import 'package:hilike/Widget/RangerRow.dart';
import 'package:hilike/Widget/SwitchRow.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:syncfusion_flutter_sliders/sliders.dart';

class StandartFilters extends StatefulWidget {
  final bool? isFromLikedYou;

  const StandartFilters({Key? key, this.isFromLikedYou = false})
      : super(key: key);

  @override
  _StandartFiltersState createState() => _StandartFiltersState();
}

class _StandartFiltersState extends State<StandartFilters>
    with AfterLayoutMixin {
  SignupMobx signupMobx = SignupController();
  SearchMobx searchMobx = SearchController();
  UserLocation? userLocation;
  @override
  Widget build(BuildContext context) {
    print(
        "${searchMobx.originCountry}  |||  ${signupMobx.originCountry == null} ");
    Size size = MediaQuery.of(context).size;
    return Observer(
      builder: (_) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Localizations.localeOf(context).languageCode.toString() == "ar"
                    ? Icons.arrow_back_ios
                    : Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 16,
              ),
            ),
            centerTitle: true,
            title: Text(
              S.of(context).filters,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w900,
                letterSpacing: 1.10,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Color(0xff292929),
            actions: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'Bmenu');
                  },
                  child: Container(
                      height: 14,
                      width: 20,
                      child: Image.asset(
                        "assets/img/menu.png",
                        matchTextDirection: true,
                      )),
                ),
              ),
            ],
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          searchMobx.setVip(false);

                          searchMobx.setOffset(0);
                          searchMobx.clearVip();
                          searchMobx.clearFeed();
                          if (widget.isFromLikedYou ?? false)
                            searchMobx.setLikedYou(true);
                          Searchresults(
                            searchMobx: searchMobx,
                            fromMain: false,
                          ).launch(context);
                        },
                        child: Container(
                          width: 109,
                          height: 34,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white,
                              width: 0.50,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              S.of(context).apply,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.75,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          searchMobx.resetFilter();
                          signupMobx.setResidenceCountry(null);
                          signupMobx.setOriginCountry(null);
                          signupMobx.setOriginSearchQuery("");
                          signupMobx.setResidenceSearchQuery("");
                          signupMobx.clearResidenceCountries();
                          signupMobx.clearOriginCountries();
                          if (widget.isFromLikedYou ?? false)
                            searchMobx.setLikedYou(true);
                          searchMobx.getFilter(context);
                        },
                        child: Container(
                          width: 109,
                          height: 34,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white,
                              width: 0.50,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              S.of(context).reset,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.75,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        body: ListView(
            padding: EdgeInsets.fromLTRB(20, 22, 20, 0),
            shrinkWrap: true,
            children: [
              Text(
                S.of(context).applyFiltersForSearch,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.90,
                ),
              ),
              SizedBox(
                height: size.height / 90,
              ),
              Text(
                S.of(context).hereYouCanSetUpFiltersForBetterSearch,
                style: TextStyle(
                  color: Color(0xfff5f5f5),
                  fontSize: 13,
                  letterSpacing: 0.65,
                ),
              ),
              SizedBox(
                height: size.height / 35,
              ),
              SwitchRow(
                title: S.of(context).onlineNow,
                text: S.of(context).selectUsersWhoAreOnlineNow,
                value: searchMobx.online == 1,
                onChange: (val) {
                  searchMobx.setOnline(val ? 1 : 0);
                },
              ),
              SwitchRow(
                title: S.of(context).withPhoto,
                text: S.of(context).selectOnlyUsersWithPhoto,
                value: searchMobx.withImage == 1,
                onChange: (val) {
                  searchMobx.setWithImage(val ? 1 : 0);
                },
              ),
              SwitchRow(
                title: S.of(context).nearby,
                text: S.of(context).selectOnlyUsersNearMe,
                value: searchMobx.nearby == 1,
                onChange: (val) {
                  searchMobx.setNearby(val ? 1 : 0);
                },
              ),
              SizedBox(
                height: size.height / 40,
              ),
              CountryPop(
                withTitle: true,
                type: S.of(context).origin,
                signupMobx: signupMobx,
                onSelect: (mobx) {
                  signupMobx = mobx;
                  searchMobx.setOriginCountry(mobx.originCountry);
                },
                iconPressed: () {
                  signupMobx.setOriginCountry(null);
                  searchMobx.setOriginCountry(null);
                  setState(() {});
                },
              ),
              CountryPop(
                withTitle: true,
                type: S.of(context).residence,
                signupMobx: signupMobx,
                onSelect: (mobx) {
                  signupMobx = mobx;
                  searchMobx.setResidenceCountry(mobx.residenceCountry);
                },
                iconPressed: () {
                  signupMobx.setResidenceCountry(null);
                  searchMobx.setResidenceCountry(null);
                  setState(() {});
                },
              ),
              RangerRow(
                para: S.of(context).km,
                title: S.of(context).distance,
                iswhite: false,
                values: SfRangeValues(
                    (searchMobx.filterMinDistance ?? 0).toDouble(),
                    (searchMobx.filterMaxDistance ?? 100).toDouble()),
                onChange: (val) {
                  searchMobx.setMinDistance(val.start.toInt());
                  searchMobx.setMaxDistance(val.end.toInt());
                  searchMobx.setFilterMinDistance(val.start.toInt());
                  searchMobx.setFilterMaxDistance(val.end.toInt());
                },
              ),
              if (searchMobx.filterMinAge != null)
                RangerRow(
                  para: S.of(context).years,
                  title: S.of(context).age,
                  iswhite: true,
                  values: SfRangeValues(
                      (searchMobx.filterMinAge ?? 18).toDouble(),
                      (searchMobx.filterMaxAge ?? 65).toDouble()),
                  onChange: (val) {
                    searchMobx.setMinAge(val.start.toInt());
                    searchMobx.setMaxAge(val.end.toInt());
                    searchMobx.setFilterMinAge(val.start.toInt());
                    searchMobx.setFilterMaxAge(val.end.toInt());
                  },
                ),
              Text(
                S.of(context).lastVisit,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.75,
                ),
              ),
              Row(children: <Widget>[
                Expanded(flex: searchMobx.lastVisit ?? 1, child: SizedBox()),
                Container(
                  width: 54,
                  child: Text(
                    searchMobx.filterMaxLastVisit == searchMobx.lastVisit
                        ? S.of(context).seeAll
                        : "${searchMobx.lastVisit ?? 30} ${S.of(context).days}",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                    flex: (searchMobx.filterMaxLastVisit ?? 30) -
                        (searchMobx.lastVisit ?? 30),
                    child: SizedBox()),
              ]),
              Stack(children: [
                Positioned(
                  height: 47.7,
                  left: 13.82,
                  child: Container(
                    width: 19,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Localizations.localeOf(context)
                                  .languageCode
                                  .toString() ==
                              "ar"
                          ? Color(0xffc4c4c4)
                          : Color(0xffe5003a),
                    ),
                  ),
                ),
                Positioned(
                  height: 47.7,
                  right: 14,
                  child: Container(
                    width: 19,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Localizations.localeOf(context)
                                  .languageCode
                                  .toString() ==
                              "ar"
                          ? Color(0xffe5003a)
                          : Color(0xffc4c4c4),
                    ),
                  ),
                ),
                SliderTheme(
                  data: SliderThemeData(
                      thumbColor: Color(0xffe5003a),
                      activeTrackColor: Color(0xffc4c4c4),
                      trackHeight: 2),
                  child: Slider(
                    activeColor: Color(0xffe5003a),
                    inactiveColor: Color(0xffc4c4c4),
                    value: (searchMobx.lastVisit ?? 30).toDouble(),
                    min: (searchMobx.filterMinLastVisit ?? 0).toDouble(),
                    max: (searchMobx.filterMaxLastVisit ?? 30).toDouble(),
                    // label: ("_sliderValue.round().toString()"),
                    onChanged: (value) {
                      searchMobx.setLastVisit(value.round());
                    },
                  ),
                ),
              ]),
              SizedBox(
                height: size.height / 25,
              ),
            ]),
        bottomNavigationBar: NavigationRow(
          currentIndex: 5,
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    userLocation = UserLocation(context);
    searchMobx
        .getFilter(context)
        .then((value) => userLocation!.getUserLocation(filter: true));
  }
}

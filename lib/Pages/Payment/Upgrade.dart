import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hilike/Models/plan.dart';
import 'package:hilike/Models/plan_package.dart';
import 'package:hilike/Networking/Mobx/plans_mobx.dart';
import 'package:hilike/Pages/MainPages/MainMenu.dart';
import 'package:hilike/Storage/Storage.dart';
import 'package:hilike/Widget/Appbar60.dart';
import 'package:hilike/Widget/ExpandablePageView.dart';
import 'package:hilike/Widget/GoldPlan.dart';
import 'package:hilike/Widget/UpgradeWidget.dart';
import 'package:hilike/Widget/VipPlan.dart';
import 'package:hilike/Widget/paymentconfirem.dart';
import 'package:hilike/generated/l10n.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class Upgrade extends StatefulWidget {
  @override
  _UpgradeState createState() => _UpgradeState();
}

class _UpgradeState extends State<Upgrade> with AfterLayoutMixin {
  PageController pageController = PageController();
  PlansMobx plansMobx = PlansController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Observer(
      builder: (_) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Appbar60(
            title: S.of(context).upgrade,
          ),
        ),
        body: plansMobx.plans.isEmpty
            ? Container()
            : ListView(
                shrinkWrap: true,
                children: [
                  Stack(
                    children: [
                      ExpandablePageView(
                        pageController: pageController,
                        onPageChanged: (page) {
                          plansMobx.setPageIndex(page);
                        },
                        children: [
                          for (PlanModel item in plansMobx.plans)
                            // if (item != plansMobx.plans[0])
                            UpgradeWidget(
                              color: item.name == "Vip"
                                  ? Color(0xffe5003a)
                                  : item.name == "Gold"
                                      ? Color(0xffFFAC30)
                                      : Colors.black54,
                              name: item.name ?? "",
                              pageIndex: plansMobx.pageIndex,
                              pagesCount: plansMobx.plans.length,
                              descriptionList: item.name == "Vip"
                                  ? getVipDescription()
                                  : item.name == "Gold"
                                      ? getGoldDescription()
                                      : [],
                            ),
                        ],
                      ),
                    ],
                  ),
                  if (plansMobx.plans[plansMobx.pageIndex].name != "Vip")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          S.of(context).choosePackage,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.90,
                          ),
                        ).paddingSymmetric(horizontal: 16),
                        SizedBox(
                          height: size.height / 90,
                        ),
                        Text(
                          S.of(context).thereIsNoAutomaticRenewalAfterPurchase,
                          style: TextStyle(
                            color: Color(0xffc4c4c4),
                            fontSize: 13,
                          ),
                        ).paddingSymmetric(horizontal: 16),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  plansMobx.plans[plansMobx.pageIndex].name == "Vip"
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          itemCount: plansMobx
                                  .plans[plansMobx.pageIndex].packages!.length +
                              1,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 800),
                              child: SlideAnimation(
                                verticalOffset: 100.0,
                                child: FadeInAnimation(
                                  child:
                                      Builder(builder: (BuildContext context) {
                                    if (index == 0) {
                                      PlanModel plan =
                                          plansMobx.plans[plansMobx.pageIndex];
                                      return VipPlan(
                                        name: plan.name ?? "",
                                        months: 1,
                                        per: 0,
                                        id: 0,
                                        price: plan.price ?? 0.0,
                                        packagePrice: plan.price ?? 0.0,
                                        onClick: () {
                                          plansMobx.setSelectedIndex(0);
                                        },
                                        index: 0,
                                        plansMobx: plansMobx,
                                      ).paddingBottom(10);
                                    } else {
                                      PlanModel plan =
                                          plansMobx.plans[plansMobx.pageIndex];
                                      PlanPackageModel item =
                                          plan.packages![index - 1];
                                      return VipPlan(
                                        name: plan.name ?? "",
                                        months: item.months ?? 1,
                                        price: (item.price ?? 0.0),
                                        packagePrice: item.old_price ?? 0.0,
                                        per: item.percantage ?? 0,
                                        id: item.id ?? 0,
                                        onClick: () {
                                          plansMobx.setSelectedIndex(index);
                                        },
                                        index: index,
                                        plansMobx: plansMobx,
                                      ).paddingBottom(10);
                                    }
                                  }),
                                ),
                              ),
                            );
                          },
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: size.width / 3,
                            childAspectRatio: 0.85,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: plansMobx
                                  .plans[plansMobx.pageIndex].packages!.length +
                              1,
                          itemBuilder: (ctx, index) {
                            return AnimationConfiguration.staggeredGrid(
                                columnCount: 3,
                                position: index,
                                duration: const Duration(milliseconds: 800),
                                child: SlideAnimation(
                                    verticalOffset: 100.0,
                                    child: FadeInAnimation(
                                      child: Builder(
                                          builder: (BuildContext context) {
                                        if (index == 0) {
                                          PlanModel plan = plansMobx
                                              .plans[plansMobx.pageIndex];
                                          return GoldPlan(
                                            name: plan.name ?? "",
                                            months: 1,
                                            id: plan.id ?? 0,
                                            price: plan.price ?? 0.0,
                                            packagePrice: plan.price ?? 0.0,
                                            per: 5,
                                            onClick: () {
                                              plansMobx.setSelectedIndex(0);
                                            },
                                            index: 0,
                                            plansMobx: plansMobx,
                                          );
                                        } else {
                                          PlanModel plan = plansMobx
                                              .plans[plansMobx.pageIndex];
                                          PlanPackageModel item =
                                              plan.packages![index - 1];
                                          return GoldPlan(
                                            name: plan.name ?? "",
                                            id: item.id ?? 0,
                                            months: item.months ?? 1,
                                            price: (item.price ?? 0.0),
                                            packagePrice: item.old_price ?? 0.0,
                                            per: item.percantage ?? 0,
                                            onClick: () {
                                              plansMobx.setSelectedIndex(index);
                                            },
                                            index: index,
                                            plansMobx: plansMobx,
                                          );
                                        }
                                      }),
                                    )));
                          }).paddingSymmetric(horizontal: 16),
                  SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible:
                        plansMobx.plans[plansMobx.pageIndex].name == "Gold" &&
                                plansMobx.isfreeTrial == "1"
                            ? true
                            : false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 17,
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          await plansMobx.freeTrial(context);
                          if (plansMobx.freeTrialRes == true) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return PaymentConf(
                                    free: true, status: true, fromCoins: false);
                              },
                            );
                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Mainmenu()),
                                ModalRoute.withName('/'),
                              );
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return PaymentConf(
                                    free: true,
                                    status: false,
                                    fromCoins: false);
                              },
                            );
                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.pop(
                                context,
                              );
                            });
                          }
                        },
                        child: Text(
                          S.of(context).freeTrial,
                          style: TextStyle(
                            color: Color(0xff0583f2),
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).ifYouNeedHelpPlease,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0.65,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'Steam',
                              arguments: [0, storage.account.plan]);
                        },
                        child: Text(
                          S.of(context).contactUs,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff0583f2),
                            fontFamily: 'Roboto',
                            fontSize: 13,
                            letterSpacing: 0.65,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                ],
              ),
      ),
    );
  }

  List<String> getGoldDescription() {
    List<String> list =
        Localizations.localeOf(context).languageCode.toString() == "ar"
            ? plansMobx.plans[0].ar_description!
            : plansMobx.plans[0].description!;
    // list.add(plansMobx.plans[0].ar_description![0]);
    // list.add(S.of(context).unlimitedChat);
    // list.add(S.of(context).priorityAppearingAtTheTopOfThePage);
    return list;
  }

  List<String> getVipDescription() {
    List<String> list =
        Localizations.localeOf(context).languageCode.toString() == "ar"
            ? plansMobx.plans[1].ar_description!
            : plansMobx.plans[1].description!;
    // list.add(S.of(context).advancedSearch);
    // list.add(S.of(context).unlimitedChat);
    // list.add(S.of(context).priorityAppearingAtTheTopOfThePage);

    // list.add(S.of(context).priorityAppearingAtTheTopOfTheChat);
    return list;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    plansMobx.getPlans(context);
  }
}

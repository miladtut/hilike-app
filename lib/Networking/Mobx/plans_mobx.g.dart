// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plans_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlansController on PlansMobx, Store {
  final _$pageIndexAtom = Atom(name: 'PlansMobx.pageIndex');

  @override
  int get pageIndex {
    _$pageIndexAtom.reportRead();
    return super.pageIndex;
  }

  @override
  set pageIndex(int value) {
    _$pageIndexAtom.reportWrite(value, super.pageIndex, () {
      super.pageIndex = value;
    });
  }

  final _$isfreeTrialAtom = Atom(name: 'PlansMobx.isfreeTrial');

  @override
  String get isfreeTrial {
    _$isfreeTrialAtom.reportRead();
    return super.isfreeTrial;
  }

  @override
  set isfreeTrial(String value) {
    _$isfreeTrialAtom.reportWrite(value, super.isfreeTrial, () {
      super.isfreeTrial = value;
    });
  }

  final _$selectedIndexAtom = Atom(name: 'PlansMobx.selectedIndex');

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  final _$balanceAtom = Atom(name: 'PlansMobx.balance');

  @override
  int? get balance {
    _$balanceAtom.reportRead();
    return super.balance;
  }

  @override
  set balance(int? value) {
    _$balanceAtom.reportWrite(value, super.balance, () {
      super.balance = value;
    });
  }

  final _$purlAtom = Atom(name: 'PlansMobx.purl');

  @override
  String? get purl {
    _$purlAtom.reportRead();
    return super.purl;
  }

  @override
  set purl(String? value) {
    _$purlAtom.reportWrite(value, super.purl, () {
      super.purl = value;
    });
  }

  final _$freeTrialResAtom = Atom(name: 'PlansMobx.freeTrialRes');

  @override
  bool? get freeTrialRes {
    _$freeTrialResAtom.reportRead();
    return super.freeTrialRes;
  }

  @override
  set freeTrialRes(bool? value) {
    _$freeTrialResAtom.reportWrite(value, super.freeTrialRes, () {
      super.freeTrialRes = value;
    });
  }

  final _$ApplePayAtom = Atom(name: 'PlansMobx.ApplePay');

  @override
  dynamic get ApplePay {
    _$ApplePayAtom.reportRead();
    return super.ApplePay;
  }

  @override
  set ApplePay(dynamic value) {
    _$ApplePayAtom.reportWrite(value, super.ApplePay, () {
      super.ApplePay = value;
    });
  }

  final _$reqestApiAtom = Atom(name: 'PlansMobx.reqestApi');

  @override
  bool? get reqestApi {
    _$reqestApiAtom.reportRead();
    return super.reqestApi;
  }

  @override
  set reqestApi(bool? value) {
    _$reqestApiAtom.reportWrite(value, super.reqestApi, () {
      super.reqestApi = value;
    });
  }

  final _$canpayAtom = Atom(name: 'PlansMobx.canpay');

  @override
  bool? get canpay {
    _$canpayAtom.reportRead();
    return super.canpay;
  }

  @override
  set canpay(bool? value) {
    _$canpayAtom.reportWrite(value, super.canpay, () {
      super.canpay = value;
    });
  }

  final _$getPlansAsyncAction = AsyncAction('PlansMobx.getPlans');

  @override
  Future<void> getPlans(BuildContext context) {
    return _$getPlansAsyncAction.run(() => super.getPlans(context));
  }

  final _$getCoinsAsyncAction = AsyncAction('PlansMobx.getCoins');

  @override
  Future<void> getCoins(BuildContext context) {
    return _$getCoinsAsyncAction.run(() => super.getCoins(context));
  }

  final _$freeTrialAsyncAction = AsyncAction('PlansMobx.freeTrial');

  @override
  Future<void> freeTrial(BuildContext context) {
    return _$freeTrialAsyncAction.run(() => super.freeTrial(context));
  }

  final _$sendGiftAsyncAction = AsyncAction('PlansMobx.sendGift');

  @override
  Future<void> sendGift(BuildContext context, int giftId, String userId) {
    return _$sendGiftAsyncAction
        .run(() => super.sendGift(context, giftId, userId));
  }

  final _$getMyBalanceAsyncAction = AsyncAction('PlansMobx.getMyBalance');

  @override
  Future<void> getMyBalance(BuildContext context) {
    return _$getMyBalanceAsyncAction.run(() => super.getMyBalance(context));
  }

  final _$paymentStrebAsyncAction = AsyncAction('PlansMobx.paymentStreb');

  @override
  Future<void> paymentStreb(BuildContext context, String id, String methodpay) {
    return _$paymentStrebAsyncAction
        .run(() => super.paymentStreb(context, id, methodpay));
  }

  final _$paymentStrebplanAsyncAction =
      AsyncAction('PlansMobx.paymentStrebplan');

  @override
  Future<void> paymentStrebplan(
      BuildContext context, String id, String methodpay) {
    return _$paymentStrebplanAsyncAction
        .run(() => super.paymentStrebplan(context, id, methodpay));
  }

  final _$applePayAsyncAction = AsyncAction('PlansMobx.applePay');

  @override
  Future<void> applePay(BuildContext context, String id) {
    return _$applePayAsyncAction.run(() => super.applePay(context, id));
  }

  final _$paymentStrebplanwithPackageAsyncAction =
      AsyncAction('PlansMobx.paymentStrebplanwithPackage');

  @override
  Future<void> paymentStrebplanwithPackage(
      BuildContext context, String id, String methodpay, int pid) {
    return _$paymentStrebplanwithPackageAsyncAction.run(
        () => super.paymentStrebplanwithPackage(context, id, methodpay, pid));
  }

  final _$PlansMobxActionController = ActionController(name: 'PlansMobx');

  @override
  dynamic setReqestApi(dynamic val) {
    final _$actionInfo =
        _$PlansMobxActionController.startAction(name: 'PlansMobx.setReqestApi');
    try {
      return super.setReqestApi(val);
    } finally {
      _$PlansMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCanPay(dynamic val) {
    final _$actionInfo =
        _$PlansMobxActionController.startAction(name: 'PlansMobx.setCanPay');
    try {
      return super.setCanPay(val);
    } finally {
      _$PlansMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setApplePay(dynamic val) {
    final _$actionInfo =
        _$PlansMobxActionController.startAction(name: 'PlansMobx.setApplePay');
    try {
      return super.setApplePay(val);
    } finally {
      _$PlansMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPageIndex(dynamic val) {
    final _$actionInfo =
        _$PlansMobxActionController.startAction(name: 'PlansMobx.setPageIndex');
    try {
      return super.setPageIndex(val);
    } finally {
      _$PlansMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFreeTrialval(dynamic val) {
    final _$actionInfo = _$PlansMobxActionController.startAction(
        name: 'PlansMobx.setFreeTrialval');
    try {
      return super.setFreeTrialval(val);
    } finally {
      _$PlansMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFreeTrialonRes(dynamic val) {
    final _$actionInfo = _$PlansMobxActionController.startAction(
        name: 'PlansMobx.setFreeTrialonRes');
    try {
      return super.setFreeTrialonRes(val);
    } finally {
      _$PlansMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedIndex(dynamic val) {
    final _$actionInfo = _$PlansMobxActionController.startAction(
        name: 'PlansMobx.setSelectedIndex');
    try {
      return super.setSelectedIndex(val);
    } finally {
      _$PlansMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pageIndex: ${pageIndex},
isfreeTrial: ${isfreeTrial},
selectedIndex: ${selectedIndex},
balance: ${balance},
purl: ${purl},
freeTrialRes: ${freeTrialRes},
ApplePay: ${ApplePay},
reqestApi: ${reqestApi},
canpay: ${canpay}
    ''';
  }
}

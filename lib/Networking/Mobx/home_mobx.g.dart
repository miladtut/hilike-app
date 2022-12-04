// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on HomeMobx, Store {
  final _$profileProgressAtom = Atom(name: 'HomeMobx.profileProgress');

  @override
  int? get profileProgress {
    _$profileProgressAtom.reportRead();
    return super.profileProgress;
  }

  @override
  set profileProgress(int? value) {
    _$profileProgressAtom.reportWrite(value, super.profileProgress, () {
      super.profileProgress = value;
    });
  }

  final _$messageAtom = Atom(name: 'HomeMobx.message');

  @override
  String? get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(String? value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  final _$isbanAtom = Atom(name: 'HomeMobx.isban');

  @override
  bool? get isban {
    _$isbanAtom.reportRead();
    return super.isban;
  }

  @override
  set isban(bool? value) {
    _$isbanAtom.reportWrite(value, super.isban, () {
      super.isban = value;
    });
  }

  final _$expiredAtom = Atom(name: 'HomeMobx.expired');

  @override
  String? get expired {
    _$expiredAtom.reportRead();
    return super.expired;
  }

  @override
  set expired(String? value) {
    _$expiredAtom.reportWrite(value, super.expired, () {
      super.expired = value;
    });
  }

  final _$welcomeMessageAtom = Atom(name: 'HomeMobx.welcomeMessage');

  @override
  String? get welcomeMessage {
    _$welcomeMessageAtom.reportRead();
    return super.welcomeMessage;
  }

  @override
  set welcomeMessage(String? value) {
    _$welcomeMessageAtom.reportWrite(value, super.welcomeMessage, () {
      super.welcomeMessage = value;
    });
  }

  final _$getEditNotificationStatusAsyncAction =
      AsyncAction('HomeMobx.getEditNotificationStatus');

  @override
  Future<void> getEditNotificationStatus(BuildContext context) {
    return _$getEditNotificationStatusAsyncAction
        .run(() => super.getEditNotificationStatus(context));
  }

  final _$getHomeAsyncAction = AsyncAction('HomeMobx.getHome');

  @override
  Future<void> getHome(BuildContext context,
      {double lat = 0.0, double long = 0.0}) {
    return _$getHomeAsyncAction
        .run(() => super.getHome(context, lat: lat, long: long));
  }

  final _$HomeMobxActionController = ActionController(name: 'HomeMobx');

  @override
  void setMessage(dynamic val) {
    final _$actionInfo =
        _$HomeMobxActionController.startAction(name: 'HomeMobx.setMessage');
    try {
      return super.setMessage(val);
    } finally {
      _$HomeMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWelcomeMessage(dynamic val) {
    final _$actionInfo = _$HomeMobxActionController.startAction(
        name: 'HomeMobx.setWelcomeMessage');
    try {
      return super.setWelcomeMessage(val);
    } finally {
      _$HomeMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsban(dynamic val) {
    final _$actionInfo =
        _$HomeMobxActionController.startAction(name: 'HomeMobx.setIsban');
    try {
      return super.setIsban(val);
    } finally {
      _$HomeMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExpired(dynamic val) {
    final _$actionInfo =
        _$HomeMobxActionController.startAction(name: 'HomeMobx.setExpired');
    try {
      return super.setExpired(val);
    } finally {
      _$HomeMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
profileProgress: ${profileProgress},
message: ${message},
isban: ${isban},
expired: ${expired},
welcomeMessage: ${welcomeMessage}
    ''';
  }
}

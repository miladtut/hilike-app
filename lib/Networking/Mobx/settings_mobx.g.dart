// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsController on SettingsMobx, Store {
  final _$locationEnabledAtom = Atom(name: 'SettingsMobx.locationEnabled');

  @override
  bool get locationEnabled {
    _$locationEnabledAtom.reportRead();
    return super.locationEnabled;
  }

  @override
  set locationEnabled(bool value) {
    _$locationEnabledAtom.reportWrite(value, super.locationEnabled, () {
      super.locationEnabled = value;
    });
  }

  final _$accountShowedAtom = Atom(name: 'SettingsMobx.accountShowed');

  @override
  bool get accountShowed {
    _$accountShowedAtom.reportRead();
    return super.accountShowed;
  }

  @override
  set accountShowed(bool value) {
    _$accountShowedAtom.reportWrite(value, super.accountShowed, () {
      super.accountShowed = value;
    });
  }

  final _$emailAtom = Atom(name: 'SettingsMobx.email');

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$usernameAtom = Atom(name: 'SettingsMobx.username');

  @override
  String? get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String? value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  final _$currentPasswordAtom = Atom(name: 'SettingsMobx.currentPassword');

  @override
  String? get currentPassword {
    _$currentPasswordAtom.reportRead();
    return super.currentPassword;
  }

  @override
  set currentPassword(String? value) {
    _$currentPasswordAtom.reportWrite(value, super.currentPassword, () {
      super.currentPassword = value;
    });
  }

  final _$newPasswordAtom = Atom(name: 'SettingsMobx.newPassword');

  @override
  String? get newPassword {
    _$newPasswordAtom.reportRead();
    return super.newPassword;
  }

  @override
  set newPassword(String? value) {
    _$newPasswordAtom.reportWrite(value, super.newPassword, () {
      super.newPassword = value;
    });
  }

  final _$confirmNewPasswordAtom =
      Atom(name: 'SettingsMobx.confirmNewPassword');

  @override
  String? get confirmNewPassword {
    _$confirmNewPasswordAtom.reportRead();
    return super.confirmNewPassword;
  }

  @override
  set confirmNewPassword(String? value) {
    _$confirmNewPasswordAtom.reportWrite(value, super.confirmNewPassword, () {
      super.confirmNewPassword = value;
    });
  }

  final _$hideCurrentPasswordAtom =
      Atom(name: 'SettingsMobx.hideCurrentPassword');

  @override
  bool get hideCurrentPassword {
    _$hideCurrentPasswordAtom.reportRead();
    return super.hideCurrentPassword;
  }

  @override
  set hideCurrentPassword(bool value) {
    _$hideCurrentPasswordAtom.reportWrite(value, super.hideCurrentPassword, () {
      super.hideCurrentPassword = value;
    });
  }

  final _$hideNewPasswordAtom = Atom(name: 'SettingsMobx.hideNewPassword');

  @override
  bool get hideNewPassword {
    _$hideNewPasswordAtom.reportRead();
    return super.hideNewPassword;
  }

  @override
  set hideNewPassword(bool value) {
    _$hideNewPasswordAtom.reportWrite(value, super.hideNewPassword, () {
      super.hideNewPassword = value;
    });
  }

  final _$hideConfirmNewPasswordAtom =
      Atom(name: 'SettingsMobx.hideConfirmNewPassword');

  @override
  bool get hideConfirmNewPassword {
    _$hideConfirmNewPasswordAtom.reportRead();
    return super.hideConfirmNewPassword;
  }

  @override
  set hideConfirmNewPassword(bool value) {
    _$hideConfirmNewPasswordAtom
        .reportWrite(value, super.hideConfirmNewPassword, () {
      super.hideConfirmNewPassword = value;
    });
  }

  final _$share_locationAtom = Atom(name: 'SettingsMobx.share_location');

  @override
  int? get share_location {
    _$share_locationAtom.reportRead();
    return super.share_location;
  }

  @override
  set share_location(int? value) {
    _$share_locationAtom.reportWrite(value, super.share_location, () {
      super.share_location = value;
    });
  }

  final _$show_accountAtom = Atom(name: 'SettingsMobx.show_account');

  @override
  int? get show_account {
    _$show_accountAtom.reportRead();
    return super.show_account;
  }

  @override
  set show_account(int? value) {
    _$show_accountAtom.reportWrite(value, super.show_account, () {
      super.show_account = value;
    });
  }

  final _$doneChaningAtom = Atom(name: 'SettingsMobx.doneChaning');

  @override
  String? get doneChaning {
    _$doneChaningAtom.reportRead();
    return super.doneChaning;
  }

  @override
  set doneChaning(String? value) {
    _$doneChaningAtom.reportWrite(value, super.doneChaning, () {
      super.doneChaning = value;
    });
  }

  final _$setLocationEnabledAsyncAction =
      AsyncAction('SettingsMobx.setLocationEnabled');

  @override
  Future<void> setLocationEnabled(BuildContext context,
      {bool val = true, bool fromLocal = true}) {
    return _$setLocationEnabledAsyncAction.run(() =>
        super.setLocationEnabled(context, val: val, fromLocal: fromLocal));
  }

  final _$setAccountShowedAsyncAction =
      AsyncAction('SettingsMobx.setAccountShowed');

  @override
  Future<void> setAccountShowed(BuildContext context,
      {bool val = true, bool fromLocal = true}) {
    return _$setAccountShowedAsyncAction.run(
        () => super.setAccountShowed(context, val: val, fromLocal: fromLocal));
  }

  final _$settingValuesAsyncAction = AsyncAction('SettingsMobx.settingValues');

  @override
  Future<void> settingValues(BuildContext context) {
    return _$settingValuesAsyncAction.run(() => super.settingValues(context));
  }

  final _$enableLocationAsyncAction =
      AsyncAction('SettingsMobx.enableLocation');

  @override
  Future<bool> enableLocation(BuildContext context, {bool enable = true}) {
    return _$enableLocationAsyncAction
        .run(() => super.enableLocation(context, enable: enable));
  }

  final _$showAccountAsyncAction = AsyncAction('SettingsMobx.showAccount');

  @override
  Future<bool> showAccount(BuildContext context, {bool enable = true}) {
    return _$showAccountAsyncAction
        .run(() => super.showAccount(context, enable: enable));
  }

  final _$switchLanguageAsyncAction =
      AsyncAction('SettingsMobx.switchLanguage');

  @override
  Future<void> switchLanguage(BuildContext context, {String lang = "ar"}) {
    return _$switchLanguageAsyncAction
        .run(() => super.switchLanguage(context, lang: lang));
  }

  final _$changePasswordAsyncAction =
      AsyncAction('SettingsMobx.changePassword');

  @override
  Future<bool> changePassword(BuildContext context) {
    return _$changePasswordAsyncAction.run(() => super.changePassword(context));
  }

  final _$SettingsMobxActionController = ActionController(name: 'SettingsMobx');

  @override
  void setIsChanged(dynamic val) {
    final _$actionInfo = _$SettingsMobxActionController.startAction(
        name: 'SettingsMobx.setIsChanged');
    try {
      return super.setIsChanged(val);
    } finally {
      _$SettingsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShareLocation(dynamic val) {
    final _$actionInfo = _$SettingsMobxActionController.startAction(
        name: 'SettingsMobx.setShareLocation');
    try {
      return super.setShareLocation(val);
    } finally {
      _$SettingsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShowAccount(dynamic val) {
    final _$actionInfo = _$SettingsMobxActionController.startAction(
        name: 'SettingsMobx.setShowAccount');
    try {
      return super.setShowAccount(val);
    } finally {
      _$SettingsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(dynamic val) {
    final _$actionInfo = _$SettingsMobxActionController.startAction(
        name: 'SettingsMobx.setEmail');
    try {
      return super.setEmail(val);
    } finally {
      _$SettingsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUsername(dynamic val) {
    final _$actionInfo = _$SettingsMobxActionController.startAction(
        name: 'SettingsMobx.setUsername');
    try {
      return super.setUsername(val);
    } finally {
      _$SettingsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentPassword(dynamic val) {
    final _$actionInfo = _$SettingsMobxActionController.startAction(
        name: 'SettingsMobx.setCurrentPassword');
    try {
      return super.setCurrentPassword(val);
    } finally {
      _$SettingsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewPassword(dynamic val) {
    final _$actionInfo = _$SettingsMobxActionController.startAction(
        name: 'SettingsMobx.setNewPassword');
    try {
      return super.setNewPassword(val);
    } finally {
      _$SettingsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmNewPassword(dynamic val) {
    final _$actionInfo = _$SettingsMobxActionController.startAction(
        name: 'SettingsMobx.setConfirmNewPassword');
    try {
      return super.setConfirmNewPassword(val);
    } finally {
      _$SettingsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHideCurrentPassword(dynamic val) {
    final _$actionInfo = _$SettingsMobxActionController.startAction(
        name: 'SettingsMobx.setHideCurrentPassword');
    try {
      return super.setHideCurrentPassword(val);
    } finally {
      _$SettingsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHideNewPassword(dynamic val) {
    final _$actionInfo = _$SettingsMobxActionController.startAction(
        name: 'SettingsMobx.setHideNewPassword');
    try {
      return super.setHideNewPassword(val);
    } finally {
      _$SettingsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHideConfirmNewPassword(dynamic val) {
    final _$actionInfo = _$SettingsMobxActionController.startAction(
        name: 'SettingsMobx.setHideConfirmNewPassword');
    try {
      return super.setHideConfirmNewPassword(val);
    } finally {
      _$SettingsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locationEnabled: ${locationEnabled},
accountShowed: ${accountShowed},
email: ${email},
username: ${username},
currentPassword: ${currentPassword},
newPassword: ${newPassword},
confirmNewPassword: ${confirmNewPassword},
hideCurrentPassword: ${hideCurrentPassword},
hideNewPassword: ${hideNewPassword},
hideConfirmNewPassword: ${hideConfirmNewPassword},
share_location: ${share_location},
show_account: ${show_account},
doneChaning: ${doneChaning}
    ''';
  }
}

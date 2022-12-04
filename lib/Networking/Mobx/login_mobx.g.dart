// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on LoginMobx, Store {
  final _$emailAtom = Atom(name: 'LoginMobx.email');

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

  final _$device_tokenAtom = Atom(name: 'LoginMobx.device_token');

  @override
  String? get device_token {
    _$device_tokenAtom.reportRead();
    return super.device_token;
  }

  @override
  set device_token(String? value) {
    _$device_tokenAtom.reportWrite(value, super.device_token, () {
      super.device_token = value;
    });
  }

  final _$passwordAtom = Atom(name: 'LoginMobx.password');

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$hidePasswordAtom = Atom(name: 'LoginMobx.hidePassword');

  @override
  bool get hidePassword {
    _$hidePasswordAtom.reportRead();
    return super.hidePassword;
  }

  @override
  set hidePassword(bool value) {
    _$hidePasswordAtom.reportWrite(value, super.hidePassword, () {
      super.hidePassword = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('LoginMobx.login');

  @override
  Future<void> login(BuildContext context, {Function? onSuccess}) {
    return _$loginAsyncAction
        .run(() => super.login(context, onSuccess: onSuccess));
  }

  final _$logoutAsyncAction = AsyncAction('LoginMobx.logout');

  @override
  Future<void> logout(BuildContext context, {Function? onSuccess}) {
    return _$logoutAsyncAction
        .run(() => super.logout(context, onSuccess: onSuccess));
  }

  final _$LoginMobxActionController = ActionController(name: 'LoginMobx');

  @override
  void setEmail(dynamic val) {
    final _$actionInfo =
        _$LoginMobxActionController.startAction(name: 'LoginMobx.setEmail');
    try {
      return super.setEmail(val);
    } finally {
      _$LoginMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(dynamic val) {
    final _$actionInfo =
        _$LoginMobxActionController.startAction(name: 'LoginMobx.setPassword');
    try {
      return super.setPassword(val);
    } finally {
      _$LoginMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDeviceToken(dynamic val) {
    final _$actionInfo = _$LoginMobxActionController.startAction(
        name: 'LoginMobx.setDeviceToken');
    try {
      return super.setDeviceToken(val);
    } finally {
      _$LoginMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHidePassword(dynamic val) {
    final _$actionInfo = _$LoginMobxActionController.startAction(
        name: 'LoginMobx.setHidePassword');
    try {
      return super.setHidePassword(val);
    } finally {
      _$LoginMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
device_token: ${device_token},
password: ${password},
hidePassword: ${hidePassword}
    ''';
  }
}

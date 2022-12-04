// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ForgotPasswordController on ForgotPasswordMobx, Store {
  final _$forgotPasswordAsyncAction =
      AsyncAction('ForgotPasswordMobx.forgotPassword');

  @override
  Future<void> forgotPassword(BuildContext context,
      {required String email, Function? onSuccess}) {
    return _$forgotPasswordAsyncAction.run(() =>
        super.forgotPassword(context, email: email, onSuccess: onSuccess));
  }

  final _$resetPasswordAsyncAction =
      AsyncAction('ForgotPasswordMobx.resetPassword');

  @override
  Future<void> resetPassword(BuildContext context,
      {required String password, required String code, Function? onSuccess}) {
    return _$resetPasswordAsyncAction.run(() => super.resetPassword(context,
        password: password, code: code, onSuccess: onSuccess));
  }

  final _$verifyCodeAsyncAction = AsyncAction('ForgotPasswordMobx.verifyCode');

  @override
  Future<void> verifyCode(BuildContext context,
      {String code = '0', Function? onSuccess, Function? onError}) {
    return _$verifyCodeAsyncAction.run(() => super.verifyCode(context,
        code: code, onSuccess: onSuccess, onError: onError));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}

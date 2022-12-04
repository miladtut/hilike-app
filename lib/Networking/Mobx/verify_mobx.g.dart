// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VerifyController on VerifyMobx, Store {
  final _$verifyAsyncAction = AsyncAction('VerifyMobx.verify');

  @override
  Future<void> verify(BuildContext context,
      {required String code,
      required String email,
      Function? onSuccess,
      Function? onError}) {
    return _$verifyAsyncAction.run(() => super.verify(context,
        code: code, email: email, onSuccess: onSuccess, onError: onError));
  }

  final _$resendCodeAsyncAction = AsyncAction('VerifyMobx.resendCode');

  @override
  Future<void> resendCode(BuildContext context,
      {required String email, Function? onSuccess}) {
    return _$resendCodeAsyncAction.run(
        () => super.resendCode(context, email: email, onSuccess: onSuccess));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}

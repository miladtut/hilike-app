// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'on_boarding_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OnBoardingController on OnBoardingMobx, Store {
  final _$listAtom = Atom(name: 'OnBoardingMobx.list');

  @override
  List<OnBoardingModel> get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(List<OnBoardingModel> value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  final _$getOnBoardingAsyncAction =
      AsyncAction('OnBoardingMobx.getOnBoarding');

  @override
  Future<void> getOnBoarding(BuildContext context, String lang) {
    return _$getOnBoardingAsyncAction
        .run(() => super.getOnBoarding(context, lang));
  }

  final _$OnBoardingMobxActionController =
      ActionController(name: 'OnBoardingMobx');

  @override
  dynamic clearList() {
    final _$actionInfo = _$OnBoardingMobxActionController.startAction(
        name: 'OnBoardingMobx.clearList');
    try {
      return super.clearList();
    } finally {
      _$OnBoardingMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
list: ${list}
    ''';
  }
}

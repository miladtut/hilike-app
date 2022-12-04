// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatController on ChatMobx, Store {
  final _$loadingAtom = Atom(name: 'ChatMobx.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$ChatMobxActionController = ActionController(name: 'ChatMobx');

  @override
  void setLoading(dynamic val) {
    final _$actionInfo =
        _$ChatMobxActionController.startAction(name: 'ChatMobx.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$ChatMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading}
    ''';
  }
}

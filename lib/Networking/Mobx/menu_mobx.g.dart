// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MenuController on MenuMobx, Store {
  final _$aboutAtom = Atom(name: 'MenuMobx.about');

  @override
  String? get about {
    _$aboutAtom.reportRead();
    return super.about;
  }

  @override
  set about(String? value) {
    _$aboutAtom.reportWrite(value, super.about, () {
      super.about = value;
    });
  }

  final _$policyAtom = Atom(name: 'MenuMobx.policy');

  @override
  String? get policy {
    _$policyAtom.reportRead();
    return super.policy;
  }

  @override
  set policy(String? value) {
    _$policyAtom.reportWrite(value, super.policy, () {
      super.policy = value;
    });
  }

  final _$linkAtom = Atom(name: 'MenuMobx.link');

  @override
  String? get link {
    _$linkAtom.reportRead();
    return super.link;
  }

  @override
  set link(String? value) {
    _$linkAtom.reportWrite(value, super.link, () {
      super.link = value;
    });
  }

  final _$messagesAtom = Atom(name: 'MenuMobx.messages');

  @override
  String? get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(String? value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  final _$likesAtom = Atom(name: 'MenuMobx.likes');

  @override
  String? get likes {
    _$likesAtom.reportRead();
    return super.likes;
  }

  @override
  set likes(String? value) {
    _$likesAtom.reportWrite(value, super.likes, () {
      super.likes = value;
    });
  }

  final _$nearbyAtom = Atom(name: 'MenuMobx.nearby');

  @override
  String? get nearby {
    _$nearbyAtom.reportRead();
    return super.nearby;
  }

  @override
  set nearby(String? value) {
    _$nearbyAtom.reportWrite(value, super.nearby, () {
      super.nearby = value;
    });
  }

  final _$editNotificationStatusAsyncAction =
      AsyncAction('MenuMobx.editNotificationStatus');

  @override
  Future<void> editNotificationStatus(BuildContext context, String types) {
    return _$editNotificationStatusAsyncAction
        .run(() => super.editNotificationStatus(context, types));
  }

  final _$getEditNotificationStatusAsyncAction =
      AsyncAction('MenuMobx.getEditNotificationStatus');

  @override
  Future<void> getEditNotificationStatus(BuildContext context) {
    return _$getEditNotificationStatusAsyncAction
        .run(() => super.getEditNotificationStatus(context));
  }

  final _$getMyLikesAsyncAction = AsyncAction('MenuMobx.getMyLikes');

  @override
  Future<void> getMyLikes(BuildContext context) {
    return _$getMyLikesAsyncAction.run(() => super.getMyLikes(context));
  }

  final _$getMyBlocksAsyncAction = AsyncAction('MenuMobx.getMyBlocks');

  @override
  Future<void> getMyBlocks(BuildContext context) {
    return _$getMyBlocksAsyncAction.run(() => super.getMyBlocks(context));
  }

  final _$getAboutAsyncAction = AsyncAction('MenuMobx.getAbout');

  @override
  Future<void> getAbout(BuildContext context) {
    return _$getAboutAsyncAction.run(() => super.getAbout(context));
  }

  final _$getSharedLinkAsyncAction = AsyncAction('MenuMobx.getSharedLink');

  @override
  Future<void> getSharedLink(BuildContext context, String typeee) {
    return _$getSharedLinkAsyncAction
        .run(() => super.getSharedLink(context, typeee));
  }

  final _$getPolicyAsyncAction = AsyncAction('MenuMobx.getPolicy');

  @override
  Future<void> getPolicy(BuildContext context) {
    return _$getPolicyAsyncAction.run(() => super.getPolicy(context));
  }

  final _$MenuMobxActionController = ActionController(name: 'MenuMobx');

  @override
  void setLink(dynamic val) {
    final _$actionInfo =
        _$MenuMobxActionController.startAction(name: 'MenuMobx.setLink');
    try {
      return super.setLink(val);
    } finally {
      _$MenuMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMessages(dynamic val) {
    final _$actionInfo =
        _$MenuMobxActionController.startAction(name: 'MenuMobx.setMessages');
    try {
      return super.setMessages(val);
    } finally {
      _$MenuMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLikes(dynamic val) {
    final _$actionInfo =
        _$MenuMobxActionController.startAction(name: 'MenuMobx.setLikes');
    try {
      return super.setLikes(val);
    } finally {
      _$MenuMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNearby(dynamic val) {
    final _$actionInfo =
        _$MenuMobxActionController.startAction(name: 'MenuMobx.setNearby');
    try {
      return super.setNearby(val);
    } finally {
      _$MenuMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
about: ${about},
policy: ${policy},
link: ${link},
messages: ${messages},
likes: ${likes},
nearby: ${nearby}
    ''';
  }
}

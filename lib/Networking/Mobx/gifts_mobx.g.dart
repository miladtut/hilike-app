// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gifts_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GiftsController on GiftsMobx, Store {
  final _$expandedAtom = Atom(name: 'GiftsMobx.expanded');

  @override
  bool get expanded {
    _$expandedAtom.reportRead();
    return super.expanded;
  }

  @override
  set expanded(bool value) {
    _$expandedAtom.reportWrite(value, super.expanded, () {
      super.expanded = value;
    });
  }

  final _$currentPageAtom = Atom(name: 'GiftsMobx.currentPage');

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  final _$selectedCategoryAtom = Atom(name: 'GiftsMobx.selectedCategory');

  @override
  int get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(int value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  final _$clickedGiftAtom = Atom(name: 'GiftsMobx.clickedGift');

  @override
  GiftModel? get clickedGift {
    _$clickedGiftAtom.reportRead();
    return super.clickedGift;
  }

  @override
  set clickedGift(GiftModel? value) {
    _$clickedGiftAtom.reportWrite(value, super.clickedGift, () {
      super.clickedGift = value;
    });
  }

  final _$onlineAtom = Atom(name: 'GiftsMobx.online');

  @override
  bool get online {
    _$onlineAtom.reportRead();
    return super.online;
  }

  @override
  set online(bool value) {
    _$onlineAtom.reportWrite(value, super.online, () {
      super.online = value;
    });
  }

  final _$is_blockedAtom = Atom(name: 'GiftsMobx.is_blocked');

  @override
  bool get is_blocked {
    _$is_blockedAtom.reportRead();
    return super.is_blocked;
  }

  @override
  set is_blocked(bool value) {
    _$is_blockedAtom.reportWrite(value, super.is_blocked, () {
      super.is_blocked = value;
    });
  }

  final _$show_unblockAtom = Atom(name: 'GiftsMobx.show_unblock');

  @override
  bool get show_unblock {
    _$show_unblockAtom.reportRead();
    return super.show_unblock;
  }

  @override
  set show_unblock(bool value) {
    _$show_unblockAtom.reportWrite(value, super.show_unblock, () {
      super.show_unblock = value;
    });
  }

  final _$getMyGiftsAsyncAction = AsyncAction('GiftsMobx.getMyGifts');

  @override
  Future<void> getMyGifts(BuildContext context) {
    return _$getMyGiftsAsyncAction.run(() => super.getMyGifts(context));
  }

  final _$getGiftCategoriesAsyncAction =
      AsyncAction('GiftsMobx.getGiftCategories');

  @override
  Future<void> getGiftCategories(BuildContext context) {
    return _$getGiftCategoriesAsyncAction
        .run(() => super.getGiftCategories(context));
  }

  final _$isOnlineAsyncAction = AsyncAction('GiftsMobx.isOnline');

  @override
  Future<void> isOnline(BuildContext context, String id) {
    return _$isOnlineAsyncAction.run(() => super.isOnline(context, id));
  }

  final _$GiftsMobxActionController = ActionController(name: 'GiftsMobx');

  @override
  void setExpanded(dynamic val) {
    final _$actionInfo =
        _$GiftsMobxActionController.startAction(name: 'GiftsMobx.setExpanded');
    try {
      return super.setExpanded(val);
    } finally {
      _$GiftsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsBlocked(dynamic val) {
    final _$actionInfo =
        _$GiftsMobxActionController.startAction(name: 'GiftsMobx.setIsBlocked');
    try {
      return super.setIsBlocked(val);
    } finally {
      _$GiftsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShowUnblock(dynamic val) {
    final _$actionInfo = _$GiftsMobxActionController.startAction(
        name: 'GiftsMobx.setShowUnblock');
    try {
      return super.setShowUnblock(val);
    } finally {
      _$GiftsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOnline(dynamic val) {
    final _$actionInfo =
        _$GiftsMobxActionController.startAction(name: 'GiftsMobx.setOnline');
    try {
      return super.setOnline(val);
    } finally {
      _$GiftsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentPage(dynamic val) {
    final _$actionInfo = _$GiftsMobxActionController.startAction(
        name: 'GiftsMobx.setCurrentPage');
    try {
      return super.setCurrentPage(val);
    } finally {
      _$GiftsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setClickedGift(dynamic val) {
    final _$actionInfo = _$GiftsMobxActionController.startAction(
        name: 'GiftsMobx.setClickedGift');
    try {
      return super.setClickedGift(val);
    } finally {
      _$GiftsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedCategory(dynamic val) {
    final _$actionInfo = _$GiftsMobxActionController.startAction(
        name: 'GiftsMobx.setSelectedCategory');
    try {
      return super.setSelectedCategory(val);
    } finally {
      _$GiftsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
expanded: ${expanded},
currentPage: ${currentPage},
selectedCategory: ${selectedCategory},
clickedGift: ${clickedGift},
online: ${online},
is_blocked: ${is_blocked},
show_unblock: ${show_unblock}
    ''';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchController on SearchMobx, Store {
  final _$queryAtom = Atom(name: 'SearchMobx.query');

  @override
  String? get query {
    _$queryAtom.reportRead();
    return super.query;
  }

  @override
  set query(String? value) {
    _$queryAtom.reportWrite(value, super.query, () {
      super.query = value;
    });
  }

  final _$nearbyAtom = Atom(name: 'SearchMobx.nearby');

  @override
  int? get nearby {
    _$nearbyAtom.reportRead();
    return super.nearby;
  }

  @override
  set nearby(int? value) {
    _$nearbyAtom.reportWrite(value, super.nearby, () {
      super.nearby = value;
    });
  }

  final _$onlineAtom = Atom(name: 'SearchMobx.online');

  @override
  int? get online {
    _$onlineAtom.reportRead();
    return super.online;
  }

  @override
  set online(int? value) {
    _$onlineAtom.reportWrite(value, super.online, () {
      super.online = value;
    });
  }

  final _$withImageAtom = Atom(name: 'SearchMobx.withImage');

  @override
  int? get withImage {
    _$withImageAtom.reportRead();
    return super.withImage;
  }

  @override
  set withImage(int? value) {
    _$withImageAtom.reportWrite(value, super.withImage, () {
      super.withImage = value;
    });
  }

  final _$sameCountryAtom = Atom(name: 'SearchMobx.sameCountry');

  @override
  int? get sameCountry {
    _$sameCountryAtom.reportRead();
    return super.sameCountry;
  }

  @override
  set sameCountry(int? value) {
    _$sameCountryAtom.reportWrite(value, super.sameCountry, () {
      super.sameCountry = value;
    });
  }

  final _$minDistanceAtom = Atom(name: 'SearchMobx.minDistance');

  @override
  int? get minDistance {
    _$minDistanceAtom.reportRead();
    return super.minDistance;
  }

  @override
  set minDistance(int? value) {
    _$minDistanceAtom.reportWrite(value, super.minDistance, () {
      super.minDistance = value;
    });
  }

  final _$maxDistanceAtom = Atom(name: 'SearchMobx.maxDistance');

  @override
  int? get maxDistance {
    _$maxDistanceAtom.reportRead();
    return super.maxDistance;
  }

  @override
  set maxDistance(int? value) {
    _$maxDistanceAtom.reportWrite(value, super.maxDistance, () {
      super.maxDistance = value;
    });
  }

  final _$minAgeAtom = Atom(name: 'SearchMobx.minAge');

  @override
  int? get minAge {
    _$minAgeAtom.reportRead();
    return super.minAge;
  }

  @override
  set minAge(int? value) {
    _$minAgeAtom.reportWrite(value, super.minAge, () {
      super.minAge = value;
    });
  }

  final _$maxAgeAtom = Atom(name: 'SearchMobx.maxAge');

  @override
  int? get maxAge {
    _$maxAgeAtom.reportRead();
    return super.maxAge;
  }

  @override
  set maxAge(int? value) {
    _$maxAgeAtom.reportWrite(value, super.maxAge, () {
      super.maxAge = value;
    });
  }

  final _$lastVisitAtom = Atom(name: 'SearchMobx.lastVisit');

  @override
  int? get lastVisit {
    _$lastVisitAtom.reportRead();
    return super.lastVisit;
  }

  @override
  set lastVisit(int? value) {
    _$lastVisitAtom.reportWrite(value, super.lastVisit, () {
      super.lastVisit = value;
    });
  }

  final _$originCountryAtom = Atom(name: 'SearchMobx.originCountry');

  @override
  CountryModel? get originCountry {
    _$originCountryAtom.reportRead();
    return super.originCountry;
  }

  @override
  set originCountry(CountryModel? value) {
    _$originCountryAtom.reportWrite(value, super.originCountry, () {
      super.originCountry = value;
    });
  }

  final _$residenceCountryAtom = Atom(name: 'SearchMobx.residenceCountry');

  @override
  CountryModel? get residenceCountry {
    _$residenceCountryAtom.reportRead();
    return super.residenceCountry;
  }

  @override
  set residenceCountry(CountryModel? value) {
    _$residenceCountryAtom.reportWrite(value, super.residenceCountry, () {
      super.residenceCountry = value;
    });
  }

  final _$filterMinAgeAtom = Atom(name: 'SearchMobx.filterMinAge');

  @override
  int? get filterMinAge {
    _$filterMinAgeAtom.reportRead();
    return super.filterMinAge;
  }

  @override
  set filterMinAge(int? value) {
    _$filterMinAgeAtom.reportWrite(value, super.filterMinAge, () {
      super.filterMinAge = value;
    });
  }

  final _$filterMaxAgeAtom = Atom(name: 'SearchMobx.filterMaxAge');

  @override
  int? get filterMaxAge {
    _$filterMaxAgeAtom.reportRead();
    return super.filterMaxAge;
  }

  @override
  set filterMaxAge(int? value) {
    _$filterMaxAgeAtom.reportWrite(value, super.filterMaxAge, () {
      super.filterMaxAge = value;
    });
  }

  final _$filterMinDistanceAtom = Atom(name: 'SearchMobx.filterMinDistance');

  @override
  int? get filterMinDistance {
    _$filterMinDistanceAtom.reportRead();
    return super.filterMinDistance;
  }

  @override
  set filterMinDistance(int? value) {
    _$filterMinDistanceAtom.reportWrite(value, super.filterMinDistance, () {
      super.filterMinDistance = value;
    });
  }

  final _$filterMaxDistanceAtom = Atom(name: 'SearchMobx.filterMaxDistance');

  @override
  int? get filterMaxDistance {
    _$filterMaxDistanceAtom.reportRead();
    return super.filterMaxDistance;
  }

  @override
  set filterMaxDistance(int? value) {
    _$filterMaxDistanceAtom.reportWrite(value, super.filterMaxDistance, () {
      super.filterMaxDistance = value;
    });
  }

  final _$filterMinLastVisitAtom = Atom(name: 'SearchMobx.filterMinLastVisit');

  @override
  int? get filterMinLastVisit {
    _$filterMinLastVisitAtom.reportRead();
    return super.filterMinLastVisit;
  }

  @override
  set filterMinLastVisit(int? value) {
    _$filterMinLastVisitAtom.reportWrite(value, super.filterMinLastVisit, () {
      super.filterMinLastVisit = value;
    });
  }

  final _$filterMaxLastVisitAtom = Atom(name: 'SearchMobx.filterMaxLastVisit');

  @override
  int? get filterMaxLastVisit {
    _$filterMaxLastVisitAtom.reportRead();
    return super.filterMaxLastVisit;
  }

  @override
  set filterMaxLastVisit(int? value) {
    _$filterMaxLastVisitAtom.reportWrite(value, super.filterMaxLastVisit, () {
      super.filterMaxLastVisit = value;
    });
  }

  final _$vipAtom = Atom(name: 'SearchMobx.vip');

  @override
  bool? get vip {
    _$vipAtom.reportRead();
    return super.vip;
  }

  @override
  set vip(bool? value) {
    _$vipAtom.reportWrite(value, super.vip, () {
      super.vip = value;
    });
  }

  final _$limitAtom = Atom(name: 'SearchMobx.limit');

  @override
  int get limit {
    _$limitAtom.reportRead();
    return super.limit;
  }

  @override
  set limit(int value) {
    _$limitAtom.reportWrite(value, super.limit, () {
      super.limit = value;
    });
  }

  final _$offsetAtom = Atom(name: 'SearchMobx.offset');

  @override
  int? get offset {
    _$offsetAtom.reportRead();
    return super.offset;
  }

  @override
  set offset(int? value) {
    _$offsetAtom.reportWrite(value, super.offset, () {
      super.offset = value;
    });
  }

  final _$loadingAtom = Atom(name: 'SearchMobx.loading');

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

  final _$likedYouAtom = Atom(name: 'SearchMobx.likedYou');

  @override
  bool? get likedYou {
    _$likedYouAtom.reportRead();
    return super.likedYou;
  }

  @override
  set likedYou(bool? value) {
    _$likedYouAtom.reportWrite(value, super.likedYou, () {
      super.likedYou = value;
    });
  }

  final _$messageAtom = Atom(name: 'SearchMobx.message');

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

  final _$isbanAtom = Atom(name: 'SearchMobx.isban');

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

  final _$expiredAtom = Atom(name: 'SearchMobx.expired');

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

  final _$numberSearchAtom = Atom(name: 'SearchMobx.numberSearch');

  @override
  int? get numberSearch {
    _$numberSearchAtom.reportRead();
    return super.numberSearch;
  }

  @override
  set numberSearch(int? value) {
    _$numberSearchAtom.reportWrite(value, super.numberSearch, () {
      super.numberSearch = value;
    });
  }

  final _$searchAsyncAction = AsyncAction('SearchMobx.search');

  @override
  Future<void> search(BuildContext context, {Function? onSuccess}) {
    return _$searchAsyncAction
        .run(() => super.search(context, onSuccess: onSuccess));
  }

  final _$getFilterAsyncAction = AsyncAction('SearchMobx.getFilter');

  @override
  Future<void> getFilter(BuildContext context, {Function? onSuccess}) {
    return _$getFilterAsyncAction
        .run(() => super.getFilter(context, onSuccess: onSuccess));
  }

  final _$SearchMobxActionController = ActionController(name: 'SearchMobx');

  @override
  void setNumberSearch(dynamic val) {
    final _$actionInfo = _$SearchMobxActionController.startAction(
        name: 'SearchMobx.setNumberSearch');
    try {
      return super.setNumberSearch(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMessage(dynamic val) {
    final _$actionInfo =
        _$SearchMobxActionController.startAction(name: 'SearchMobx.setMessage');
    try {
      return super.setMessage(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsban(dynamic val) {
    final _$actionInfo =
        _$SearchMobxActionController.startAction(name: 'SearchMobx.setIsban');
    try {
      return super.setIsban(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExpired(dynamic val) {
    final _$actionInfo =
        _$SearchMobxActionController.startAction(name: 'SearchMobx.setExpired');
    try {
      return super.setExpired(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuery(String val) {
    final _$actionInfo =
        _$SearchMobxActionController.startAction(name: 'SearchMobx.setQuery');
    try {
      return super.setQuery(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNearby(int val) {
    final _$actionInfo =
        _$SearchMobxActionController.startAction(name: 'SearchMobx.setNearby');
    try {
      return super.setNearby(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOnline(int val) {
    final _$actionInfo =
        _$SearchMobxActionController.startAction(name: 'SearchMobx.setOnline');
    try {
      return super.setOnline(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWithImage(int val) {
    final _$actionInfo = _$SearchMobxActionController.startAction(
        name: 'SearchMobx.setWithImage');
    try {
      return super.setWithImage(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSameCountry(int val) {
    final _$actionInfo = _$SearchMobxActionController.startAction(
        name: 'SearchMobx.setSameCountry');
    try {
      return super.setSameCountry(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMinDistance(int val) {
    final _$actionInfo = _$SearchMobxActionController.startAction(
        name: 'SearchMobx.setMinDistance');
    try {
      return super.setMinDistance(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMaxDistance(int val) {
    final _$actionInfo = _$SearchMobxActionController.startAction(
        name: 'SearchMobx.setMaxDistance');
    try {
      return super.setMaxDistance(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMinAge(int val) {
    final _$actionInfo =
        _$SearchMobxActionController.startAction(name: 'SearchMobx.setMinAge');
    try {
      return super.setMinAge(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMaxAge(int val) {
    final _$actionInfo =
        _$SearchMobxActionController.startAction(name: 'SearchMobx.setMaxAge');
    try {
      return super.setMaxAge(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilterMinAge(int val) {
    final _$actionInfo = _$SearchMobxActionController.startAction(
        name: 'SearchMobx.setFilterMinAge');
    try {
      return super.setFilterMinAge(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilterMaxAge(int val) {
    final _$actionInfo = _$SearchMobxActionController.startAction(
        name: 'SearchMobx.setFilterMaxAge');
    try {
      return super.setFilterMaxAge(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilterMinDistance(int val) {
    final _$actionInfo = _$SearchMobxActionController.startAction(
        name: 'SearchMobx.setFilterMinDistance');
    try {
      return super.setFilterMinDistance(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilterMaxDistance(int val) {
    final _$actionInfo = _$SearchMobxActionController.startAction(
        name: 'SearchMobx.setFilterMaxDistance');
    try {
      return super.setFilterMaxDistance(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilterMinLastVisit(int val) {
    final _$actionInfo = _$SearchMobxActionController.startAction(
        name: 'SearchMobx.setFilterMinLastVisit');
    try {
      return super.setFilterMinLastVisit(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilterMaxLastVisit(int val) {
    final _$actionInfo = _$SearchMobxActionController.startAction(
        name: 'SearchMobx.setFilterMaxLastVisit');
    try {
      return super.setFilterMaxLastVisit(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastVisit(int val) {
    final _$actionInfo = _$SearchMobxActionController.startAction(
        name: 'SearchMobx.setLastVisit');
    try {
      return super.setLastVisit(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOriginCountry(dynamic val) {
    final _$actionInfo = _$SearchMobxActionController.startAction(
        name: 'SearchMobx.setOriginCountry');
    try {
      return super.setOriginCountry(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setResidenceCountry(dynamic val) {
    final _$actionInfo = _$SearchMobxActionController.startAction(
        name: 'SearchMobx.setResidenceCountry');
    try {
      return super.setResidenceCountry(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVip(dynamic val) {
    final _$actionInfo =
        _$SearchMobxActionController.startAction(name: 'SearchMobx.setVip');
    try {
      return super.setVip(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOffset(dynamic val) {
    final _$actionInfo =
        _$SearchMobxActionController.startAction(name: 'SearchMobx.setOffset');
    try {
      return super.setOffset(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearVip() {
    final _$actionInfo =
        _$SearchMobxActionController.startAction(name: 'SearchMobx.clearVip');
    try {
      return super.clearVip();
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearFeed() {
    final _$actionInfo =
        _$SearchMobxActionController.startAction(name: 'SearchMobx.clearFeed');
    try {
      return super.clearFeed();
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLikedYou(dynamic val) {
    final _$actionInfo = _$SearchMobxActionController.startAction(
        name: 'SearchMobx.setLikedYou');
    try {
      return super.setLikedYou(val);
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetFilter() {
    final _$actionInfo = _$SearchMobxActionController.startAction(
        name: 'SearchMobx.resetFilter');
    try {
      return super.resetFilter();
    } finally {
      _$SearchMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
query: ${query},
nearby: ${nearby},
online: ${online},
withImage: ${withImage},
sameCountry: ${sameCountry},
minDistance: ${minDistance},
maxDistance: ${maxDistance},
minAge: ${minAge},
maxAge: ${maxAge},
lastVisit: ${lastVisit},
originCountry: ${originCountry},
residenceCountry: ${residenceCountry},
filterMinAge: ${filterMinAge},
filterMaxAge: ${filterMaxAge},
filterMinDistance: ${filterMinDistance},
filterMaxDistance: ${filterMaxDistance},
filterMinLastVisit: ${filterMinLastVisit},
filterMaxLastVisit: ${filterMaxLastVisit},
vip: ${vip},
limit: ${limit},
offset: ${offset},
loading: ${loading},
likedYou: ${likedYou},
message: ${message},
isban: ${isban},
expired: ${expired},
numberSearch: ${numberSearch}
    ''';
  }
}

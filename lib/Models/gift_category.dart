import 'package:hilike/Models/gift.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GiftCategoryModel {
  int? id;
  String? name;
  List<GiftModel>? gifts = [];

  GiftCategoryModel({this.id, this.name, this.gifts});

  GiftCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['gifts'] != null) {
      gifts = [];
      for (var item in json['gifts']) {
        GiftModel gift = GiftModel.fromJson(item);
        gifts!.add(gift);
      }
    }
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    Map<String,dynamic> giftsMap = {};
    for(GiftModel item in (this.gifts ?? [])){
      giftsMap.addAll(item.toJson());
    }
    return <String, dynamic>{
      'id': this.id,
      'name': this.name,
      'gifts': giftsMap,
    };
  }
}

class GiftCategoryPartitioned{
  int? id;
  String? name;
  Iterable<List<GiftModel>>? giftGroups;

  GiftCategoryPartitioned({this.id, this.name, this.giftGroups});
}
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CoinsModel {
  int? id;
  int? coins;
  double? price;

  CoinsModel({this.id, this.coins, this.price});

  CoinsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coins = json['coins'];
    price = json['price'] * 1.0;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': this.id,
      'coins': this.coins,
      'price': this.price,
    };
  }
}
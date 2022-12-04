import 'package:json_annotation/json_annotation.dart';
import 'package:nb_utils/nb_utils.dart';

@JsonSerializable()
class PlanPackageModel {
  int? id;
  int? months;
  double? price;
  int? percantage;
  double? old_price;

  PlanPackageModel(
      {this.id, this.months, this.price, this.old_price, this.percantage});

  PlanPackageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    months = json['months'];
    price = json['price'] * 1.0;
    percantage = json['percantage'];
    old_price = json['old_price'] * 1.0;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': this.id,
      'months': this.months,
      'price': this.price,
      'old_price': this.old_price,
      'percantage': this.percantage
    };
  }
}

import 'package:hilike/Models/plan_package.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PlanModel {
  int? id;
  String? name;
  double? price;
  List<PlanPackageModel>? packages = [];
  List<String>? description = [];
  List<String>? ar_description = [];

  PlanModel(
      {this.id,
      this.name,
      this.price,
      this.packages,
      this.ar_description,
      this.description});

  PlanModel.fromJson(Map<String, dynamic> json) {
    if (json['packages'] != null) {
      packages = [];
      for (var item in json['packages']) {
        PlanPackageModel pkg = PlanPackageModel.fromJson(item);
        packages!.add(pkg);
      }
    }
    if (json['description'] != null) {
      description = [];
      for (var item in json['description']) {
        description!.add(item);
      }
    }
    if (json['ar_description'] != null) {
      ar_description = [];
      for (var item in json['ar_description']) {
        ar_description!.add(item);
      }
    }

    id = json['id'];
    name = json['name'];
    price = json['price'] * 1.0;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> packagesMap = {};
    for (PlanPackageModel item in (this.packages ?? [])) {
      packagesMap.addAll(item.toJson());
    }

    return <String, dynamic>{
      'id': this.id,
      'name': this.name,
      'price': this.price,
      'packages': packagesMap,
      'ar_description': this.ar_description,
      'description': this.description,
    };
  }
}

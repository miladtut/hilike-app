import 'package:json_annotation/json_annotation.dart';

import '../Utils/constants.dart';

@JsonSerializable()
class IdNameModel {
  int? id;
  String? name;

  IdNameModel({this.id, this.name});

  IdNameModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': this.id,
      'name': this.name,
    };
  }
}
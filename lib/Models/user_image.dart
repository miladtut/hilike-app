import 'package:json_annotation/json_annotation.dart';

import '../Utils/constants.dart';

@JsonSerializable()
class UserImageModel {
  int? id;
  String? image;
  bool? isLocal;

  UserImageModel({this.id, this.image, this.isLocal});

  UserImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    // isLocal = json['is_local'].toString().contains('false') ? false : true;
    isLocal = json['is_local'] ?? false;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': this.id,
      'image': this.image,
      'is_local': this.isLocal ?? false ? '1' : '0',
    };
  }
}

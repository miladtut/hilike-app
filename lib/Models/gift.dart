import 'package:json_annotation/json_annotation.dart';

import '../Utils/constants.dart';

@JsonSerializable()
class GiftModel {
  int? id;
  String? image;
  int? price;
  String? profileImage;
  int? userId;

  GiftModel({this.id, this.image, this.price, this.profileImage, this.userId});

  GiftModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    price = json['price'];
    profileImage = json['profile_image'];
    userId = json['user_id'];

  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': this.id,
      'image': this.image,
      'price': this.price,
      'profile_image': this.profileImage,
      'user_id': this.userId,
    };
  }
}
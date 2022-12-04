import 'package:json_annotation/json_annotation.dart';

import '../Utils/constants.dart';

@JsonSerializable()
class OnBoardingModel {
  String? title;
  String? description;
  String? image;

  OnBoardingModel({this.title = "", this.description = "", this.image = imgPlaceholder});

  OnBoardingModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': this.title,
      'description': this.description,
      'image': this.image,
    };
  }
}
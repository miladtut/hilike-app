import 'package:hilike/Models/id_name.dart';
import 'package:json_annotation/json_annotation.dart';

import '../Utils/constants.dart';

@JsonSerializable()
class OtherInfoModel {
  String? about;
  String? lookingFor;
  String? dob;
  String? originCountry;
  String? residenceCountry;
  String? religion;
  String? socialType;
  String? marriageType;
  String? education;
  String? job;
  String? children;
  String? smoking;
  List? language;
  int? height;
  String? skinColor;
  String? body;
  String? drinking;

  OtherInfoModel({
    this.about,
    this.drinking,
    this.lookingFor,
    this.dob,
    this.originCountry,
    this.residenceCountry,
    this.religion,
    this.socialType,
    this.marriageType,
    this.education,
    this.job,
    this.children,
    this.smoking,
    this.language,
    this.height,
    this.skinColor,
    this.body,
  });

  OtherInfoModel.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    lookingFor = json['looking_for'];
    dob = json['dob'].toString();
    originCountry = json['origin_country'];
    residenceCountry = json['residence_country'];
    religion = json['religion'];
    socialType = json['social_type'];
    marriageType = json['marriage_type'];
    education = json['education'];
    job = json['job'];
    drinking = json["drinking"];
    children = json['children'];
    smoking = json['smoking'];
    language = json['native_language'];
    height = json['height'];
    skinColor = json['skin_color'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'about': this.about,
      'drinking': this.drinking,
      'looking_for': this.lookingFor,
      'dob': this.dob,
      'origin_country': this.originCountry,
      'residence_country': this.residenceCountry,
      'religion': this.religion,
      'social_type': this.socialType,
      'marriage_type': this.marriageType,
      'education': this.education,
      'job': this.job,
      'children': this.children,
      'smoking': (this.smoking),
      'native_language': this.language,
      'height': this.height,
      'skin_color': this.skinColor,
      'body': this.body,
    };
  }
}

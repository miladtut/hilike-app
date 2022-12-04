import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CountryModel {
  String? id;
  String? name;
  double? latitude;
  double? longitude;

  CountryModel({this.id, this.name, this.latitude, this.longitude});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['place_id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'place_id': this.id,
      'name': this.name,
      'latitude': this.latitude,
      'longitude': this.longitude,
    };
  }
}
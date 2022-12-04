import 'package:hilike/Models/gift.dart';
import 'package:hilike/Models/other_info.dart';
import 'package:hilike/Models/user_image.dart';
import 'package:hilike/Utils/constants.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AccountModel {
  String? apiToken;
  bool? isLoggedIn;
  int? id;
  String? nickname;
  String? residenceCountry;
  int? age;
  String? profileImage;
  String? plan;
  double? distance;
  bool? online;
  bool? isMale;
  int? balance;
  List<GiftModel>? gifts = [];
  List<UserImageModel>? images = [];
  OtherInfoModel? otherInfo;
  int? profileProgress;
  bool? locationEnabled;
  bool? accountShowed;
  bool? isLiked;
  int? is_social;
  int? notification;

  AccountModel({
    this.apiToken,
    this.notification,
    this.isLoggedIn,
    this.id,
    this.is_social,
    this.nickname,
    this.residenceCountry,
    this.age,
    this.profileImage,
    this.plan,
    this.distance,
    this.online,
    this.isMale,
    this.balance,
    this.gifts,
    this.images,
    this.otherInfo,
    this.profileProgress,
    this.accountShowed,
    this.locationEnabled,
    this.isLiked,
  });

  AccountModel fromJson(Map<String, dynamic> json) {
    if (json['gifts'] != null) {
      gifts = [];
      for (var item in json['gifts']) {
        GiftModel gift = GiftModel.fromJson(item);
        gifts!.add(gift);
      }
    }

    if (json['images'] != null) {
      images = [];
      for (var item in json['images']) {
        UserImageModel image = UserImageModel.fromJson(item);
        images!.add(image);
      }
    } else {
      images = [];
    }
    // images = [];
    // for (var item in json['images']) {
    //   UserImageModel image = UserImageModel.fromJson(item);
    //   images!.add(image);
    // }

    if (json['other_info'] != null) {
      otherInfo = OtherInfoModel.fromJson(json['other_info']);
    }
    return AccountModel(
      notification: json['notification'],
      apiToken: json['token'],
      is_social: json['is_social'],
      isLoggedIn: json['isLoggedIn'] == '1',
      id: json['user_id'],
      nickname: json['nickname'],
      residenceCountry: json['residence_country'],
      age: json['age'],
      profileImage: json['profile_image'],
      plan: json['plan'],
      distance: json['distance'] == null ? null : (json['distance']) * 1.0,
      online: json['online'] == 1,
      isMale: json['gender'] == "male",
      balance: json['balance'],
      profileProgress: json['profile_progress'],
      accountShowed: (json['account_showed'] ?? 1) == 1,
      locationEnabled: (json['location_enabled'] ?? 1) == 1,
      isLiked: json['is_liked'] == 1,
      gifts: gifts,
      images: images,
      otherInfo: otherInfo,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'token': this.apiToken,
      'notification': this.notification,
      'is_social': this.is_social,
      'isLoggedIn': (this.isLoggedIn ?? false) ? '1' : '0',
      'user_id': this.id,
      'nickname': this.nickname,
      'residence_country': this.residenceCountry,
      'age': this.age,
      'profile_image': this.profileImage,
      'plan': this.plan,
      'distance': this.distance,
      'online': this.online ?? false ? 1 : 0,
      'gender': this.isMale ?? true ? 'male' : 'female',
      'balance': this.balance,
      'gifts': gifts != null ? this.gifts! : null,
      'images': images != null ? this.images! : null,
      'other_info': otherInfo != null ? otherInfo!.toJson() : null,
      'profile_progress': profileProgress,
      'account_showed': this.accountShowed ?? true ? 1 : 0,
      'location_enabled': this.locationEnabled ?? true ? 1 : 0,
      'is_liked': this.isLiked ?? true ? 1 : 0,
    };
  }
}

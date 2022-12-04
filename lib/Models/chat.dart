// To parse this JSON data, do
//
//     final chat = chatFromJson(jsonString);

import 'dart:convert';

import 'dart:ffi';

List<Chat> chatFromJson(String str) =>
    List<Chat>.from(json.decode(str).map((x) => Chat.fromJson(x)));

String chatToJson(List<Chat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Chat {
  Chat(
      {
      this.userId,
      this.nickname,
      this.residenceCountry,
      this.age,
      this.profileImage,
      this.plan,
      this.distance,
      this.online,
      this.gender,
      this.threadId,
      this.messages,
      this.count,
      this.is_blocked,
      this.fireCount,
      this.show_unblock,
      this.updatedAt});

  int? userId;
  int? fireCount;
  String? nickname;
  String? residenceCountry;
  int? age;
  dynamic profileImage;
  String? plan;
  double? distance;
  int? online;
  String? gender;
  String? threadId;
  DateTime? updatedAt;
  int? count;
  int? is_blocked;
  int? show_unblock;

  List<String>? messages;



  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        userId: json["user_id"],
        show_unblock: json["show_unblock"],
        is_blocked: json["is_blocked"],
        messages: json["messages"] ?? [],
        nickname: json["nickname"],
        residenceCountry: json["residence_country"],
        age: json["age"],
        profileImage: json["profile_image"],
        plan: json["plan"],
        distance: json["distance"].toDouble(),
        online: json["online"],
        gender: json["gender"],
        threadId: json["thread_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "show_unblock": show_unblock,
        "is_blocked": is_blocked,
        "messages": messages ?? [],
        "nickname": nickname,
        "residence_country": residenceCountry,
        "age": age,
        "profile_image": profileImage,
        "plan": plan,
        "distance": distance,
        "online": online,
        "gender": gender,
        "thread_id": threadId,
      };
}

class Fchat{

  String? sender_id;
  String? receiver_id;
  String? sender_nickname;
  String? sender_image;
  double? sender_distance;
  String? sender_plan;
  String? updated_at;
  String? sender_gender;
  String? sender_country;
  int? sender_age;

  String? receiver_nickname;
  String? receiver_image;
  String? receiver_plan;
  String? receiver_gender;
  String? receiver_country;
  int? receiver_age;

  String? txt;


  Fchat({
    this.sender_id,
    this.receiver_id,
    this.sender_nickname,
    this.sender_image,
    this.sender_distance,
    this.sender_plan,
    this.updated_at,
    this.sender_gender,
    this.sender_country,
    this.sender_age,


    this.receiver_nickname,
    this.receiver_image,
    this.receiver_plan,
    this.receiver_gender,
    this.receiver_country,
    this.receiver_age,

    this.txt,

  });
  static Fchat fromJson(Map<String, dynamic> json) => Fchat(
    sender_id: json['sender_id'].toString(),
    receiver_id: json['receiver_id'].toString(),
    sender_nickname: json['sender_nickname'].toString(),
    sender_image: json['sender_image'].toString(),
    sender_distance: json['sender_distance'],
    sender_plan: json['sender_plan'].toString(),
    updated_at: json['updated_at'].toString(),
    sender_gender: json['sender_gender'].toString(),
    sender_country: json['sender_country'].toString(),
    sender_age: json['sender_age'],
    txt: json['text'],

    receiver_nickname: json['receiver_nickname'].toString(),
    receiver_image: json['receiver_image'].toString(),
    receiver_plan: json['receiver_plan'].toString(),
    receiver_gender: json['receiver_gender'].toString(),
    receiver_country: json['receiver_country'].toString(),
    receiver_age: json['receiver_age'],


  );
}



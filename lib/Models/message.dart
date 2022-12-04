import 'package:hilike/Utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Message {
  final int senderId;
  final String text;
  final String status;
  final bool isGift;
  final int giftId;
  final DateTime createdAt;
  final String messagedoc;
  int type = 0;
  final int? dflag, sflag;

  Message({
    required this.senderId,
    required this.text,
    required this.messagedoc,
    required this.status,
    required this.isGift,
    required this.giftId,
    required this.createdAt,
    this.type = 0,
    this.dflag,
    this.sflag,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        senderId: json['sender_id'],
        text: json['text'],
        messagedoc: json['messagedoc'] ?? "",
        dflag: json['dflag'] ?? 0,
        sflag: json['sflag'] ?? 0,
        status: json['status'],
        isGift: json['is_gift'],
        giftId: json['gift_id'],
        createdAt: Utils.toDateTime(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'sender_id': senderId,
        'dflag': dflag ?? 0,
        'sflag': sflag ?? 0,
        'text': text,
        'status': status,
        "messagedoc": messagedoc,
        'is_gift': isGift,
        'gift_id': giftId,
        'created_at': Utils.fromDateTimeToJson(createdAt),
      };

  Message copyWith({
    int type = 0,
  }) =>
      Message(
          senderId: senderId,
          text: text,
          status: status,
          isGift: isGift,
          giftId: giftId,
          createdAt: createdAt,
          messagedoc: messagedoc,
          type: type);
}

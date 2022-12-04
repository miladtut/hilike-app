import 'package:hilike/Utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class MessageSupport {
  final int senderId;
  final String text;
  final String status;
  final bool isGift;
  final int giftId;
  final String? problem;

  final DateTime createdAt;
  final String messagedoc;
  int type = 0;

  MessageSupport({
    required this.senderId,
    required this.text,
    this.problem,
    required this.messagedoc,
    required this.status,
    required this.isGift,
    required this.giftId,
    required this.createdAt,
    this.type = 0,
  });

  static MessageSupport fromJson(Map<String, dynamic> json) => MessageSupport(
        senderId: json['sender_id'],
        text: json['text'],
        problem: json['problem'],
        messagedoc: json['messagedoc'] ?? "",
        status: json['status'],
        isGift: json['is_gift'],
        giftId: json['gift_id'],
        createdAt: Utils.toDateTime(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'sender_id': senderId,
        'problem': problem,
        'text': text,
        'status': status,
        "messagedoc": messagedoc,
        'is_gift': isGift,
        'gift_id': giftId,
        'created_at': Utils.fromDateTimeToJson(createdAt),
      };

  MessageSupport copyWith({
    int type = 0,
  }) =>
      MessageSupport(
          senderId: senderId,
          text: text,
          problem: problem,
          status: status,
          isGift: isGift,
          giftId: giftId,
          createdAt: createdAt,
          messagedoc: messagedoc,
          type: type);
}

import 'dart:convert';

import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final String conversationId;
  final String senderUID;
  final String receiverUID;
  final String content;
  final String timeStamp;

  const MessageModel({
    required this.conversationId,
    required this.senderUID,
    required this.receiverUID,
    required this.content,
    required this.timeStamp,
  });

  MessageModel copyWith({
    String? conversationId,
    String? senderUID,
    String? receiverUID,
    String? content,
    String? timeStamp,
  }) {
    return MessageModel(
      conversationId: conversationId ?? this.conversationId,
      senderUID: senderUID ?? this.senderUID,
      receiverUID: receiverUID ?? this.receiverUID,
      content: content ?? this.content,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'conversationId': conversationId,
      'senderUID': senderUID,
      'receiverUID': receiverUID,
      'content': content,
      'timeStamp': timeStamp,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      conversationId: map['conversationId']?.toString() ?? '',
      senderUID: map['senderUID']?.toString() ?? '',
      receiverUID: map['receiverUID']?.toString() ?? '',
      content: map['content']?.toString() ?? '',
      timeStamp: map['timeStamp']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(conversationId: $conversationId, senderUID: $senderUID, receiverUID: $receiverUID, content: $content, timeStamp: $timeStamp)';
  }

  @override
  List<Object> get props {
    return [conversationId, senderUID, receiverUID, content, timeStamp];
  }
}

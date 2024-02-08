import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:friend_chat/model/user_model.dart';

class ConversationModel extends Equatable {
  final String? id;
  final UserModel creator;
  final UserModel receiver;
  final List<String> members;

  ConversationModel({
    this.id,
    required this.creator,
    required this.receiver,
    required this.members,
  });

  ConversationModel copyWith({
    String? id,
    UserModel? creator,
    UserModel? receiver,
    List<String>? members,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      creator: creator ?? this.creator,
      receiver: receiver ?? this.receiver,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'creator': creator.toMap(),
      'receiver': receiver.toMap(),
      'members': members,
    };
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      id: map['id']?.toString(),
      creator: UserModel.fromMap(map['creator'] as Map<String, dynamic>),
      receiver: UserModel.fromMap(map['receiver'] as Map<String, dynamic>),
      members: List<String>.from(map['members'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationModel.fromJson(String source) =>
      ConversationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Conversation(id: $id, creator: $creator, receiver: $receiver, members: $members)';
  }

  @override
  List<Object> get props => [creator, receiver, members];
}

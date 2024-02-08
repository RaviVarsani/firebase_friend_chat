import 'package:equatable/equatable.dart';
import 'package:friend_chat/model/conversation_model.dart';
import 'package:friend_chat/model/user_model.dart';

abstract class ConversationEvent extends Equatable {
  ConversationEvent();

  @override
  List<Object> get props => [];
}

class ConversationDetailRequested extends ConversationEvent {
  final UserModel loginUser;
  final UserModel receiver;

  ConversationDetailRequested(
      {required this.loginUser, required this.receiver});
}

class ConversationCreated extends ConversationEvent {
  final ConversationModel conversation;

  ConversationCreated({required this.conversation});
}

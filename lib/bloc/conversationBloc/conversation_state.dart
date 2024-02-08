import 'package:equatable/equatable.dart';
import 'package:friend_chat/model/conversation_model.dart';

abstract class ConversationState extends Equatable {
  ConversationState();

  @override
  List<Object> get props => [];
}

class ConversationInitial extends ConversationState {}

class ConversationLoadInProgress extends ConversationState {}

class ConversationLoadSuccess extends ConversationState {
  final ConversationModel conversation;

  ConversationLoadSuccess({required this.conversation});
}

class ConversationLoadFailure extends ConversationState {
  final String msg;

  ConversationLoadFailure({required this.msg});
}

class ConversationCreationSuccess extends ConversationState {
  final String conversationId;

  ConversationCreationSuccess({required this.conversationId});
}

class ConversationCreationInProgress extends ConversationState {}

class ConversationCreationFailure extends ConversationState {
  final String msg;

  ConversationCreationFailure({required this.msg});
}

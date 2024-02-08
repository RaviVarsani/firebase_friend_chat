part of 'message_receiver_bloc.dart';

abstract class MessageReceiverEvent extends Equatable {
  MessageReceiverEvent();

  @override
  List<Object> get props => [];
}

class MessageRequested extends MessageReceiverEvent {
  final String conversationId;

  MessageRequested({required this.conversationId});
}

class MessageReceived extends MessageReceiverEvent {
  final List<MessageModel?> messageModel;

  MessageReceived({required this.messageModel});
}

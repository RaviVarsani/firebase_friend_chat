import 'package:equatable/equatable.dart';
import 'package:friend_chat/model/message_model.dart';

abstract class MessageSenderEvent extends Equatable {
  MessageSenderEvent();

  @override
  List<Object> get props => [];
}

class MessageSend extends MessageSenderEvent {
  final MessageModel messageModel;

  MessageSend({required this.messageModel});
}

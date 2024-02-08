part of 'message_receiver_bloc.dart';

abstract class MessageReceiverState extends Equatable {
  MessageReceiverState();

  List<Object> get props => [];
}

class MessageReceiverInitial extends MessageReceiverState {}

class MessageLoadInProgress extends MessageReceiverState {}

class MessageLoadSuccess extends MessageReceiverState {
  final List<MessageModel?> messageModel;

  MessageLoadSuccess({required this.messageModel});

  @override
  List<Object> get props => [messageModel];
}

class MessageLoadFailure extends MessageReceiverState {
  final String msg;

  MessageLoadFailure({required this.msg});
}

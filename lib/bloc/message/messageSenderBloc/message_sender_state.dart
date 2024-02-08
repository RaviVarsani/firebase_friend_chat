import 'package:equatable/equatable.dart';

abstract class MessageSenderState extends Equatable {
  MessageSenderState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageSenderState {}

class MessageSendSuccess extends MessageSenderState {}

class MessageSendFailure extends MessageSenderState {
  final String msg;

  MessageSendFailure({required this.msg});
}

class MessageSendInProgress extends MessageSenderState {}

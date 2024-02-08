import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:friend_chat/repository/message_repository.dart';

import 'message_sender_event.dart';
import 'message_sender_state.dart';

class MessageSenderBloc extends Bloc<MessageSenderEvent, MessageSenderState> {
  final MessageRepository messageRepository;

  MessageSenderBloc(this.messageRepository) : super(MessageInitial()) {
    on<MessageSend>(_onMessageSendToState);
  }

  FutureOr<void> _onMessageSendToState(
      MessageSend event, Emitter<MessageSenderState> emit) async {
    try {
      emit(MessageSendInProgress());

      await messageRepository.sendMessage(messageModel: event.messageModel);

      emit(MessageSendSuccess());
    } on Exception catch (e, trace) {
      log('$e $trace');

      emit(MessageSendFailure(msg: e.toString()));
    }
  }
}

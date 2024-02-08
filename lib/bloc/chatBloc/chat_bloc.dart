import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_chat/repository/chat_repository.dart';

import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  ChatBloc(this.chatRepository) : super(ChatInitial()) {
    on<ChatRequested>(_onChatListRequested);
  }

  FutureOr<void> _onChatListRequested(
      ChatRequested event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoadInProgress());
      final chats = await chatRepository.getChats(loginUID: event.loginUID);
      emit(ChatLoadSuccess(chats: chats));
    } on Exception catch (e, trace) {
      log('Loading chats $e $trace');
      emit(ChatLoadFailure(msg: 'Unable to Load message'));
    }
  }
}

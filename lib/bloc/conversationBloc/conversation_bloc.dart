import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_chat/model/conversation_model.dart';
import 'package:friend_chat/repository/conversation_repository.dart';

import 'conversation_event.dart';
import 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final ConversationRepository conversationRepository;

  ConversationBloc(this.conversationRepository) : super(ConversationInitial()) {
    on<ConversationCreated>(_onConversationCreated);
    on<ConversationDetailRequested>(_onConversationDetailRequested);
  }

  FutureOr<void> _onConversationCreated(
      ConversationCreated event, Emitter<ConversationState> emit) async {
    try {
      emit(ConversationCreationInProgress());

      final conversationId = await conversationRepository.createConversation(
          conversationModel: event.conversation);

      emit(ConversationCreationSuccess(conversationId: conversationId));
    } catch (e) {
      log('Issue create conversation ${e.toString()}');

      emit(ConversationCreationFailure(
          msg: 'Unable to create new conversation ${e.toString()}'));
    }
  }

  FutureOr<void> _onConversationDetailRequested(
      ConversationDetailRequested event,
      Emitter<ConversationState> emit) async {
    try {
      emit(ConversationLoadInProgress());
      final conversationDetail = await conversationRepository.getConversation(
          senderID: event.loginUser.uid, receiverID: event.receiver.uid);

      if (conversationDetail != null) {
        emit(ConversationLoadSuccess(conversation: conversationDetail));
      } else {
        add(
          ConversationCreated(
            conversation: ConversationModel(
              creator: event.loginUser,
              receiver: event.receiver,
              members: [event.loginUser.uid, event.receiver.uid],
            ),
          ),
        );
      }
    } catch (e, stackTrace) {
      log('${e.toString()}');
      log('${stackTrace.toString()}');
      emit(
        ConversationLoadFailure(msg: 'Unable to load Conversation.'),
      );
    }
  }
}

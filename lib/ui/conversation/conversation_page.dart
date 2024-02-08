import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_chat/model/user_model.dart';
import 'package:friend_chat/provider/conversation_provider.dart';
import 'package:friend_chat/repository/conversation_repository.dart';

import '../../bloc/conversationBloc/conversation_bloc.dart';
import '../../bloc/conversationBloc/conversation_event.dart';
import 'conversation_view.dart';

class ConversationPage extends StatelessWidget {
  final String? conversationId;
  final UserModel sender;
  final UserModel receiver;

  ConversationPage({
    Key? key,
    this.conversationId,
    required this.sender,
    required this.receiver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConversationBloc(
        ConversationRepository(
          conversationProvider:
              ConversationProvider(firestore: FirebaseFirestore.instance),
        ),
      )..add(
          ConversationDetailRequested(loginUser: sender, receiver: receiver),
        ),
      child: ConversationView(loginUser: sender, receiver: receiver),
    );
  }
}

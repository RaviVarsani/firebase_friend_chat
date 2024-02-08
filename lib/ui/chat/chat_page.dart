import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_chat/model/user_model.dart';
import 'package:friend_chat/provider/chat_provider.dart';
import 'package:friend_chat/repository/chat_repository.dart';

import '../../bloc/chatBloc/chat_bloc.dart';
import '../../bloc/chatBloc/chat_event.dart';
import 'chat_view.dart';

class ChatPage extends StatelessWidget {
  final UserModel authenticatedUser;

  ChatPage({Key? key, required this.authenticatedUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(
        ChatRepository(
          chatProvider: ChatProvider(firestore: FirebaseFirestore.instance),
        ),
      )..add(
          ChatRequested(loginUID: authenticatedUser.uid),
        ),
      child: ChatView(authenticatedUser: authenticatedUser),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_chat/model/user_model.dart';
import 'package:friend_chat/provider/message_provider.dart';
import 'package:friend_chat/repository/message_repository.dart';
import 'package:friend_chat/ui/conversation/message_sender_view.dart';
import 'package:friend_chat/utilities/app_assets.dart';

import '../../bloc/message/messageReceiverBloc/message_receiver_bloc.dart';
import '../../bloc/message/messageSenderBloc/message_sender_bloc.dart';
import 'conversation_message_view.dart';

class ConversationMainView extends StatelessWidget {
  final UserModel loginUser;
  final UserModel receiver;
  final String conversationId;

  ConversationMainView({
    Key? key,
    required this.loginUser,
    required this.receiver,
    required this.conversationId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(Assets.chatBackground),
        fit: BoxFit.cover,
        opacity: .5,
      )),
      child: Column(
        children: [
          Expanded(
            child: BlocProvider(
              create: (context) => MessageReceiverBloc(
                messageRepository: MessageRepository(
                  messageProvider:
                      MessageProvider(firestore: FirebaseFirestore.instance),
                ),
              )..add(
                  MessageRequested(conversationId: conversationId),
                ),
              child: ConversationMessageView(
                  loginUser: loginUser, receiver: receiver),
            ),
          ),
          BlocProvider(
            create: (context) => MessageSenderBloc(
              MessageRepository(
                messageProvider: MessageProvider(
                  firestore: FirebaseFirestore.instance,
                ),
              ),
            ),
            child: ConversationSenderView(
              conversationId: conversationId,
              senderUID: loginUser.uid,
              receiverUID: receiver.uid,
              receiverName: receiver.displayName,
            ),
          )
        ],
      ),
    );
  }
}

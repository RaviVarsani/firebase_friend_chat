import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friend_chat/model/user_model.dart';
import 'package:friend_chat/utilities/app_strings.dart';

import '../../bloc/conversationBloc/conversation_bloc.dart';
import '../../bloc/conversationBloc/conversation_state.dart';
import 'conversation_main_view.dart';

class ConversationView extends StatelessWidget {
  final UserModel loginUser;
  final UserModel receiver;

  ConversationView({Key? key, required this.loginUser, required this.receiver})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                  radius: 17,
                  backgroundImage: NetworkImage(receiver.photoUrl),
                  backgroundColor: Colors.transparent),
              SizedBox(width: 10),
              Text(receiver.displayName),
            ],
          ),
        ),
        body: BlocBuilder<ConversationBloc, ConversationState>(
          builder: (context, state) {
            if (state is ConversationLoadSuccess) {
              return ConversationMainView(
                  loginUser: loginUser,
                  receiver: receiver,
                  conversationId: state.conversation.id ?? '');
            } else if (state is ConversationCreationSuccess) {
              return ConversationMainView(
                loginUser: loginUser,
                receiver: receiver,
                conversationId: state.conversationId,
              );
            } else if (state is ConversationLoadInProgress ||
                state is ConversationCreationInProgress) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ConversationLoadFailure ||
                state is ConversationCreationFailure) {
              return Text(AppStrings.unableToLoadConversation);
            }
            return Text('${state.runtimeType}');
          },
        ));
  }
}
